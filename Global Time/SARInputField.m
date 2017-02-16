//
//  SARInputField.m
//  Global Time
//
//  Created by Stephen Ramthun on 04/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

const int kNumberOfVisibleItems = 0;

#import "SARInputField.h"

@interface SARInputField()

@end

@implementation SARInputField

- (void)textDidEndEditing:(NSNotification *)notification {
  if (self.stringValue.length < 1) {
    return;
  }
  SEL selector = NSSelectorFromString(@"userEnteredString:");
  if ([self.delegate respondsToSelector:selector]) {
    [self.delegate performSelector:selector withObject:self.stringValue];
  }
}

- (void)drawRect:(NSRect)dirtyRect {
  [super drawRect:dirtyRect];
  
  [[NSColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2] setFill];
  
  NSRect rect        = NSMakeRect(0.0, 0.0, NSWidth(self.frame), NSHeight(self.frame));
  CGFloat radius     = 3.0;
  NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:rect xRadius:radius yRadius:radius];
  [path fill];
}

@end
