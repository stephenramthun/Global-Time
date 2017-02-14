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

@end
