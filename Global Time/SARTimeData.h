//
//  SARTimeData.h
//  Global Time
//
//  Created by Stephen Ramthun on 13/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//
// SARTimeData keeps track of the time in a given time zone.
// It is responsible for making API-calls and parsing the response.

#import <Foundation/Foundation.h>

@interface SARTimeData : NSObject <NSURLSessionDataDelegate>

typedef enum : NSInteger {
  SARAPICallTypePlaces,
  SARAPICallTypeGeocoding,
  SARAPICallTypeTimeZones
} SARAPICallType;

@property (nonatomic, readonly) NSTimeZone *timeZone;
@property (nonatomic, readonly) NSString *locationName;

- (void)makeAPICallWithInput:(NSString *)input;

@end
