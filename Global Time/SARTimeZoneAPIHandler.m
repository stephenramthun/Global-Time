//
//  SARTimeZoneAPIHandler.m
//  Global Time
//
//  Created by Stephen Ramthun on 14/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARTimeZoneAPIHandler.h"

@implementation SARTimeZoneAPIHandler

/**
 * Takes as an argument a JSON response from Google's Time Zones API, parses it, 
 * and returns an NSTimeZone containing the time zone from the result.
 *
 * @param response  JSON data obtained from an API request to Google's Time Zones API.
 */
- (NSTimeZone *)parseResponse:(id)response {
  NSString *timeZoneName = [response valueForKey:@"timeZoneId"];
  return [NSTimeZone timeZoneWithName:timeZoneName];
}

@end
