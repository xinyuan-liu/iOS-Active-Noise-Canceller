//
//  AudioProcess.m
//  Active-Noise-Canceller
//
//  Created by liuxinyuan on 16/4/17.
//  Copyright © 2016年 liuxinyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

void process(void *input_buffer, void *output_buffer, size_t buffer_size)
{
    //printf("%d\n",buffer_size);
    short * input =(short *)input_buffer;
    short * output =(short *)output_buffer;
    for(int i=0;i<buffer_size/2;i++)
    {
        //printf("%d\n",(int)(*input));
        *output=-(*input);
        output++;
        input++;
    }
    //memcpy(output_buffer, input_buffer, buffer_size);
}
