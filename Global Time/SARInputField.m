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

@property (readwrite, strong) SARInputFieldDataSource *inputFieldDataSource;
           
@end

@implementation SARInputField

- (instancetype)initWithFrame:(NSRect)frameRect {
    if (self = [super initWithFrame:frameRect]) {
        self.usesDataSource       = YES;
        self.completes            = YES;
        self.numberOfVisibleItems = kNumberOfVisibleItems;
        self.inputFieldDataSource = [[SARInputFieldDataSource alloc] init];
        self.dataSource           = self.inputFieldDataSource;
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
