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
    memcpy(output_buffer, input_buffer, buffer_size);
}
