//
//  SARClockViewController.h
//  Global Time
//
//  Created by Stephen Ramthun on 04/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//
//  Controller for the main view of the application's main window.
//  SARClockViewController handles user input and uses this input as
//  arguments in calling Google's Places Autocomplete API for accurately
//  guessing what city the user has typed.

#import <Cocoa/Cocoa.h>

@interface SARClockViewController : NSViewController <NSControlTextEditingDelegate>

- (void)userEnteredString:(NSString *)string;

@end
