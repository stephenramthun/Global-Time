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
 * Builds a URL string based on an api-key, a base string and arguments.
 *
 * @return  NSString representing a URL
 */
- (NSString *)buildURLString {
  if (!self.key) {
    return nil;
  }
  
  NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
  NSString *base           = @"https://maps.googleapis.com/maps/api/timezone/json?";  // %@ at the end is for inserting user input
  NSString *arguments      = @"location=%@";
  NSString *urlString      = [NSString stringWithFormat:@"%@%@&timestamp=%ld&key=%@", base, arguments, (long)timeStamp, self.key];
  return urlString;
}

/**
 * Takes as an argument a JSON response from Google's Time Zones API, parses it, 
 * and returns an NSTimeZone containing the time zone from the result.
 *
 * @param data  JSON data obtained from an API request to Google's Time Zones API.
 */
- (NSString *)parseJSONData:(NSData *)data {
  NSDictionary *objects  = [self dictionaryFromJSONData:data];
  NSString *timeZoneName = [objects valueForKey:@"timeZoneId"];
  return timeZoneName;
}

@end
