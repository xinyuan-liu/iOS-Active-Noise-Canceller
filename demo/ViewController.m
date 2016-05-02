//
//  ViewController.m
//  demo
//
//  Created by liuxinyuan on 16/4/17.
//  Copyright © 2016年 liuxinyuan. All rights reserved.
//


#import "ViewController.h"
#import "IosAudioController.h"
#import "AudioProcess.h"

@implementation ViewController

UILabel *sliderLabel;
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    iosAudio = [[IosAudioController alloc] init];
    printf("%d\n",(int)sizeof(short));
    
    UISlider *slider = [[UISlider alloc] init];
    slider.frame = CGRectMake(55, 219, 800, 23);
    [slider addTarget:self
               action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
    sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 320, 50)];
    
    sliderLabel.text = @"0";

    [self.view addSubview:sliderLabel];

    
    [iosAudio start];
}

-(void)sliderChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    int Slider_Value = (int)(slider.value*441);
    sliderLabel.text = [NSString stringWithFormat:@"%d", Slider_Value];
    set_offset(Slider_Value);
    //NSLog([NSString stringWithFormat:@"%d", progressAsInt]);
    
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




- (void)dealloc {
    [iosAudio stop];
    [super dealloc];
}

@end
