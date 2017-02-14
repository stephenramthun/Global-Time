//
//  SARCityTextField.h
//  Global Time
//
//  Created by Stephen Ramthun on 05/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol SARCityTextFieldDelegate

- (void)userDidEnterText:(NSString *)string;

@end

@interface SARCityTextField : NSTextField

@property (nonatomic, copy) NSString *inputString;
@property (nonatomic, readwrite) id sctDelegate;

@end
