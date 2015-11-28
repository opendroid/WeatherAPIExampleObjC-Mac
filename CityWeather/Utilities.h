//
//  Utilities.h
//  WeatherAPIExample
//
//  Created by Ajay Thakur on 11/25/15.
//  Copyright © 2015 Ajay Thaur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "Weather/Weather.h"

@interface Utilities : NSObject

+ (void) downloadWeatherDataFromAPIForCityCountry: (NSString *) cityCountry
                                   successHandler: (void(^) (NSDictionary * data)) successHandler
                                     errorHandler: (void(^) (NSString * errorMessage)) errorHandler;

@end
