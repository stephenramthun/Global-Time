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
//  - Google Places Autocomplate (parsing user input, called from SARClockViewController)
//  - Google Geocoding           (using result from Places to get coordinates)
//  - Google Time Zones          (using coordinates to get time zone)
//

#import <Cocoa/Cocoa.h>

@interface SARClockController : NSObject

@property (nonatomic) NSString *placeName;
@property (nonatomic, readonly) NSString *timeZoneName;
@property (nonatomic, readonly) NSString *dateString;

- (void)sendRequestWithArguments:(NSString *)arguments;

@end
