//
//  SARClockController.m
//  Global Time
//
//  Created by Stephen Ramthun on 03/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARClockController.h"
#import "SARGeocodingAPIHandler.h"
#import "SARTimeZoneAPIHandler.h"
#import "SARStatusBarMenu.h"
#import "SARAPIKeyManager.h"
#import "SARAPIHandler.h"
#import "SARTimeData.h"

@interface SARClockController()

@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSStatusItem *clockItem;

// Properties used for updating clock display
@property (nonatomic) NSString *statusString;
@property (nonatomic) NSString *locationName;
@property (nonatomic) NSInteger offsetInSeconds;
@property (nonatomic) NSTimeZone *remoteTimeZone;

// Objects responsible for building API-requests and parsing responses from web services.
@property (nonatomic) SARGeocodingAPIHandler *geocodingHandler;
@property (nonatomic) SARTimeZoneAPIHandler *timeZoneHandler;

@end

@implementation SARClockController

- (instancetype)init {
  if (self = [super init]) {
    [self setupClockItem];
    SARAPIKeyManager *keyManager = [SARAPIKeyManager sharedAPIKeyManager];
    _geocodingHandler = [[SARGeocodingAPIHandler alloc] initWithKey:[keyManager keyForAPIType:SARAPITypeGeocoding]];
    _timeZoneHandler  = [[SARTimeZoneAPIHandler alloc]  initWithKey:[keyManager keyForAPIType:SARAPITypeTimeZones]];
  }
  return self;
}

#pragma mark - Public Methods

- (void)sendRequestWithArguments:(NSString *)arguments {
  [self.geocodingHandler makeAPICallWithArguments:arguments object:self selector:@selector(didReceiveGeocodingResponse:)];
}

#pragma mark - Private Methods

/**
 * Method that gets called each time SARGeocodingAPIHandler gets a response from the Geocoding API.
 *
 * @param response  latitude and longitude received by SARGeocodingAPIHandler from the Geocoding API
 */
- (void)didReceiveGeocodingResponse:(NSString *)response {
  [self.timeZoneHandler makeAPICallWithArguments:response object:self selector:@selector(didReceiveTimeZonesResponse:)];
}

/**
 * Method that gets called each time SARTimeZoneAPIHandler gets a response from the Time Zone API.
 *
 * @param response  name/code of time zone received by SARTimeZoneAPIHandler from the Time Zone API
 */
- (void)didReceiveTimeZonesResponse:(NSString *)response {
  self.locationName = response;
  
  // Calculate time difference between the local and remote time zones.
  self.remoteTimeZone       = [NSTimeZone timeZoneWithName:response];
  NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
  self.offsetInSeconds      = [self.remoteTimeZone secondsFromGMT] - [localTimeZone secondsFromGMT] + 1;
  
  // Update clock each second.
  self.timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
    NSDate *date         = [[NSDate date] dateByAddingTimeInterval:1.0 - self.offsetInSeconds];
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    self.statusString    = [NSString stringWithFormat:@"%@: %@", self.locationName, dateString];
    [self.clockItem setTitle:self.statusString];
    date       = nil;
    dateString = nil;
  }];
  
  NSRunLoop *mainRunLoop = [NSRunLoop mainRunLoop];
  [mainRunLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 * Returns an NSDateFormatter object for displaying the time.
 *
 * @@return   date formatter object used for formatting time to display.
 */
- (NSDateFormatter *)dateFormatter {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateStyle = NSDateFormatterNoStyle;
  dateFormatter.timeStyle = NSDateFormatterShortStyle;
  dateFormatter.locale    = [NSLocale currentLocale];
  return dateFormatter;
}

/**
 * Initial setup of system status bar clock display.
 */
- (void)setupClockItem {
  NSStatusBar *systemBar = [NSStatusBar systemStatusBar];
  self.clockItem = [systemBar statusItemWithLength:NSVariableStatusItemLength];
  [self.clockItem setHighlightMode:YES];
  [self.clockItem setMenu:[[SARStatusBarMenu alloc] init]];
}

@end
