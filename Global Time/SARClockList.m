//
//  SARClockList.m
//  Global Time
//
//  Created by Stephen Ramthun on 04/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARClockList.h"

@implementation SARClockList

- (instancetype)initWithFrame:(NSRect)frameRect {
    if (self = [super initWithFrame:frameRect]) {
        NSLog(@"init clock list");
        
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    [[NSColor colorWithRed:0.15 green:0.1 blue:0.15 alpha:1.0] setFill];
    NSRectFill(dirtyRect);
}

@end
