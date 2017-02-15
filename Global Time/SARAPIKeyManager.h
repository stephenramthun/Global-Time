//
//  SARAPIKeyManager.h
//  Global Time
//
//  Created by Stephen Ramthun on 15/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

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

@end
