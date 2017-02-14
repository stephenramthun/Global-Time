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
