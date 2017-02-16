//
//  SARAPIHandler.m
//  Global Time
//
//  Created by Stephen Ramthun on 03/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARAPIHandler.h"

@interface SARAPIHandler()

@property (nonatomic) NSDictionary *response;

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
 * Makes a call to an API with supplied arguments.
 *
 * @param arguments   user input used as arguments in the API call.
 * @param object      object that should receive API response.
 * @param selector    method implemented by receiving object that handles response.
 *                    The referenced method should have only one argument: an NSString object.
 */
- (void)makeAPICallWithArguments:(NSString *)arguments object:(id)object selector:(SEL)selector {
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  
  void (^completionHandler)(NSData *, NSURLResponse *, NSError *) = ^(NSData *data, NSURLResponse *response, NSError *error){
    if ([object respondsToSelector:selector]) {
      NSString *parsedString = [self parseJSONData:data];
      [object performSelector:selector withObject:parsedString];
    }
  };
  
  NSString *escapedString    = [arguments stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
  NSString        *urlString = [self purgeString:[NSString stringWithFormat:[self buildURLString], escapedString]];
  NSURLSession      *session = [NSURLSession sessionWithConfiguration:configuration];
  NSURL *url = [NSURL URLWithString:urlString];
  NSLog(@"Trying to contact API with URL: %@", url.absoluteString);
  
  NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:completionHandler];
  [task resume];
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
  
  self.response = object;
  return object;
}

/**
 * Takes a string argument and return a string without spaces.
 *
 * @param string  string to purge of spaces.
 */
- (NSString *)purgeString:(NSString *)string {
  return [string stringByReplacingOccurrencesOfString:@" " withString:@"_"];
}


@end
