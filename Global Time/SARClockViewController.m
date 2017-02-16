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
#import "SARTimeData.h"

@interface SARClockViewController ()

@property (nonatomic) SARClockController *statusBarClock;
@property (nonatomic) SARPlacesAPIHandler *placesAPIHandler;
@property (nonatomic, weak) IBOutlet SARInputField *inputField;

@end

@implementation SARClockViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  SARAPIKeyManager *keyManager = [SARAPIKeyManager sharedAPIKeyManager];
  self.placesAPIHandler = [[SARPlacesAPIHandler alloc] initWithKey:[keyManager keyForAPIType:SARAPITypePlace]];
  self.statusBarClock   = [[SARClockController alloc] init];
}

/**
 * Method to be called when SARPlacesAPIHandler receives a response from the web service.
 *
 * @param response  response received from web service
 */
- (void)didReceiveResponse:(NSString *)response {
  [self.inputField setStringValue:response];
  [self.view.window makeFirstResponder:nil];
  
  NSLog(@"City:      %@", response);
  [self.statusBarClock sendRequestWithArguments:response];
}

- (void)userEnteredString:(NSString *)string {
  [self.placesAPIHandler makeAPICallWithArguments:string object:self selector:@selector(didReceiveResponse:)];
}

#pragma mark - Mouse Events

- (void)mouseDown:(NSEvent *)event {
  [self.view.window makeFirstResponder:nil];
}

@end
