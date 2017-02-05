//
//  SARTimeZoneData.m
//  Global Time
//
//  Created by Stephen Ramthun on 04/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARTimeZoneData.h"

@interface SARTimeZoneData()

@property (nonatomic, readwrite) NSString *city;
@property (nonatomic, readwrite) NSString *region;
@property (nonatomic, readwrite) NSTimeZone *timeZone;

@end

@implementation SARTimeZoneData

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        NSArray *components = [name componentsSeparatedByString:@"/"];
        
        if (components.count > 1) {
            self.city   = [components objectAtIndex:1];
            self.region = [components objectAtIndex:0];
            
            // Remove underscores from city name.
            self.city = [self.city stringByReplacingOccurrencesOfString:@"_" withString:@" "];
        }
        
        self.timeZone = [NSTimeZone timeZoneWithName:name];
    }
    
    return self;
}



@end
