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

- (instancetype)initWithURLString:(NSString *)urlString {
  if (self = [super init]) {
    _urlString = urlString;
  }
  return self;
}

/**
 * Builds a URL based on given api-key, base string and arguments.
 *
 * @param key         key used for authentication
 * @param base        base/first part of the URL
 * @param arguments   arguments supplied to the API web service
 */
- (NSURL *)buildURLWithKey:(NSString *)key base:(NSString *)base arguments:(NSString *)arguments{
  NSString *path = [NSString stringWithFormat:@"%@%@%@", base, arguments, key];
  return [NSURL URLWithString:path];
}

@end
