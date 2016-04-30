//
//  Defination.h
//  Active-Noise-Canceller
//
//  Created by liuxinyuan on 16/4/29.
//  Copyright © 2016年 liuxinyuan. All rights reserved.
//

#ifndef Defination_h
#define Defination_h
#define SampleRate 44100

#define BufferSize 32
#define FLOAT_FORMAT

#ifdef FLOAT_FORMAT
#define Sample_t float
#endif

#ifdef INTEGER_FORMAT
#define Sample_t short
#endif

#define FrameSize sizeof(Sample_t)

#endif /* Defination_h */
