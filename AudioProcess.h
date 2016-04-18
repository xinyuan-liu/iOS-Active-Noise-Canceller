//
//  AudioProcess.h
//  Active-Noise-Canceller
//
//  Created by liuxinyuan on 16/4/17.
//  Copyright © 2016年 liuxinyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#define BufferSize 128


void process(void *input_buffer, void *output_buffer, size_t buffer_size);