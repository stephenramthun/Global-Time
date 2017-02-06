//
//  SARRequestHandler.m
//  Global Time
//
//  Created by Stephen Ramthun on 03/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

// KEYS - DELETE BEFORE PUBLISHING CODE
//
// Google Places:     AIzaSyC2hcNriRbvlCxGKN6_CM2ij0jj1sAd5hM
// Google Time Zones: AIzaSyAYbym6feYlr7vakttlcqyFeVgKBy585XU
// Google Geocoding:  AIzaSyAgA-Yal7w7z-7AbszDk-4FOqsPVDZ96H4

#import "SARRequestHandler.h"

@interface SARRequestHandler()

@property (nonatomic, readwrite) id <SARRequestHandlerDelegate> delegate;

@property (nonatomic, readwrite) NSMutableDictionary *keys;
@property (nonatomic, readwrite) NSMutableDictionary *apiURLS;

@property (nonatomic, readwrite) NSString *googlePlacesKey;
@property (nonatomic, readwrite) NSString *googleGeocodingKey;
@property (nonatomic, readwrite) NSString *googleTimeZonesKey;

@end

@implementation SARRequestHandler

- (instancetype)initWithDelegate:(id)delegate {
    if (self = [super init]) {
        
        self.delegate = delegate;
        
        self.keys = [NSMutableDictionary dictionary];
        [self.keys insertValue:@"AIzaSyC2hcNriRbvlCxGKN6_CM2ij0jj1sAd5hM" inPropertyWithKey:@"places"];
        [self.keys insertValue:@"AIzaSyAgA-Yal7w7z-7AbszDk-4FOqsPVDZ96H4" inPropertyWithKey:@"geocoding"];
        [self.keys insertValue:@"AIzaSyAYbym6feYlr7vakttlcqyFeVgKBy585XU" inPropertyWithKey:@"timezones"];
        
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
    
}

@end
