//
//  BasicCityInfo.h
//  WeatherReporter
//
//  Created by laolao on 16/9/13.
//  Copyright © 2016年 laolao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateModel : JSONModel

@property(nonatomic)NSString *loc;

@property(nonatomic)NSString *utc;

@end

@interface BasicCityInfo : JSONModel

@property(nonatomic)NSString *city;

@property(nonatomic)NSString *id;

@property(nonatomic)NSString<Optional> *cnty;

@property(nonatomic)NSString<Optional> *lat;

@property(nonatomic)NSString<Optional> *lon;

@property(nonatomic)UpdateModel<Optional> *update;

@end

