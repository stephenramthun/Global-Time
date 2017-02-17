//
//  SARAPIKeyManager.h
//  Global Time
//
//  Created by Stephen Ramthun on 15/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//
//  SARAPIKeyManager is responsible for loading the authentication keys
//  for a given set of APIs from an external file, and supplying object
//  with a key when requested.

#import <Foundation/Foundation.h>

@interface SARAPIKeyManager : NSObject

typedef enum : NSInteger {
  SARAPITypePlace,
  SARAPITypeGeocoding,
  SARAPITypeTimeZones
} SARAPIType;

@property (nonatomic) NSDictionary *keys;

+ (SARAPIKeyManager *)sharedAPIKeyManager;
- (NSString *)keyForAPIType:(SARAPIType)type;
- (NSString *)nameForAPIType:(SARAPIType)type;

@end
