//
//  SARTimeZoneData.h
//  Global Time
//
//  Created by Stephen Ramthun on 04/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SARTimeZoneData : NSObject

@property (nonatomic, readonly, copy) NSString *city;
@property (nonatomic, readonly, copy) NSString *region;

- (instancetype)initWithName:(NSString *)name;

@end
