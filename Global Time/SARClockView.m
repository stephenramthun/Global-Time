//
//  SARClockView.m
//  Global Time
//
//  Created by Stephen Ramthun on 14/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARClockView.h"

@implementation SARClockView

- (void)drawRect:(NSRect)dirtyRect {
  [super drawRect:dirtyRect];
  
  NSColor *fillColor = [NSColor colorWithRed:0.15 green:0.13 blue:0.19 alpha:1.0];
  NSBezierPath *path = [NSBezierPath bezierPathWithRect:self.frame];
  [fillColor setFill];
  [path fill];
  
}

@end
