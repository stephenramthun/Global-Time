//
//  SARTimeData.m
//  Global Time
//
//  Created by Stephen Ramthun on 13/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARTimeData.h"

@interface SARTimeData ()

@property (nonatomic, readwrite) NSDate *date;
@property (nonatomic) NSDictionary *apiKeys;
@property (nonatomic) NSString *places;
@property (nonatomic) NSString *geocoding;
@property (nonatomic) NSString *timezones;

@end

@implementation SARTimeData

- (instancetype)init {
  if (self = [super init]) {
    _apiKeys   = [NSDictionary dictionaryWithContentsOfFile:@"/Users/stephenramthun/keys/google/global-time.plist"];
    _places    = @"places";
    _geocoding = @"geocoding";
    _timezones = @"timezones";
  }
  return self;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
  
}

/*
- (instancetype)initWithDelegate:(id)delegate {
  if (self = [super init]) {
 
    self.apiURLS = [NSMutableDictionary dictionary];
    [self.apiURLS insertValue:@"place/autocomplete" inPropertyWithKey:@"places"];
  }
  
  return self;
}

- (void)sendRequestOfType:(NSString *)type withInput:(NSString *)input {
  
  NSString *base      = @"https://maps.googleapis.com/maps/api/";
  NSString *api       = [self.apiURLS valueForKey:type];
  NSString *key       = [self.keys valueForKey:type];
  NSString *response  = @"json";
  NSString *urlString = [NSString stringWithFormat:@"%@%@%@?key=%@&type=(cities)&%@", base, api, response, key, input];
  
  NSURL *url = [NSURL URLWithString:urlString];
  [self sendRequestWithURL:url];
}

- (void)sendRequestWithURL:(NSURL *)url {
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    NSLog(@"GOT RESPONSE");
  }];
  
}
*/

@end
