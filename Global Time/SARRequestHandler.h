//
//  SARRequestHandler.h
//  Global Time
//
//  Created by Stephen Ramthun on 03/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SARRequestHandlerDelegate

- (void)receivedResponse:(id)response;

@end

@interface SARRequestHandler : NSObject

@end
