//
//  AppDelegate.m
//  Global Time
//
//  Created by Stephen Ramthun on 03/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

// KEYS - DELETE BEFORE PUBLISHING CODE
//
// Google Places:     AIzaSyC2hcNriRbvlCxGKN6_CM2ij0jj1sAd5hM
// Google Time Zones: AIzaSyAYbym6feYlr7vakttlcqyFeVgKBy585XU
// Google Geocoding:  AIzaSyAgA-Yal7w7z-7AbszDk-4FOqsPVDZ96H4

#import "AppDelegate.h"

@interface AppDelegate ()

@property (readwrite, weak) IBOutlet NSWindow *window;
@property (readwrite)       SARStatusBarClock *clock;
@property (readwrite)       SARClockList      *clockList;
@property (readwrite)       NSMutableArray    *clocks;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    self.clock     = [[SARStatusBarClock alloc] init];
    self.clockList = [[SARClockList alloc] initWithFrame:self.window.contentView.frame];
    
    [self.window.contentView addSubview:self.clockList];
    [self addClock];
}

- (void)addClock {
    SARClockViewController *clockViewController = [[SARClockViewController alloc] initWithNibName:@"Clock" bundle:[NSBundle mainBundle]];
    [self.clocks  addObject:clockViewController];
    [self.clockList addView:clockViewController.view inGravity:NSStackViewGravityBottom];
}

@end
