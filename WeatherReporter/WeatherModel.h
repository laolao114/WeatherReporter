//
//  WeatherModel.h
//  WeatherReporter
//
//  Created by laolao on 16/8/22.
//  Copyright © 2016年 laolao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicCityInfo.h"
#import "AqiModel.h"
#import "SuggestionModel.h"
#import "DailyForecastModel.h"
#import "HourForecast.h"
#import "NowWeatherModel.h"

@interface WeatherModel : JSONModel

@property(nonatomic)BasicCityInfo *basic;

@property(nonatomic)AqiModel *aqi;

@property(nonatomic)NSArray<DailyForecastModel> *daily_forecast;

@property(nonatomic)NSArray<HourForecast> *hourly_forecast;

@property(nonatomic)NSString<Optional> *status;

@property(nonatomic)SuggestionModel *suggestion;

@property(nonatomic)NowWeatherModel<Optional> *now;

@end
