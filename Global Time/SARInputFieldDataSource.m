//
//  SARInputFieldDataSource.m
//  Global Time
//
//  Created by Stephen Ramthun on 04/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARInputFieldDataSource.h"

@interface SARInputFieldDataSource()

@property (nonatomic, readwrite) NSMutableArray *cities;
@property (nonatomic, readwrite) NSMutableArray *filteredResults;

@end

@implementation SARInputFieldDataSource

- (instancetype)init {
    if (self = [super init]) {
        [self populateTimeZonesArray];
    }
    
    return self;
}

/**
 * Generates a list of all time zone names and generates a time zone object for each.
 * Adds each of these time zone objects to the timeZones-array.
 */
- (void)populateTimeZonesArray {
    NSArray *timeZoneNames = [NSTimeZone knownTimeZoneNames];
    self.cities         = [NSMutableArray arrayWithCapacity:timeZoneNames.count];
    
    for (NSString *timeZoneName in timeZoneNames) {
        SARTimeZoneData *timeZone = [[SARTimeZoneData alloc] initWithName:timeZoneName];
        [self.cities addObject:timeZone];
    }
}

#pragma mark - Data Source Methods

- (id)comboBox:(NSComboBox *)comboBox objectValueForItemAtIndex:(NSInteger)index {
    SARTimeZoneData *timeZone = [self.cities objectAtIndex:index];
    NSString *value = [NSString stringWithFormat:@"%@ / %@", timeZone.region, timeZone.city];
    return value;
}

- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)comboBox {
    return self.cities.count;
}

/**
 * Takes string from the combo box text field and compares it to city names in
 * timeZones-array.
 *
 * @param comboBox  comboBox-object currently accepting user input
 * @param string    string currently in text field of combo box
 */
- (NSString *)comboBox:(NSComboBox *)comboBox completedString:(NSString *)string {
    for (SARTimeZoneData *timeZone in self.cities) {
        NSString *commonPrefix = [timeZone.city commonPrefixWithString:string options:NSCaseInsensitiveSearch];
        if (commonPrefix.length >= string.length) {
            return timeZone.city;
        }
    }
    
    return @"";
}

@end
