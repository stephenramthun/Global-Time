//
//  SARCityTextField.m
//  Global Time
//
//  Created by Stephen Ramthun on 05/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARCityTextField.h"

@interface SARCityTextField()

@property (nonatomic, assign) BOOL assigned;

@end

@implementation SARCityTextField

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self.assigned = NO;
    }
    
    return self;
}

- (BOOL)becomeFirstResponder {
    if (self.assigned == NO) {
        self.stringValue = @"";
        self.assigned = YES;
    }
    return YES;
}
 
- (void)textDidEndEditing:(NSNotification *)notification {
    [self.sctDelegate userDidEnterText:self.stringValue];
}

@end
