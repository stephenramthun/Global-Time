//
//  SARClockViewController.m
//  Global Time
//
//  Created by Stephen Ramthun on 04/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARClockViewController.h"
#import "SARClockController.h"
#import "SARRequestHandler.h"

@interface SARClockViewController ()

@property (nonatomic, weak) NSTextField       *clock;
@property (nonatomic, weak) SARCityTextField  *place;
@property (nonatomic, weak) SARClockController *statusBarClock;

@end

@implementation SARClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clock = [self.view viewWithTag:1];
    self.place = [self.view viewWithTag:2];
    self.place.sctDelegate = self;
}

- (void)userDidEnterText:(NSString *)string {
    [self sendRequestWithString:string andType:@"place"];
}

- (void)sendRequestWithString:(NSString *)string andType:(NSString *)type {
    
    //SARRequestHandler *requestHandler = [[SARRequestHandler alloc] initWithDelegate:self];
    //[requestHandler sendRequestOfType:type withInput:string];
}

- (void)receivedResponse:(id)response {
    NSLog(@"Received response: %@", response);
    
}

@end
