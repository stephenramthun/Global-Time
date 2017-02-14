//
//  SARTimeData.m
//  Global Time
//
//  Created by Stephen Ramthun on 13/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARTimeData.h"

static void * const kPlacesKVOContext    = (void *)&kPlacesKVOContext;
static void * const kGeocodingKVOContext = (void *)&kGeocodingKVOContext;
static void * const kTimeZonesKVOContext = (void *)&kTimeZonesKVOContext;

@interface SARTimeData ()

@property (nonatomic, readwrite) NSDate *date;
@property (nonatomic, readwrite) NSString *places;
@property (nonatomic, readwrite) NSString *geocoding;
@property (nonatomic, readwrite) NSString *timezones;
@property (nonatomic) NSDictionary *apiKeys;
@property (nonatomic) NSDictionary *apiPaths;
@property (nonatomic) NSDictionary *apiResponse;

@end

@implementation SARTimeData

- (instancetype)init {
  if (self = [super init]) {
    _places    = @"places";
    _geocoding = @"geocode";
    _timezones = @"timezones";
    _apiKeys   = [NSDictionary dictionaryWithContentsOfFile:@"/Users/stephenramthun/keys/google/global-time.plist"];
    _apiPaths  = @{_places:    @"place/autocomplete/%@?input=%@&type=(cities)&",
                   _geocoding: @"geocode/%@?address=%@&",
                   _timezones: @""};
    
    [self makeAPICallWithType:SARAPICallTypePlaces input:@"osl"];
  }
  return self;
}

#pragma mark - Public Interface

// Makes an API-call of a given type with supplied user input.
// @param type    which api to use, e.g. "places"
// @param input   user-input to use with call
- (void)makeAPICallWithType:(SARAPICallType)type input:(NSString *)input {
  NSString *typeString = [self stringWithAPICallType:type];
  NSURL    *url        = [self buildURLWithAPI:typeString
                                         input:input
                                  responseType:@"json"];
  
  [self sendRequestWithURL:url responseType:@"json"];
  [self addObserver:self
         forKeyPath:@"self.apiResponse"
            options:NSKeyValueObservingOptionNew
            context:[self contextForAPICallType:type]];
}

#pragma mark - Private Interface

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

- (void *)contextForAPICallType:(SARAPICallType)type {
  switch (type) {
    case SARAPICallTypePlaces:
      return kPlacesKVOContext;
      
    case SARAPICallTypeGeocoding:
      return kGeocodingKVOContext;
      
    case SARAPICallTypeTimeZones:
      return kTimeZonesKVOContext;
  }
}

- (void)sendRequestWithURL:(NSURL *)url responseType:(NSString *)responseType {
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  
  NSURLSession          *session = [NSURLSession sessionWithConfiguration:configuration];
  NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    [self parseData:data to:responseType];
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
- (BOOL)parseData:(NSData *)data to:(NSString *)type {
  NSError *error;
  id object;
  
  if ([type isEqualToString:@"json"]) {
    
    // Requested response is JSON
    object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
      NSLog(@"JSON was malformed, could not parse data.");
      return NO;
    }
    
    // Success, assign result to property
    self.apiResponse = object;
    return YES;
    
  } else if ([type isEqualToString:@"xml"]) {
    // Requested response is XML
    // Implement XML-parsing
  }
  // Error
  NSLog(@"parseData: Invalid argument passed for \"type\": %@", type);
  return NO;
}

- (NSString *)city {
  if (!self.apiResponse) {
    NSLog(@"city: No valid response");
    return @"Invalid input";
  }
  
  NSString *cityAndCountry = [[[self.apiResponse valueForKey:@"predictions"] valueForKey:@"description"] firstObject];
  NSArray *components      = [cityAndCountry componentsSeparatedByString:@", "];
  
  NSLog(@"%@", [components firstObject]);
  return [components firstObject];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
  if (context == kPlacesKVOContext) {
    NSLog(@"PLACES");
  } else if (context == kGeocodingKVOContext) {
    NSLog(@"GEOCODING");
  } else if (context == kTimeZonesKVOContext) {
    NSLog(@"TIMEZONES");
  }
  
  NSLog(@"New apiResponse: %@", change);
  [self removeObserver:self forKeyPath:keyPath context:context];
}

@end
