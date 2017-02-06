//
//  SARRequestHandler.h
//  Global Time
//
//  Created by Stephen Ramthun on 03/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SARRequestHandlerDelegate <NSObject>

- (void)receivedResponse:(id)response;

@end

@interface SARRequestHandler : NSObject

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *country;

- (instancetype)initWithDelegate:(id)delegate;
- (void)sendRequestOfType:(NSString *)type withInput:(NSString *)input;

@end
