//
//  SARAPIKeyManager.m
//  Global Time
//
//  Created by Stephen Ramthun on 15/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARAPIKeyManager.h"

// Change this to reflect location of .plist-file with keys
NSString * const kAPIKeyFilePath = @"<PATH_TO_YOUR_KEYS>";

@interface SARAPIKeyManager ()

@property (nonatomic) NSString *placesDictionaryKey;
@property (nonatomic) NSString *geocodingDictionaryKey;
@property (nonatomic) NSString *timeZonesDictionaryKey;

@end

@implementation SARAPIKeyManager

/**
 * Singleton initializer.
 */
+ (SARAPIKeyManager *)sharedAPIKeyManager {
  static SARAPIKeyManager *sharedAPIKeyManager = nil;
  static dispatch_once_t oncePredicate;
  
  dispatch_once(&oncePredicate, ^{
    sharedAPIKeyManager = [[SARAPIKeyManager alloc] init];
  });
  
  return sharedAPIKeyManager;
}

- (instancetype)init {
  if (self = [super init]) {
    _keys = [NSDictionary dictionaryWithContentsOfFile:kAPIKeyFilePath];
    _placesDictionaryKey    = @"place";
    _geocodingDictionaryKey = @"geocode";
    _timeZonesDictionaryKey = @"timezones";
  }
  return self;
}

/**
 * Returns API key for supplied API type.
 *
 * @param type   type of API to return key for
 * @return       key for API matching type
 */
- (NSString *)keyForAPIType:(SARAPIType)type {
  switch (type) {
    case SARAPITypePlace:
      return [self.keys valueForKey:self.placesDictionaryKey];
    case SARAPITypeGeocoding:
      return [self.keys valueForKey:self.geocodingDictionaryKey];
    case SARAPITypeTimeZones:
      return [self.keys valueForKey:self.timeZonesDictionaryKey];
  }
}

/**
 * Returns API name for supplied API type.
 *
 * @param type   type of API to return name for
 * @return       name for API matching type
 */
- (NSString *)nameForAPIType:(SARAPIType)type {
  switch (type) {
    case SARAPITypePlace:
      return self.placesDictionaryKey;
    case SARAPITypeGeocoding:
      return self.geocodingDictionaryKey;
    case SARAPITypeTimeZones:
      return self.timeZonesDictionaryKey;
  }
}

@end
