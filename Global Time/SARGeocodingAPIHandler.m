//
//  SARGeocodingAPIHandler.m
//  Global Time
//
//  Created by Stephen Ramthun on 14/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARGeocodingAPIHandler.h"

@implementation SARGeocodingAPIHandler

/**
 * Builds a URL string based on an api-key, a base string and arguments.
 *
 * @return  NSString representing a URL
 */
- (NSString *)buildURSLtring {
  if (!self.key) {
    return nil;
  }
  
  NSString *base      = @"https://maps.googleapis.com/maps/api/geocode/json?";  // %@ at the end is for inserting user input
  NSString *arguments = @"address=%@";
  return [NSString stringWithFormat:@"%@%@&key=%@", base, arguments, self.key];
}

/**
 * Takes as an argument a JSON response from Google's Geocoding API, parses it, and returns
 * the coordinates of the result.
 *
 * @param response  JSON data obtained from an API request to Google's Geocoding API.
 */
- (NSString *)parseResponse:(id)response {
  NSString *first  = @"results";  // First dictionary in JSON
  NSString *second = @"geometry"; // Second dictionary in JSON
  NSString *third  = @"location"; // Third dictionary in JSON
  
  NSDictionary *objects  = response;
  NSDictionary *location = [[[objects valueForKey:first] valueForKey:second] valueForKey:third];
  NSString *coordinates  = [NSString stringWithFormat:@"%@%@",
                            [[location valueForKey:@"lat"] firstObject],
                            [[location valueForKey:@"lng"] firstObject]];
  return coordinates;
}

@end
