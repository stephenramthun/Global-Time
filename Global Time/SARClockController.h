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
//  The time to display is calculated using chained calls to three Google APIs:
//  - Google Places Autocomplate (parsing user input)
//  - Google Geocoding           (using result from Places to get coordinates)
//  - Google Time Zones          (using coordinates to get time zone)
//
//  These API calls are provided by the model class SARTimeZoneData, which uses
//  three instances of SARAPIHandler to facilitate communication with the APIs.

#import <Cocoa/Cocoa.h>
@class SARTimeData;

@interface SARClockController : NSObject

- (void)makeAPICallWithInput:(NSString *)input;

@end
