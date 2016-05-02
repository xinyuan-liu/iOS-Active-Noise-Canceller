//
//  AudioProcess.h
//  Active-Noise-Canceller
//
//  Created by liuxinyuan on 16/4/17.
//  Copyright © 2016年 liuxinyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Defination.h"

void process(void *input_buffer, size_t buffer_size);
void fft_init();
void get_sample(const void * s,int offset, size_t size, void * t);
void get_play_data (void *t, size_t size);
void set_offset(int offset_);