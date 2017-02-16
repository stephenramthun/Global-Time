//
//  SARTimeData.m
//  Global Time
//
//  Created by Stephen Ramthun on 13/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARTimeData.h"
#import "SARPlacesAPIHandler.h"
#import "SARGeocodingAPIHandler.h"
#import "SARTimeZoneAPIHandler.h"
#import "SARAPIKeyManager.h"

@interface SARTimeData ()

// Objects responsible for building API-requests and parsing responses from web services.
@property (nonatomic) NSDictionary *apiHandlers;

// Data attributes
@property (nonatomic, readwrite) NSTimeZone *timeZone;
@property (nonatomic, readwrite) NSString *locationName;

@end

@implementation SARTimeData

- (instancetype)init {
  if (self = [super init]) {
    SARAPIKeyManager *keyManager = [SARAPIKeyManager sharedAPIKeyManager];
    
    NSString *geocoding = [keyManager nameForAPIType:SARAPITypeGeocoding];
    NSString *timezones = [keyManager nameForAPIType:SARAPITypeTimeZones];
    
    _apiHandlers = @{geocoding: [[SARGeocodingAPIHandler alloc] initWithKey:[keyManager keyForAPIType:SARAPITypeGeocoding]],
                     timezones: [[SARTimeZoneAPIHandler alloc]  initWithKey:[keyManager keyForAPIType:SARAPITypeTimeZones]]};
  }
  return self;
}

#pragma mark - Public Interface

/**
 * Makes a call to Google's Geocoding and Time Zones APIs to get the local
 * time for a time zone based on user input.
 *
 * @param input   user input used as arguments in the API call.
 */
- (void)setupClockWithInput:(NSString *)input {
  /*
  SARAPIHandler *places = [self.apiHandlers valueForKey:self.places];
  [self makeAPICallWithHandler:places input:[self purgeString:input]];
   */
}

#pragma mark - Private Interface

/**
 * Decide what to do with received data from API calls, e.g. if data received is 
 * from the Google Places API, then SARGeocodingAPIHandler needs to use that data 
 * as input in making a request to Google's Geocoding API. What this does is 
 * basically chaining API-calls together.
 *
 * @param data      data received from an API call
 * @param handler   the SARAPIHandler that made the API call
 */
- (void)delegateData:(NSData *)data withHandler:(SARAPIHandler *)handler {
  NSString *parsedString = [handler parseJSONData:data];
  //NSString *purgedString = [self purgeString:parsedString];
  
  if ([handler isKindOfClass:[SARPlacesAPIHandler class]]) {
    self.locationName = parsedString;
    //[self makeAPICallWithHandler:[self.apiHandlers valueForKey:self.geocoding] input:purgedString];
    
  } else if ([handler isKindOfClass:[SARGeocodingAPIHandler class]]) {
    //[self makeAPICallWithHandler:[self.apiHandlers valueForKey:self.timezones] input:purgedString];
    
  } else if ([handler isKindOfClass:[SARTimeZoneAPIHandler class]])  {
    //self.timeZone = [NSTimeZone timeZoneWithName:parsedString];
  }
}

/**
 * Takes a string argument and return a string without spaces.
 *
 * @param string  string to purge of spaces.
 */
- (NSString *)purgeString:(NSString *)string {
  return [string stringByReplacingOccurrencesOfString:@" " withString:@"_"];
}

@end
