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
    
    BOOL result = [super becomeFirstResponder];
    
    if (result) {
        NSTextView *textField = (NSTextView *)[self currentEditor];
        [textField setInsertionPointColor:[NSColor whiteColor]];
    }
    
    if (self.assigned == NO) {
        self.stringValue = @"";
        self.assigned = YES;
    }
    
    return result;
}
 
- (void)textDidEndEditing:(NSNotification *)notification {
    [self.sctDelegate userDidEnterText:self.stringValue];
}

@end
