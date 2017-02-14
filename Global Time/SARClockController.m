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

const NSInteger kSeconds = 3600;
const NSInteger kHours   = 9;

@interface SARClockController()

@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSStatusItem *clockItem;
@property (nonatomic) SARTimeData *timeData;
@property (nonatomic) NSInteger offset;

// Properties used for updating clock display
@property (nonatomic) NSDate *currentDate;
@property (nonatomic) NSString *dateString;
@property (nonatomic) NSString *statusString;

@end

@implementation SARClockController

- (instancetype)init {
  if (self = [super init]) {
    /*
    [self setupClockItem];
    
    _timeData = [[SARTimeData alloc] init];
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(receivedOffset:) name:@"SARTimeData" object:_timeData];
    [_timeData makeAPICallWithInput:@"osl"];
    */
  }
  return self;
}
/*
- (void)receivedOffset:(NSNotification *)notification {
  _offset = _timeData.offsetInSeconds;
  [self setupStatusBar];
}

// Initial setup of status bar
- (void)setupStatusBar {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateStyle = NSDateFormatterNoStyle;
  dateFormatter.timeStyle = NSDateFormatterShortStyle;
  dateFormatter.locale    = [NSLocale currentLocale];
  self.currentDate  = [[NSDate date] dateByAddingTimeInterval:ABS(self.offset)];

  // Schedule timer for repeat every second, and update title
  // of self.clockItem to correctly represent the current time.
  dispatch_async(dispatch_get_main_queue(), ^{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(updateTime:)
                                                userInfo:dateFormatter
                                                 repeats:YES];
  });
}

- (void)updateTime:(NSTimer *)timer {
  NSDateFormatter *dateFormatter = timer.userInfo;
  self.currentDate  = [self.currentDate dateByAddingTimeInterval:1.0];
  self.dateString   = [dateFormatter stringFromDate:self.currentDate];
  self.statusString = [NSString stringWithFormat:@"%@: %@", self.timeData.fullLocationName, self.dateString];
  [self.clockItem setTitle:self.statusString];
}

// One time setup of clock item
- (void)setupClockItem {
  NSStatusBar *systemBar = [NSStatusBar systemStatusBar];
  self.clockItem = [systemBar statusItemWithLength:NSVariableStatusItemLength];
  [self.clockItem setHighlightMode:YES];
  [self.clockItem setMenu:[[SARStatusBarMenu alloc] init]];
}*/

@end
