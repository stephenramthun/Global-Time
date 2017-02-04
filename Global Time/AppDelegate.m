//
//  AppDelegate.m
//  Global Time
//
//  Created by Stephen Ramthun on 03/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (nonatomic, strong) NSStatusItem *statusItem;
@property (nonatomic, strong) NSMenu *menu;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    NSStatusBar *bar = [NSStatusBar systemStatusBar];
    self.menu = [[NSMenu alloc] init];
    self.statusItem = [self getClockItemWithStatusBar:bar andMenu:self.menu];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterNoStyle;
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    dateFormatter.locale = [NSLocale currentLocale];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer){
        NSDate *currentDate = [NSDate date];
        [self.statusItem setTitle:[dateFormatter stringFromDate:currentDate]];
    }];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    
    
}

- (NSStatusItem *)getClockItemWithStatusBar:(NSStatusBar *)bar andMenu:(NSMenu *)menu {
    NSStatusItem *clockItem = [bar statusItemWithLength:NSVariableStatusItemLength];
    [clockItem setTitle:@""];
    [clockItem setHighlightMode:YES];
    [clockItem setMenu:menu];
    return clockItem;
}

@end
