//
//  SARInputField.m
//  Global Time
//
//  Created by Stephen Ramthun on 04/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

const int kNumberOfVisibleItems = 15;

#import "SARInputField.h"

@implementation SARInputField

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self.usesDataSource = YES;
        self.completes      = YES;
        self.numberOfVisibleItems = kNumberOfVisibleItems;
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
