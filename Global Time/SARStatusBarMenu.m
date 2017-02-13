//
//  SARStatusBarMenu.m
//  Global Time
//
//  Created by Stephen Ramthun on 12/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARStatusBarMenu.h"

@implementation SARStatusBarMenu

- (instancetype)init {
  if (self = [super init]) {
    [self addMenuItemWithTitle:@"Exit" action:@selector(exit:)];
  }
  return self;
}

// Create and add a menuitem to menu
- (void)addMenuItemWithTitle:(NSString *)title action:(SEL)selector {
  NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:title action:selector keyEquivalent:@""];
  menuItem.enabled = YES;
  menuItem.target  = self;
  
  [self addItem:menuItem];
}

// Quit application
- (IBAction)exit:(id)sender {
  [NSApp performSelector:@selector(terminate:) withObject:nil afterDelay:0.0];
}

@end
