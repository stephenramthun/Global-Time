//
//  SARTimeData.h
//  Global Time
//
//  Created by Stephen Ramthun on 13/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//
// SARTimeData keeps track of the time in a given time zone.
// It is responsible for making API-calls and parsing the response.

#import <Foundation/Foundation.h>

@interface SARTimeData : NSObject <NSURLSessionDownloadDelegate>

@property (nonatomic, readonly) NSDate *date;

@end
