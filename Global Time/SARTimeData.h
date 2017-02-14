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

@property (nonatomic, readonly) NSDate *date;
@property (nonatomic, readonly, copy) NSString *places;
@property (nonatomic, readonly, copy) NSString *geocoding;
@property (nonatomic, readonly, copy) NSString *timezones;

- (void)makeAPICallWithType:(SARAPICallType)type input:(NSString *)input;
- (NSString *)city;

@end
