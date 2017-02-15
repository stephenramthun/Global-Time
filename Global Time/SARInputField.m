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

- (instancetype)initWithCoder:(NSCoder *)coder {
  if (self = [super initWithCoder:coder]) {
    if ([self respondsToSelector:@selector(setInsertionPointColor:)]){
      NSLog(@"Responding");
      [self performSelector:@selector(setInsertionPointColor:) withObject:[NSColor whiteColor]];
    }
  }
  return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
  if (self = [super initWithFrame:frameRect]) {
  }
    
  return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
