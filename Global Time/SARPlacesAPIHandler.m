//
//  SARPlacesAPIHandler.m
//  Global Time
//
//  Created by Stephen Ramthun on 13/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARPlacesAPIHandler.h"

@implementation SARPlacesAPIHandler

/**
 * Builds a URL string based on an api-key, a base string and arguments.
 *
 * @return  NSString representing a URL
 */
- (NSString *)buildURLString {
  if (!self.key) {
    return nil;
  }
  
  NSString *base      = @"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&";  // %@ at the end is for inserting user input
  NSString *arguments = @"types=(cities)";
  return [NSString stringWithFormat:@"%@%@&key=%@", base, arguments, self.key];
}

/**
 * Takes as an argument a JSON response from Google's Places API, parses it, and returns 
 * the name of the city that most closely matches a given argument supplied by the user. 
 * While parsing the response, the method also saves the name of the city and country to 
 * SARPlacesAPIHandler's "cityAndCountry"-property.
 *
 * @param response  JSON data obtained from an API request to Google's Places API.
 */
- (NSString *)parseResponse:(id)response {
  NSString *first     = @"predictions"; // First dictionary in JSON
  NSString *second    = @"description"; // Second dictionary in JSON
  NSString *separator = @", ";
  
  NSDictionary *objects = response;
  self.cityAndCountry   = [[[objects valueForKey:first] valueForKey:second] firstObject];
  NSArray *components   = [self.cityAndCountry componentsSeparatedByString:separator];
  return [components firstObject];
}

@end
