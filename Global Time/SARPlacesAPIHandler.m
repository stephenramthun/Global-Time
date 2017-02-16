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
 * Takes as an argument JSON data from Google's Places API, parses it, and returns
 * the name of the city that most closely matches a given argument supplied by the user. 
 * While parsing the response, the method also saves the name of the city and country to 
 * SARPlacesAPIHandler's "cityAndCountry"-property.
 *
 * @param data  JSON data obtained from an API request to Google's Places API.
 */
- (NSString *)parseJSONData:(NSData *)data {
  if (data == nil) {
    NSLog(@"Error: Data was null.");
    return nil;
  }
  NSString *first     = @"predictions"; // First dictionary in JSON
  NSString *second    = @"description"; // Second dictionary in JSON
  NSString *separator = @", ";
  
  
  NSDictionary *objects = [self dictionaryFromJSONData:data];
  self.cityAndCountry   = [self findCorrectCityInDictionary:[[objects valueForKey:first] valueForKey:second]];
  NSArray *components   = [self.cityAndCountry componentsSeparatedByString:separator];
  return [components firstObject];
}

/**
 * Sometimes the Google Places Autocomplete will return JSON data that is sorted wrong.
 * E.g., when a user types the name of the Norwegian city "Bergen", the first entry in the JSON
 * will be "Bergenfield", NY. This behaviour is troubling, as someone who wants to know the time
 * in Bergen won't be able to directly do this in this program.
 *
 * This method will try to find the best match between entries in the dictionary and the user string,
 * by checking if the best match according to Google is longer than the argument, and then checking
 * each entry in the dictionary returning an entry if it's length matches the length of the argument.
 *
 * @param dictionary    dictionary to search through
 */
- (NSString *)findCorrectCityInDictionary:(NSDictionary *)dictionary {
  NSString *bestMatch = [(NSArray *)dictionary firstObject];
  
  for (id entry in dictionary) {
    NSArray *components = [entry componentsSeparatedByString:@", "];
    NSString *cityName  = [components firstObject];
    
    if ([cityName caseInsensitiveCompare:self.argument] == NSOrderedSame) {
      bestMatch = cityName;
      break;
    }
  }
  return bestMatch;
}

@end
