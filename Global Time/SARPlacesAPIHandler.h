//
//  SARPlacesAPIHandler.h
//  Global Time
//
//  Created by Stephen Ramthun on 13/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARAPIHandler.h"

@interface SARPlacesAPIHandler : SARAPIHandler

@property (nonatomic) NSString *cityAndCountry;

- (NSString *)parseResponse:(id)response;

@end
