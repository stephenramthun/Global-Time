//
//  SARClockController.m
//  Global Time
//
//  Created by Stephen Ramthun on 03/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARClockController.h"
#import "SARStatusBarMenu.h"
#import "SARTimeData.h"

@interface SARClockController()

@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSInteger offset;
@property (nonatomic) NSStatusItem *clockItem;
@property (nonatomic, readwrite) SARTimeData *timeData;

// Properties used for updating clock display
@property (nonatomic) NSDate *currentDate;
@property (nonatomic) NSString *dateString;
@property (nonatomic) NSString *statusString;
@property (nonatomic) NSString *locationName;

@end

@implementation SARClockController

- (instancetype)init {
  if (self = [super init]) {
    [self setupClockItem];
    _timeData = [[SARTimeData alloc] init];
  }
  return self;
}

#pragma mark - Public Methods

- (void)makeAPICallWithInput:(NSString *)input {
  [self.timeData addObserver:self forKeyPath:@"timeZone" options:NSKeyValueObservingOptionNew context:nil];
  [self.timeData makeAPICallWithInput:input];
}

#pragma mark - Private Methods

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
  NSDateFormatter *dateFormatter = [self dateFormatter];
  NSTimeZone *remoteTimeZone     = self.timeData.timeZone;
  NSTimeZone *localTimeZone      = [NSTimeZone localTimeZone];
  
  self.offset       = [remoteTimeZone secondsFromGMT] - [localTimeZone secondsFromGMT];
  self.currentDate  = [[NSDate date] dateByAddingTimeInterval:ABS(self.offset)];
  self.locationName = self.timeData.locationName;
  
  // Schedule timer for repeat every second, and update title
  // of self.clockItem to correctly represent the current time.
  
  /*
  dispatch_async(dispatch_get_main_queue(), ^{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(updateTime:)
                                                userInfo:dateFormatter
                                                 repeats:YES];
  });
  */
  [self.timeData removeObserver:self forKeyPath:@"timeZone"];
}

/**
 * Updates time each time self.timer is called.
 *
 * @param timer   the timer which is currently firing.
 */
- (void)updateTime:(NSTimer *)timer {
  NSDateFormatter *dateFormatter = timer.userInfo;
  self.currentDate  = [self.currentDate dateByAddingTimeInterval:1.0];
  self.dateString   = [dateFormatter stringFromDate:self.currentDate];
  self.statusString = [NSString stringWithFormat:@"%@: %@", self.timeData.locationName, self.dateString];
  [self.clockItem setTitle:self.statusString];
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
