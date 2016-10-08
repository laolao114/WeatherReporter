//
//  HourForecast.h
//  WeatherReporter
//
//  Created by laolao on 16/9/13.
//  Copyright © 2016年 laolao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HourForecast

@end

@interface windModel_hour : JSONModel

@property(nonatomic)NSString<Optional> *spd;

@property(nonatomic)NSString<Optional> *sc;

@property(nonatomic)NSString<Optional> *deg;

@property(nonatomic)NSString<Optional> *dir;

@end

@interface HourForecast : JSONModel

@property(nonatomic)NSString<Optional>  *date;

@property(nonatomic)NSString<Optional> *tmp;

@property(nonatomic)windModel_hour<Optional> *wind;

@property(nonatomic)NSString<Optional> *pop;

@property(nonatomic)NSString<Optional> *hum;

@property(nonatomic)NSString<Optional> *pres;

@end
