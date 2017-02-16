//
//  SARClockViewController.h
//  Global Time
//
//  Created by Stephen Ramthun on 04/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SARClockViewController : NSViewController <NSControlTextEditingDelegate>

- (void)userEnteredString:(NSString *)string;

@end
