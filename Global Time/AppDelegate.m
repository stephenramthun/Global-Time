//
//  AppDelegate.m
//  Global Time
//
//  Created by Stephen Ramthun on 03/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "AppDelegate.h"
#import "SARClockList.h"
#import "SARClockViewController.h"
#import "SARClockController.h"

@interface AppDelegate ()

@property (nonatomic, weak) IBOutlet NSWindow *window;
@property (nonatomic) NSMutableArray *clocks;
@property (nonatomic) SARClockList *clockList;
@property (nonatomic) SARClockController *clockController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  
  //_clockController = [[SARClockController alloc] init];
  
    //self.clockList = [[SARClockList alloc] initWithFrame:self.window.contentView.frame];
    
    //[self.window.contentView addSubview:self.clockList];
    //[self addClock];
}

@end
