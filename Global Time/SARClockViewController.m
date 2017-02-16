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
#import "SARAPIKeyManager.h"
#import "SARInputField.h"

@interface SARClockViewController ()

@property (nonatomic) SARClockController *statusBarClock;
@property (nonatomic) SARPlacesAPIHandler *placesAPIHandler;
@property (nonatomic, weak) IBOutlet SARInputField *inputField;
@property (nonatomic, weak) IBOutlet NSTextField *timeTextField;

@end

@implementation SARClockViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  SARAPIKeyManager *keyManager = [SARAPIKeyManager sharedAPIKeyManager];
  self.placesAPIHandler = [[SARPlacesAPIHandler alloc] initWithKey:[keyManager keyForAPIType:SARAPITypePlace]];
  self.statusBarClock   = [[SARClockController alloc] init];
  
  [self.statusBarClock addObserver:self forKeyPath:@"dateString" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
  self.timeTextField.stringValue = [change valueForKey:@"new"];
}

/**
 * Method to be called when SARPlacesAPIHandler receives a response from the web service.
 *
 * @param response  response received from web service
 */
- (void)didReceiveResponse:(NSString *)response {
  if (response.length < 1) {
    return;
  }
  [self.inputField setStringValue:response];
  [self.view.window makeFirstResponder:nil];
  [self.statusBarClock sendRequestWithArguments:response];
}

/**
 * Method that gets called each time a user has enteres a string to _inputField and pressed enter.
 *
 * @param string  stringValue of _inputField at time of call
 */
- (void)userEnteredString:(NSString *)string {
  [self.placesAPIHandler makeAPICallWithArguments:string object:self selector:@selector(didReceiveResponse:)];
}

#pragma mark - Mouse Events

- (void)mouseDown:(NSEvent *)event {
  [self.view.window makeFirstResponder:nil];
}

@end
