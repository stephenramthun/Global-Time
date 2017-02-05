//
//  SARStatusBarClock.m
//  Global Time
//
//  Created by Stephen Ramthun on 03/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARStatusBarClock.h"

@interface SARStatusBarClock()

@property (nonatomic, readwrite) NSStatusItem *item;
@property (nonatomic, readwrite) NSMenu *menu;
@property (nonatomic, readwrite) NSTimer *timer;

@property (nonatomic, readwrite) SARTimeZoneData *timeZone;
@property (nonatomic, readwrite) NSString *name;

@end

@implementation SARStatusBarClock

- (instancetype)init {
    if (self = [super init]) {
        
        self.name = @"Oslo";
        
        [self setupStatusBar];
    }
    
    return self;
}

- (void)setupStatusBar {
    NSStatusBar *bar = [NSStatusBar systemStatusBar];
    self.menu = [self setupMenu];
    self.item = [self getClockItemWithStatusBar:bar andMenu:self.menu];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterNoStyle;
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    dateFormatter.locale    = [NSLocale currentLocale];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer){
        NSDate *currentDate    = [NSDate date];
        NSString *dateString   = [dateFormatter stringFromDate:currentDate];
        NSString *statusString = [NSString stringWithFormat:@"%@: %@", self.name, dateString];
        [self.item setTitle:statusString];
    }];
}

- (NSMenu *)setupMenu {
    NSMenu *menu = [[NSMenu alloc] init];
    NSMenuItem *exit = [[NSMenuItem alloc] initWithTitle:@"Exit" action:@selector(exit) keyEquivalent:@""];
    exit.enabled = YES;
    [exit setTarget:self];
    [menu addItem:exit];
    return menu;
}

- (void)exit {
    [NSApp performSelector:@selector(terminate:) withObject:nil afterDelay:0.0];
}

- (NSStatusItem *)getClockItemWithStatusBar:(NSStatusBar *)bar andMenu:(NSMenu *)menu {
    NSStatusItem *clockItem = [bar statusItemWithLength:NSVariableStatusItemLength];
    [clockItem setHighlightMode:YES];
    [clockItem setMenu:menu];
    return clockItem;
}

@end
