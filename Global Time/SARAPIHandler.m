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
  [NSException raise:@"IllegalMethodCall" format:@"Method \"buildURLString\" should be overridden."];
  return nil;
}

/**
 * This method must be overridden by subclasses.
 *
 * @return  NSString representing a URL
 */
- (NSString *)parseJSONData:(NSData *)data {
  [NSException raise:@"IllegalMethodCall" format:@"Method \"parseResponse\" should be overridden."];
  return nil;
}

/**
 * Takes an argument representing some JSON data and returns it
 * as an NSDictionary object.
 *
 * @param data  JSON data to convert to a dictionary
 * @return      NSDictionary with JSON data
 */
- (NSDictionary *)dictionaryFromJSONData:(NSData *)data {
  NSError *error;
  id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  
  if (error) {
    NSLog(@"JSON was malformed, could not parse data.");
    return nil;
  }
  
  return object;
}

@end
