//
//  AqiModel.h
//  WeatherReporter
//
//  Created by laolao on 16/9/13.
//  Copyright © 2016年 laolao. All rights reserved.
//

@interface cityModel : JSONModel

@property(nonatomic)NSString *aqi;

@property(nonatomic)NSString<Optional> *pm25;

@property(nonatomic)NSString<Optional> *pm10;

@property(nonatomic)NSString<Optional> *so2;

@property(nonatomic)NSString<Optional> *no2;

@property(nonatomic)NSString<Optional> *co;

@property(nonatomic)NSString<Optional> *o3;

@property(nonatomic)NSString<Optional> *qlty;

@end


@interface AqiModel : JSONModel

@property(nonatomic)cityModel *city;


@end
