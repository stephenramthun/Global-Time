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

// Keys for dictionary
@property (nonatomic) NSString *places;
@property (nonatomic) NSString *geocoding;
@property (nonatomic) NSString *timezones;

// Classes responsible for building API-requests and parsing responses from web services.
@property (nonatomic) NSDictionary *apiHandlers;

@property (nonatomic, readwrite) NSTimeZone *timeZone;
@property (nonatomic, readwrite) NSString *locationName;

@end

@implementation SARTimeData

- (instancetype)init {
  if (self = [super init]) {
    _places    = @"place";
    _geocoding = @"geocode";
    _timezones = @"timezones";
    
    NSDictionary *apiKeys       = [NSDictionary dictionaryWithContentsOfFile:@"/Users/stephenramthun/keys/google/global-time.plist"];
    
    _apiHandlers = @{_places:    [[SARPlacesAPIHandler alloc]    initWithKey:[apiKeys valueForKey:_places]],
                     _geocoding: [[SARGeocodingAPIHandler alloc] initWithKey:[apiKeys valueForKey:_geocoding]],
                     _timezones: [[SARTimeZoneAPIHandler alloc]  initWithKey:[apiKeys valueForKey:_timezones]]};
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
    [self delegateData:data withHandler:handler];
  };
  
  NSString        *urlString = [NSString stringWithFormat:[handler buildURLString], input];
  NSURLSession      *session = [NSURLSession sessionWithConfiguration:configuration];
  NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:completionHandler];
  [task resume];
}

- (void)delegateData:(NSData *)data withHandler:(SARAPIHandler *)handler {
  NSString *parsedString = [handler parseJSONData:data];
  
  if ([handler isKindOfClass:[SARPlacesAPIHandler class]]) {
    [self makeAPICallWithHandler:[self.apiHandlers valueForKey:self.geocoding] input:parsedString];
    
  } else if ([handler isKindOfClass:[SARGeocodingAPIHandler class]]) {
    [self makeAPICallWithHandler:[self.apiHandlers valueForKey:self.timezones] input:parsedString];
    
  } else if ([handler isKindOfClass:[SARTimeZoneAPIHandler class]])  {
    NSLog(@"Time Zone: %@", parsedString);
  }
}

@end
