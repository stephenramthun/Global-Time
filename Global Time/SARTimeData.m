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

@interface SARTimeData ()

@property (nonatomic, readwrite) NSInteger offsetInSeconds;

@property (nonatomic) NSString *places;
@property (nonatomic) NSString *geocoding;
@property (nonatomic) NSString *timezones;

@property (nonatomic) NSDictionary *apiKeys;
@property (nonatomic) NSDictionary *apiPaths;

@property (nonatomic) NSDictionary *apiHandlers;

@end

@implementation SARTimeData

- (instancetype)init {
  if (self = [super init]) {
    _places    = @"place";
    _geocoding = @"geocode";
    _timezones = @"timezones";
    
    NSDictionary *apiAttributes = [NSDictionary dictionaryWithContentsOfFile:@"/Users/stephenramthun/keys/google/global-time.plist"];
    _apiKeys  = [apiAttributes valueForKey:@"keys"];
    _apiPaths = [apiAttributes valueForKey:@"paths"];
    
    _apiHandlers = @{_places:    [[SARPlacesAPIHandler alloc]    initWithKey:[_apiKeys valueForKey:_places]],
                     _geocoding: [[SARGeocodingAPIHandler alloc] initWithKey:[_apiKeys valueForKey:_geocoding]],
                     _timezones: [[SARTimeZoneAPIHandler alloc]  initWithKey:[_apiKeys valueForKey:_timezones]]};
  }
  return self;
}

#pragma mark - Public Interface

- (void)makeAPICallWithInput:(NSString *)input {
  //[self makeAPICallWithType:SARAPICallTypePlaces input:input];
  SARAPIHandler *places = [self.apiHandlers valueForKey:self.places];
  [self makeAPICallWithHandler:places input:input];
}

#pragma mark - Private Interface

- (void)makeAPICallWithHandler:(SARAPIHandler *)handler input:(NSString *)input {
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  
  void (^completionHandler)(NSData *, NSURLResponse *, NSError *) = ^(NSData *data, NSURLResponse *response, NSError *error){
    NSLog(@"Received data: %@", data);
  };
  
  NSString        *urlString = [NSString stringWithFormat:[handler buildURLString], input];
  NSURLSession      *session = [NSURLSession sessionWithConfiguration:configuration];
  NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:completionHandler];
  [task resume];
}

/*
 - (void)sendRequestWithURL:(NSURL *)url responseType:(NSString *)responseType apiType:(SARAPICallType)apiType {
 NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
 
 NSURLSession          *session = [NSURLSession sessionWithConfiguration:configuration];
 NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
 [self parseData:data to:responseType apiType:apiType];
 }];
 
 [dataTask resume];
 }
 */

// Makes an API-call of a given type with supplied user input.
// @param type    which api to use, e.g. "places"
// @param input   user-input to use with call
- (void)makeAPICallWithType:(SARAPICallType)type input:(NSString *)input {
  /*
  NSString *typeString = [self stringWithAPICallType:type];
  NSURL    *url        = [self buildURLWithAPI:typeString
                                         input:input
                                  responseType:@"json"];
   */
  //[self sendRequestWithURL:url responseType:@"json" apiType:type];
}

- (NSString *)stringWithAPICallType:(SARAPICallType)type {
  switch (type) {
    case SARAPICallTypePlaces:
      return self.places;
      
    case SARAPICallTypeGeocoding:
      return self.geocoding;
      
    case SARAPICallTypeTimeZones:
      return self.timezones;
  }
}

- (void)sendRequestWithURL:(NSURL *)url responseType:(NSString *)responseType apiType:(SARAPICallType)apiType {
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  
  NSURLSession          *session = [NSURLSession sessionWithConfiguration:configuration];
  NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    [self parseData:data to:responseType apiType:apiType];
  }];
  
  [dataTask resume];
}

// Builds a URL-string with given arguments and returns an NSURL-object based on this string.
// @param api           type of api to use, e.g. "places"
// @param input         user input to base API-call on
// @param responseType  datatype of response, usually either "json" or "xml"
- (NSURL *)buildURLWithAPI:(NSString *)api input:(NSString *)input responseType:(NSString *)responseType {
  NSString *base      = @"https://maps.googleapis.com/maps/api/";
  NSString *key       = [self.apiKeys valueForKey:api];
  NSString *path      = [NSString stringWithFormat:[self.apiPaths valueForKey:api], responseType, input];
  NSString *urlString = [NSString stringWithFormat:@"%@%@key=%@", base, path, key];
  
  return [NSURL URLWithString:urlString];
}

// Parse response from API-calls.
// @param data  data to parse
// @param type  type of object to parse data into, e.g. "json"
// @return      YES if data was successfully parsed, NO if otherwise
- (BOOL)parseData:(NSData *)data to:(NSString *)type apiType:(SARAPICallType)apiType {
  NSError *error;
  id object;
  
  if ([type isEqualToString:@"json"]) {
    object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
      NSLog(@"JSON was malformed, could not parse data.");
      return NO;
    }
    // JSON-parsing was a success. Use result in building a series of api-calls.
    SEL selector = [self selectorForAPICallType:apiType];
    [self performSelector:selector withObject:object];
    return YES;
    
  } else if ([type isEqualToString:@"xml"]) {
    // Requested response is XML
    // I don't currently need XML-parsing, but it may come in handy in the future.
  }
  // Error
  NSLog(@"parseData: Invalid argument passed for \"type\": %@", type);
  return NO;
}

#pragma mark - Chaining API Calls

- (SEL)selectorForAPICallType:(SARAPICallType)type {
  switch (type) {
    case SARAPICallTypePlaces:
      return @selector(placesAPICall:);
      
    case SARAPICallTypeGeocoding:
      return @selector(geocodeAPICall:);
      
    case SARAPICallTypeTimeZones:
      return @selector(timeZonesAPICall:);
  }
}

- (void)placesAPICall:(id)response {
  NSDictionary *dictionary = response;
  NSString *cityAndCountry = [[[dictionary valueForKey:@"predictions"] valueForKey:@"description"] firstObject];
  NSArray *components      = [cityAndCountry componentsSeparatedByString:@", "];
  
  [self makeAPICallWithType:SARAPICallTypeGeocoding input:[components firstObject]];
  self.fullLocationName = cityAndCountry;
}

- (void)geocodeAPICall:(id)response {
  NSDictionary *dictionary = response;
  NSDictionary *location   = [[[dictionary valueForKey:@"results"] valueForKey:@"geometry"] valueForKey:@"location"];

  NSString *locationString = [NSString stringWithFormat:@"%@,%@",
                              [[location valueForKey:@"lat"] firstObject],
                              [[location valueForKey:@"lng"] firstObject]];
  
  NSDate *now              = [NSDate date];
  NSTimeInterval interval  = [now timeIntervalSince1970];
  NSString *combinedString = [NSString stringWithFormat:@"%@&timestamp=%ld", locationString, (long)interval];
  
  [self makeAPICallWithType:SARAPICallTypeTimeZones input:combinedString];
}

- (void)timeZonesAPICall:(id)response {
  NSInteger localOffset  = [[NSTimeZone localTimeZone] secondsFromGMT];
  NSInteger DSTOffset    = [[response valueForKey:@"dstOffset"] longValue];
  NSInteger remoteOffset = [[response valueForKey:@"rawOffset"] longValue];
  
  self.offsetInSeconds   = localOffset - (remoteOffset + DSTOffset);
  [[NSNotificationCenter defaultCenter] postNotificationName:@"SARTimeData" object:self];
}

@end
