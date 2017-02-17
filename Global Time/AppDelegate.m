//
//  AppDelegate.m
//  Global Time
//
//  Created by Stephen Ramthun on 03/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (nonatomic) IBOutlet NSWindow *window;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  self.window.titleVisibility = NSWindowTitleHidden;
  self.window.titlebarAppearsTransparent = YES;
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
  [self.window orderFront:self.window];
}

- (void)applicationWillTerminate:(NSNotification *)notification {
  self.window = nil;
}

@end
