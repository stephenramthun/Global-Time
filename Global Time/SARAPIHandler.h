//
//  SARAPIHandler.h
//  Global Time
//
//  Created by Stephen Ramthun on 03/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//
//  A SARAPIHandler is a blueprint for how to connect to a specific
//  web service API.

#import <Foundation/Foundation.h>

@interface SARAPIHandler : NSObject

@property (nonatomic) NSString *key;
@property (nonatomic) NSString *argument;

- (instancetype)initWithKey:(NSString *)key;
- (NSString *)buildURLString;
- (NSString *)parseJSONData:(NSData *)data;
- (id)dictionaryFromJSONData:(NSData *)data;
- (void)makeAPICallWithArguments:(NSString *)arguments object:(id)object selector:(SEL)selector;

@end
