//
//  SARClockController.h
//  Global Time
//
//  Created by Stephen Ramthun on 03/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//
//
//  SARClockController functions as a controller for an NSStatusItem,
//  displaying time of a specific time zone in the macOS system status bar.
//
//  The time displayed is provided by a model object of type SARTimeData.

#import <Cocoa/Cocoa.h>
@class SARTimeData;

@interface SARClockController : NSObject

@property (nonatomic, readonly) SARTimeData *timeData;

@end
