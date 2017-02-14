//
//  SARAPIHandler.m
//  Global Time
//
//  Created by Stephen Ramthun on 03/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARAPIHandler.h"

@interface SARAPIHandler()

@end

@implementation SARAPIHandler

/**
 * Designated initializer.
 *
 * @param key   key used to authenticate with API.
 */
- (instancetype)initWithKey:(NSString *)key {
  if (self = [super init]) {
    self.key = key;
  }
  return self;
}

/**
 * Builds a URL based on given api-key, base string and arguments.
 *
 * @param base        base/first part of the URL
 * @param arguments   arguments supplied to the API web service
 */
- (NSURL *)buildURLWithBase:(NSString *)base arguments:(NSString *)arguments{
  NSString *path = [NSString stringWithFormat:@"%@%@%@", base, arguments, self.key];
  return [NSURL URLWithString:path];
}

/**
 * Builds a URL string based on an api-key, a base string and arguments.
 * This method must be overridden by subclasses.
 *
 * @return  NSString representing a URL
 */
- (NSString *)buildURLString {
  [NSException raise:@"IllegalMethodCall" format:@"Method \"buildURL\" should be overridden."];
  return nil;
}

@end
