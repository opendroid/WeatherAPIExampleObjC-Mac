//
//  ViewController.h
//  CityWeather
//
//  Created by Ajay Thakur on 11/27/15.
//  Copyright © 2015 Ajay Thaur. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"
#import "Social/Social.h"
#import "Accounts/Accounts.h"
#import "Weather.h"
#import "Weather+OpenWeather.h"
#import "Utilities.h"
#import "Constants.h"

@interface ViewController : NSViewController

// Wired UI elements
@property (weak) IBOutlet NSTextField *cityStateUserNTF;
@property (weak) IBOutlet NSButton *getWeatherNSB;
@property (weak) IBOutlet NSTextField *cityStateFetchedNTF;
@property (weak) IBOutlet NSButton *mapItNSB;
@property (weak) IBOutlet NSButton *shareItNSB;
@property (weak) IBOutlet NSButton *tweetItNSB;
@property (weak) IBOutlet NSProgressIndicator *fetchProgressNPI;
@property (weak) IBOutlet NSImageView *tempIconNIV;
@property (weak) IBOutlet NSTextField *tempNowNTF;
@property (weak) IBOutlet NSImageView *tempMaxIconNIV;
@property (weak) IBOutlet NSTextField *tempMaxNTF;
@property (weak) IBOutlet NSImageView *tempMinIconNIV;
@property (weak) IBOutlet NSTextField *tempMinNTF;
@property (weak) IBOutlet NSTextField *descriptionNTF;
@property (weak) IBOutlet NSTextField *descriptionMainNTF;
@property (weak) IBOutlet NSImageView *windSpeedIconNIV;
@property (weak) IBOutlet NSTextField *windSpeedNTF;
@property (weak) IBOutlet NSImageView *windDirectionIconNIV;
@property (weak) IBOutlet NSTextField *windDirectionNTF;
@property (weak) IBOutlet NSImageView *humidityIconNIV;
@property (weak) IBOutlet NSTextField *humidityNTF;
@property (weak) IBOutlet NSImageView *rainIconNIV;
@property (weak) IBOutlet NSTextField *rainNTF;
@property (weak) IBOutlet NSImageView *snowIconNIV;
@property (weak) IBOutlet NSTextField *snowNTF;
@property (weak) IBOutlet NSImageView *pressureIconNIV;
@property (weak) IBOutlet NSTextField *pressureNTF;
@property (weak) IBOutlet NSTextField *pressureAtSeaNTF;
@property (weak) IBOutlet NSImageView *sunriseIconNIV;
@property (weak) IBOutlet NSTextField *sunriseTimeNTF;
@property (weak) IBOutlet NSImageView *sunsetIconNIV;
@property (weak) IBOutlet NSTextField *sunsetTimeNTF;
@property (weak) IBOutlet NSImageView *hourglassIconNIV;
@property (weak) IBOutlet NSTextField *lastFetchTimeNTF;
@property (weak) IBOutlet NSTextField *lastFetchAgoNTF;
@property (weak) IBOutlet NSImageView *weatherIconNIV;


@property (nonatomic) AppDelegate *appDelegate;
@property (nonatomic) NSString *lastSavedLatLonOfCityState;

// Helper methods for updating UX and show errors etc.
- (void) initUI;
- (void) showAlertPopupWithMessage: (NSString *) message;
- (void) enableButtonsWithViewController: (ViewController *) vc;
- (void) refreshUIWithWeatherData: (Weather *) weather inViewController: (ViewController *) vc;

@end

