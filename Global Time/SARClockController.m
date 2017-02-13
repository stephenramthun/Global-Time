//
//  SARClockController.m
//  Global Time
//
//  Created by Stephen Ramthun on 03/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARClockController.h"
#import "SARRequestHandler.h"
#import "SARStatusBarMenu.h"
#import "SARTimeData.h"

const NSInteger kSeconds = 3600;
const NSInteger kHours   = 9;

@interface SARClockController()

@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSStatusItem *clockItem;
@property (nonatomic, readwrite) SARTimeData *timeData;

@end

@implementation SARClockController

- (instancetype)init {
  if (self = [super init]) {
    [self setupClockItem];
    [self setupStatusBar];
    _timeData = [[SARTimeData alloc] init];
  }
  return self;
}

// Initial setup of status bar
- (void)setupStatusBar {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateStyle = NSDateFormatterNoStyle;
  dateFormatter.timeStyle = NSDateFormatterShortStyle;
  dateFormatter.locale    = [NSLocale currentLocale];

  // Schedule timer for repeat every second, and update title
  // of self.clockItem to correctly represent the current time.
  self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer){
      NSDate *currentDate    = [[NSDate date] dateByAddingTimeInterval:(kSeconds * kHours)];
      NSString *dateString   = [dateFormatter stringFromDate:currentDate];
      NSString *statusString = [NSString stringWithFormat:@"%@: %@", @"TEST", dateString];
      [self.clockItem setTitle:statusString];
  }];
}

// One time setup of clock item
- (void)setupClockItem {
  NSStatusBar *systemBar = [NSStatusBar systemStatusBar];
  self.clockItem = [systemBar statusItemWithLength:NSVariableStatusItemLength];
  [self.clockItem setHighlightMode:YES];
  [self.clockItem setMenu:[[SARStatusBarMenu alloc] init]];
}

@end
