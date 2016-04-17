//
//  ViewController.m
//  Active-Noise-Canceller
//
//  Created by liuxinyuan on 16/4/17.
//  Copyright © 2016年 liuxinyuan. All rights reserved.
//

#import "ViewController.h"
#import "IosAudioController.h"

@implementation ViewController


/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    //[startButton addTarget:self action:@selector(startButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    //[stopButton addTarget:self action:@selector(stopButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    iosAudio = [[IosAudioController alloc] init];
    printf("tag1\n");
    [iosAudio start];
    printf("tag2\n");
}

- (void)startButtonTapped {
    
}

- (void)stopButtonTapped {

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
