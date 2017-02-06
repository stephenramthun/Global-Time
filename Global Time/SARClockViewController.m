//
//  SARClockViewController.m
//  Global Time
//
//  Created by Stephen Ramthun on 04/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARClockViewController.h"

@interface SARClockViewController ()

@property (nonatomic, weak) NSTextField *clock;
@property (nonatomic, weak) NSTextField *place;

@end

@implementation SARClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clock = [self.view viewWithTag:1];
    self.place = [self.view viewWithTag:2];
    
    //self.place.delegate = self;
}

@end
