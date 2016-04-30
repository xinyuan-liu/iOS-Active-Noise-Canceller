//
//  AudioProcess.m
//  Active-Noise-Canceller
//
//  Created by liuxinyuan on 16/4/17.
//  Copyright © 2016年 liuxinyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <Accelerate/Accelerate.h>
#include "Defination.h"

const int log2n=5;
const int n=BufferSize;
const int nOver2=n/2;
FFTSetup fftSetup;
DSPSplitComplex fft_data;

typedef struct {
    void * head;
    void * brk;
    void * begin;
    float * end;
    int size;
    bool full_flag;
}mQueue;

void * output_buffer;

mQueue q;

void * pushQ(void * data,size_t data_size)
{
    void * r=q.begin;
    if(q.full_flag)
    {
        memcpy(q.end, data, data_size);
        q.end=q.begin=q.begin+data_size;
        if(q.end==q.brk)
        {
            q.end=q.begin=q.head;
        }
        
    }
    else
    {
        memcpy(q.end, data, data_size);
        q.end+=data_size;
        if(q.end==q.brk)
        {
            q.end=q.head;
            q.full_flag=1;
        }
        
    }
    return r;
}



void get_sample(const void * s,int offset, size_t size, void * t)
{
    offset<<=2;
    if(s-q.head>=offset)
    {
        memcpy(t, s, size);
    }
    else
    {
        size_t s1=q.head-(s-offset);
        if(s1<size)
        {
            size_t s2=size-s1;
            memcpy(t, q.brk-s1, s1);
            memcpy(t+s1, q.head, s2);
        }
        else
        {
            memcpy(t, q.brk-s1, size);
        }
        
    }
}

void get_sample_from_begin(void *t)
{
    get_sample(q.begin,0, n*4, t);
    
}

void get_play_data (void *t,size_t size)
{
    memcpy(t, output_buffer, size);
}

void fft_init()
{
    fftSetup = vDSP_create_fftsetup (log2n, kFFTRadix2);
    fft_data.realp = malloc(nOver2 * sizeof(float));
    fft_data.imagp = malloc(nOver2 * sizeof(float));
    
    q.size=65536*2*sizeof(float);
    q.head=(float *)malloc(q.size);
    q.end=q.begin=q.head;
    q.brk=q.head+q.size;
    q.full_flag=0;
    
    output_buffer=malloc(BufferSize*4);
}

//FFT: input_buffer -> fft_data , real to complex
void fft_forward(void *input_buffer, size_t buffer_size)
{
    vDSP_ctoz((COMPLEX*)input_buffer, 2, &fft_data, 1, nOver2);
    vDSP_fft_zrip(fftSetup, &fft_data, 1, log2n, FFT_FORWARD);
}

//IFFT: fft_data -> output_buffer, complex to real
void fft_inverse(void *output_buffer, size_t buffer_size)
{
    vDSP_fft_zrip(fftSetup, &fft_data, 1, log2n, FFT_INVERSE);
    float scale = (float) 1.0 / (2 * n);
    vDSP_vsmul(fft_data.realp, 1, &scale, fft_data.realp, 1, nOver2);
    vDSP_vsmul(fft_data.imagp, 1, &scale, fft_data.imagp, 1, nOver2);
    vDSP_ztoc(&fft_data, 1, (COMPLEX*)output_buffer, 2, nOver2);
}


void process(void *input_buffer, size_t buffer_size)
{
    //printf("%d\n",buffer_size);
    //size_t sample_num=buffer_size/sizeof(float);
    void * p;
    memset(output_buffer, 0, buffer_size);
    p=pushQ(input_buffer, buffer_size);
    
    int offset=32;
    get_sample(p,offset, buffer_size, output_buffer);
    

    vDSP_vneg(output_buffer,1,output_buffer,1,n);
    //memcpy(output_buffer, input_buffer, buffer_size);
}

