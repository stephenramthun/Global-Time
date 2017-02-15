//
//  SARClockViewController.m
//  Global Time
//
//  Created by Stephen Ramthun on 04/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARClockViewController.h"
#import "SARClockController.h"

@interface SARClockViewController ()

@property (nonatomic, weak) NSTextField       *clock;
@property (nonatomic, weak) SARClockController *statusBarClock;

@end

@implementation SARClockViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  NSLog(@"View loaded");
}

- (void)userDidEnterText:(NSString *)text {
  NSLog(@"Entered text: %@", text);
}

- (void)sendRequestWithString:(NSString *)string andType:(NSString *)type {
    
    //SARRequestHandler *requestHandler = [[SARRequestHandler alloc] initWithDelegate:self];
    //[requestHandler sendRequestOfType:type withInput:string];
}

- (void)receivedResponse:(id)response {
    NSLog(@"Received response: %@", response);
    
}

@end
