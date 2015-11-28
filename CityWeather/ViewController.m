//
//  ViewController.m
//  CityWeather
//
//  Created by Ajay Thakur on 11/27/15.
//  Copyright © 2015 Ajay Thaur. All rights reserved.
//

#import "ViewController.h"
@import AppKit;


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self initUI];
    self.appDelegate = (AppDelegate *)[NSApp delegate];;
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

// Utility to show alert popup
- (void) showAlertPopupWithMessage: (NSString *) message {
    // All well got the image
    dispatch_async(dispatch_get_main_queue(), ^{
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"City Weather"];
        [alert setInformativeText:message];
        [alert setAlertStyle:NSInformationalAlertStyle];
        [alert runModal];
    });
}

// Enable the buttons and hide progress bar animation.
- (void) enableButtonsWithViewController: (ViewController *) vc {
    if (!vc) return;
    dispatch_async(dispatch_get_main_queue(), ^{
        vc.getWeatherNSB.enabled = YES;
        [vc.fetchProgressNPI startAnimation:vc];
        [vc.fetchProgressNPI stopAnimation:vc];
        vc.fetchProgressNPI.hidden = YES;
    });
}

// Refresh the UP with the weather data.
- (void) refreshUIWithWeatherData: (Weather *) weather inViewController: (ViewController *) vc {
    if (!vc) return;
    if (!weather) return;
    dispatch_async(dispatch_get_main_queue(), ^{
        // Setup the UI
        if (weather.cityName) {
            NSString *cityCountry=[NSString stringWithFormat:@"%@,%@ (%.0f)", weather.cityName, weather.sysCountry, [weather.identifier doubleValue ]];
            vc.cityStateFetchedNTF.stringValue = cityCountry;
            NSString *latlon = [NSString stringWithFormat:@"%0.4f,%0.4f",
                                 [weather.coordLat doubleValue], [weather.coordLon doubleValue]];
            
            vc.lastSavedLatLonOfCityState = latlon;
            vc.mapItNSB.hidden = NO;
        } else {
            vc.cityStateFetchedNTF.stringValue = @"";
            vc.lastSavedLatLonOfCityState = @"";
            vc.mapItNSB.hidden = YES;
        }

        // Set temperature
        if (weather.mainTemp) {
            vc.tempIconNIV.hidden = NO;
            vc.tempNowNTF.stringValue = [NSString stringWithFormat:@"%3.0f℉", [weather.mainTemp doubleValue]];
        } else {
            vc.tempIconNIV.hidden = YES;
            vc.tempNowNTF.stringValue = @"";
        }
        
        // Set Max temp
        if (weather.mainTempMax) {
            vc.tempMaxIconNIV.hidden = NO;
            vc.tempMaxNTF.stringValue = [NSString stringWithFormat:@"%3.0f℉", [weather.mainTempMax doubleValue]];
        } else {
            vc.tempMaxIconNIV.hidden = YES;
            vc.tempMaxNTF.stringValue = @"";
        }
        // Set Min temp
        if (weather.mainTempMax) {
            vc.tempMinIconNIV.hidden = NO;
            vc.tempMinNTF.stringValue = [NSString stringWithFormat:@"%3.0f℉", [weather.mainTempMin doubleValue]];
        } else {
            vc.tempMinIconNIV.hidden = YES;
            vc.tempMinNTF.stringValue = @"";
        }
        // Set description for weather 0
        if (weather.weather0Description) {
            vc.descriptionNTF.stringValue = weather.weather0Description;
        } else {
            vc.descriptionNTF.stringValue = @"";
        }
        // Set main description for weather 0
        if (weather.weather0Main) {
            vc.descriptionMainNTF.stringValue = weather.weather0Main;
        } else {
            vc.descriptionMainNTF.stringValue = @"";
        }
        // Set windSpeed
        if (weather.windSpeed) {
            vc.windSpeedIconNIV.hidden = NO;
            vc.windSpeedNTF.stringValue = [NSString stringWithFormat:@"%0.1f mph",[weather.windSpeed doubleValue]];
        } else {
            vc.windSpeedIconNIV.hidden = YES;
            vc.windSpeedNTF.stringValue = @"";
        }
        // Set wind icon
        if (weather.windDeg) {
            vc.windDirectionIconNIV.hidden = NO;
            NSString *iconName = [Weather weatherWindSpeedIconNameForWindDegrees:weather.windDeg];
            vc.windDirectionIconNIV.image = [NSImage imageNamed:iconName];
            vc.windDirectionNTF.stringValue = [NSString stringWithFormat:@"%.0f°", [weather.windDeg doubleValue]];
        } else {
            vc.windDirectionIconNIV.hidden = YES;
            vc.windDirectionNTF.stringValue = @"";
        }
        // Humidity
        if (weather.mainHumidity) {
            vc.humidityIconNIV.hidden = NO;
            vc.humidityNTF.stringValue = [NSString stringWithFormat:@"%3d%%",[weather.mainHumidity intValue]];
        } else {
            vc.humidityIconNIV.hidden = YES;
            vc.humidityNTF.stringValue = @"";
        }
        // Rain
        if (weather.rainThreeHour) {
            vc.rainIconNIV.hidden = NO;
            vc.rainNTF.stringValue = [NSString stringWithFormat:@"%.2f", [weather.rainThreeHour doubleValue]];
        } else {
            vc.rainIconNIV.hidden = YES;
            vc.rainNTF.stringValue = @"";
        }
        // Snow
        if (weather.snowThreeHour) {
            vc.snowIconNIV.hidden = NO;
            vc.snowNTF.stringValue = [NSString stringWithFormat:@"%.2f", [weather.snowThreeHour doubleValue]];
        } else {
            vc.snowIconNIV.hidden = YES;
            vc.snowNTF.stringValue = @"";
        }
        // Pressure and Sea level Pressure
        if (weather.mainPressure) {
            vc.pressureIconNIV.hidden = NO;
            vc.pressureNTF.stringValue = [NSString stringWithFormat:@"%.2f hPa", [weather.mainPressure doubleValue]];
            if (weather.mainSeaLevel) {
                vc.pressureAtSeaNTF.stringValue = [NSString stringWithFormat:@"%.2f hPa at Sealevel", [weather.mainSeaLevel doubleValue]];
            } else vc.pressureAtSeaNTF.stringValue = @"";
        } else {
            vc.pressureIconNIV.hidden = YES;
            vc.pressureNTF.stringValue = @"";
            vc.pressureAtSeaNTF.stringValue = @"";
        }
        
        // Sunrise - time
        if (weather.sysSunrise) {
            vc.sunriseIconNIV.hidden = NO;
            NSString *localSunriseDate = [NSDateFormatter localizedStringFromDate:weather.sysSunrise dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
            vc.sunriseTimeNTF.stringValue = localSunriseDate;
        } else {
            vc.sunriseIconNIV.hidden = YES;
            vc.sunriseTimeNTF.stringValue = @"";
        }
        
        // Sunset - time
        if (weather.sysSunset) {
            vc.sunsetIconNIV.hidden = NO;
            NSString *localSunriseDate = [NSDateFormatter localizedStringFromDate:weather.sysSunset dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
            vc.sunsetTimeNTF.stringValue = localSunriseDate;
        } else {
            vc.sunsetIconNIV.hidden = YES;
            vc.sunsetTimeNTF.stringValue = @"";
        }
        // Data fetch times
        if (weather.serverFetchDate) {
            vc.hourglassIconNIV.hidden = NO;
            NSString *serverFetchDate = [NSDateFormatter localizedStringFromDate:weather.serverFetchDate dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
            vc.lastFetchTimeNTF.stringValue = serverFetchDate;
            NSDate *now = [NSDate date];
            NSTimeInterval interval = [now timeIntervalSinceDate:weather.serverFetchDate];
            int seconds = (int)interval % 60;
            int minutes = ((int)interval / 60) % 60;
            vc.lastFetchAgoNTF.stringValue = [NSString stringWithFormat:@"%d minutes %d seconds ago", minutes,seconds];
        } else {
            vc.hourglassIconNIV.hidden = YES;
            vc.lastFetchTimeNTF.stringValue = @"";
            vc.lastFetchAgoNTF.stringValue = @"";
        }
        
        // Main weather icon
        if (weather.weather0Icon) {
            vc.weatherIconNIV.hidden = NO;
            vc.weatherIconNIV.image = [NSImage imageNamed:[Weather weatherIconImageName:weather.weather0Icon]];
        } else {
            vc.weatherIconNIV.hidden = YES;
        }
    });
}

// Handler to get the weather data for a city.
- (IBAction)getWeatherHandler:(id)sender {
    
    // Get the city.
    NSString *cityCountry = self.cityStateUserNTF.stringValue;
    if ([cityCountry compare:@""] == NSOrderedSame) {
        [self showAlertPopupWithMessage:@"Enter a City,Country"];
        return;
    }
    
    // Disable buttons so user is blocked until data is fetched.
    self.getWeatherNSB.enabled = NO;
    self.fetchProgressNPI.hidden = NO;
    [self.fetchProgressNPI startAnimation:self];
    
    // CHeck if the data is in CoreData database -- nil if no data or it is obsolete.
    Weather *cityWeather = [Weather weatherWithCityCountry:cityCountry inAppDelegate:self.appDelegate];
    __weak ViewController *weakSelf = self;
    if (!cityWeather) {
        // Get the data from the OpenWeatherOrg
        [Utilities downloadWeatherDataFromAPIForCityCountry:cityCountry
            // Success got JSON dictionary bac
            successHandler:^(NSDictionary *data) {
                __strong ViewController * strongSelf = weakSelf;
                if (strongSelf && data) {
                    Weather *weather = [Weather weatherWithOpenWeatherInfo:data inCityCountry:cityCountry inAppDelegate:strongSelf.appDelegate];
                    [strongSelf refreshUIWithWeatherData:weather inViewController:strongSelf];
                    
                    [strongSelf enableButtonsWithViewController:strongSelf];
                }
            }
            // Error case
            errorHandler:^(NSString *errorMessage) {
                __strong ViewController * strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf showAlertPopupWithMessage:errorMessage];
                    if (kATDebugErrorON) NSLog(@"getWeatherHandler-errorHandler:%@",errorMessage);
                    [strongSelf enableButtonsWithViewController:self];
                }
            }];
    } else {
        // Data was available in CoreData - show it
        [self refreshUIWithWeatherData:cityWeather inViewController:self];
        [self enableButtonsWithViewController:self];
    }
}

// Open the Map app and show where is the city that was fetched.
- (IBAction)mapItHandler:(id)sender {
    // URL to call apple maps app on Mac.
    // http://maps.apple.com/?q=50.894967,4.341626 -- drops a PIN.
    if([self.lastSavedLatLonOfCityState compare:@""] == NSOrderedSame) {
        [self showAlertPopupWithMessage:@"Latitude and Longitude information is not there"];
        return;
    }
    
    // Form the maps app URL.
    NSString *appUrlString =[NSString stringWithFormat: @"http://maps.apple.com/?q=%@", self.lastSavedLatLonOfCityState];
    NSURL *url = [NSURL URLWithString:[appUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    if (![[NSWorkspace sharedWorkspace] openURL:url]) {
        [self showAlertPopupWithMessage:@"Opening Maps did not succeed."];
    }
}

// Not working  yet
- (IBAction)shareItHandler:(id)sender {
}

// Won't work yet. Apple bug.
// https://forums.developer.apple.com/message/69921#69921
- (IBAction)tweetItHandler:(id)sender {
    // String to tweet
    NSDictionary *tweetText = @{@"status":@"Text to tweet"};
    
    // Get access to twitter account first.
    ACAccountStore *accountStore= [[ACAccountStore alloc] init];
    ACAccountType *twitterType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    NSArray *accountsArray = [accountStore accountsWithAccountType:twitterType];
    for (ACAccount *account in accountsArray ) {
        NSLog(@"Account name: %@", account.username);
    }
    
    NSLog(@"Accounts array: %ld, Account Type: %@", accountsArray.count, twitterType);
    
    [accountStore requestAccessToAccountsWithType:twitterType options:nil
        completion:^(BOOL granted, NSError *error) {
            NSArray *accounts = [accountStore accountsWithAccountType:twitterType];
            if (!error) {
                [self showAlertPopupWithMessage:[NSString stringWithFormat:@"Error: %@",error]];
            } else if (granted && accounts && accounts.count > 0) {
                ACAccount *twitterAccount = accounts[0]; // Get first account
                // Have successful access and now post the tweet.
                NSURL *requestURL = [NSURL URLWithString: @"https://api.twitter.com/1.1/statuses/update.json"];
                
                SLRequest *postRequest = [SLRequest requestForServiceType:ACAccountTypeIdentifierTwitter
                                                            requestMethod:SLRequestMethodPOST
                                                                      URL:requestURL parameters:tweetText];
                postRequest.account = twitterAccount;
                [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
                 {
                     NSArray *dataSource;
                     if (!error && responseData) {
                         dataSource = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                         if (dataSource.count != 0) {
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 // [self.tweetTableView reloadData];
                                 NSLog(@"tweetItHandler: %ld", dataSource.count);
                                 NSLog(@"tweetItHandler: %@", dataSource);
                             });
                         }
                     }
                 }];
                
            } else { // Something wrong. Could not show the app data.
                NSString *errMessage = [NSString stringWithFormat:@"Twitter Access Failed: granted:%d account:%ld", granted, accounts.count];
                [self showAlertPopupWithMessage:errMessage];
            }
        }];
}

// Clears all UI elements
- (void) initUI {
    // Set the UI to all hidden or empty
    self.cityStateFetchedNTF.stringValue = @"";
    self.mapItNSB.hidden = YES;
    self.shareItNSB.hidden = YES;
    self.tweetItNSB.hidden = YES;
    self.fetchProgressNPI.hidden = YES;
    self.tempIconNIV.hidden = YES;
    self.tempNowNTF.stringValue = @"";
    self.tempMaxIconNIV.hidden = YES;
    self.tempMaxNTF.stringValue = @"";
    self.tempMinIconNIV.hidden = YES;
    self.tempMinNTF.stringValue = @"";
    self.descriptionNTF.stringValue = @"";
    self.descriptionMainNTF.stringValue = @"";
    self.windSpeedIconNIV.hidden = YES;
    self.windSpeedNTF.stringValue = @"";
    self.windDirectionIconNIV.hidden = YES;
    self.windDirectionNTF.stringValue = @"";
    self.humidityIconNIV.hidden = YES;
    self.humidityNTF.stringValue = @"";
    self.rainIconNIV.hidden = YES;
    self.rainNTF.stringValue = @"";
    self.snowIconNIV.hidden = YES;
    self.snowNTF.stringValue = @"";
    self.pressureIconNIV.hidden = YES;
    self.pressureNTF.stringValue = @"";
    self.pressureAtSeaNTF.stringValue = @"";
    self.sunriseIconNIV.hidden = YES;
    self.sunriseTimeNTF.stringValue = @"";
    self.sunsetIconNIV.hidden = YES;
    self.sunsetTimeNTF.stringValue = @"";
    self.hourglassIconNIV.hidden = YES;
    self.lastFetchTimeNTF.stringValue = @"";
    self.lastFetchAgoNTF.stringValue = @"";
    self.weatherIconNIV.hidden = YES;
    self.lastSavedLatLonOfCityState = @"";
}

@end
