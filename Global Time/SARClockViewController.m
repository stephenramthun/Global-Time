//
//  SARClockViewController.m
//  Global Time
//
//  Created by Stephen Ramthun on 04/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARClockViewController.h"
#import "SARPlacesAPIHandler.h"
#import "SARClockController.h"
#import "SARInputField.h"
#import "SARTimeData.h"

@interface SARClockViewController ()

@property (nonatomic) SARClockController *statusBarClock;
@property (nonatomic, weak) IBOutlet SARInputField *inputField;

- (IBAction)userDidEnterText:(id)sender;

@end

@implementation SARClockViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.statusBarClock = [[SARClockController alloc] init];
  [self.statusBarClock addObserver:self forKeyPath:@"locationName" options:NSKeyValueObservingOptionNew context:nil];
}

- (IBAction)userDidEnterText:(id)sender {
  SARInputField *inputField = sender;
  [self.statusBarClock makeAPICallWithInput:inputField.stringValue];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
  [self.inputField setStringValue:[change valueForKey:@"new"]];
}



// Get notified when user inputs new text in _inputField.
- (void)controlTextDidEndEditing:(NSNotification *)notification {
  SARInputField *inputField = notification.object;
  [self.statusBarClock makeAPICallWithInput:inputField.stringValue];
}

- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor {
  return YES;
}

@end
