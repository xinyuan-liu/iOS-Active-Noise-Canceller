//
//  AudioProcess.m
//  Active-Noise-Canceller
//
//  Created by liuxinyuan on 16/4/17.
//  Copyright © 2016年 liuxinyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <Accelerate/Accelerate.h>

const int log2n = 7;
const int n=128;
const int nOver2=64;

FFTSetup fftSetup;
DSPSplitComplex fft_data;
void fft_init()
{
    fftSetup = vDSP_create_fftsetup (log2n, kFFTRadix2);
    fft_data.realp = malloc(nOver2 * sizeof(float));
    fft_data.imagp = malloc(nOver2 * sizeof(float));
}

void process(void *input_buffer, void *output_buffer, size_t buffer_size)
{
    //printf("%d\n",buffer_size);
    
    vDSP_ctoz((COMPLEX*)input_buffer, 2, &fft_data, 1, nOver2);
    vDSP_fft_zrip(fftSetup, &fft_data, 1, log2n, FFT_FORWARD);
    
    
    vDSP_fft_zrip(fftSetup, &fft_data, 1, log2n, FFT_INVERSE);
    float scale = (float) 1.0 / (2 * n);
    vDSP_vsmul(fft_data.realp, 1, &scale, fft_data.realp, 1, nOver2);
    vDSP_vsmul(fft_data.imagp, 1, &scale, fft_data.imagp, 1, nOver2);
    
    
    vDSP_ztoc(&fft_data, 1, (COMPLEX*)output_buffer, 2, nOver2);
    //memcpy(output_buffer, input_buffer, buffer_size);
}

