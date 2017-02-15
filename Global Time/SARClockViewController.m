//
//  SARClockViewController.m
//  Global Time
//
//  Created by Stephen Ramthun on 04/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARClockViewController.h"
#import "SARPlacesAPIHandler.h"
#import "SARClockController.h"
#import "SARInputField.h"

@interface SARClockViewController ()

@property (nonatomic, weak) NSTextField       *clock;
@property (nonatomic) SARClockController *statusBarClock;

- (IBAction)userDidEnterText:(id)sender;

@end

@implementation SARClockViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.statusBarClock = [[SARClockController alloc] init];
}

- (IBAction)userDidEnterText:(id)sender {
  SARInputField *inputField = sender;
  [self.statusBarClock makeAPICallWithInput:inputField.stringValue];
}

@end
