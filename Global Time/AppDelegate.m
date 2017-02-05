//
//  AppDelegate.m
//  Global Time
//
//  Created by Stephen Ramthun on 03/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (readwrite, weak) IBOutlet NSWindow *window;
@property (readwrite)       SARStatusBarClock *clock;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.clock = [[SARStatusBarClock alloc] init];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    
    
}

@end
