//
//  NowWeatherModel.h
//  WeatherReporter
//
//  Created by laolao on 16/9/13.
//  Copyright © 2016年 laolao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface condMd : JSONModel

@property(nonatomic)NSInteger *code;

@property(nonatomic)NSString<Optional> *txt;

@end

@interface windMd : JSONModel

@property(nonatomic)NSString<Optional> *spd;

@property(nonatomic)NSString<Optional> *sc;

@property(nonatomic)NSString<Optional> *deg;

@property(nonatomic)NSString<Optional> *dir;

@end

@interface NowWeatherModel : JSONModel

@property(nonatomic)NSString<Optional> *tmp;

@property(nonatomic)NSString<Optional> *fl;

@property(nonatomic)windMd<Optional> *wind;

@property(nonatomic)condMd<Optional> *cond;

@property(nonatomic)NSString<Optional> *pcpn;

@property(nonatomic)NSString<Optional> *hum;

@property(nonatomic)NSString<Optional> *pres;

@property(nonatomic)NSString<Optional> *vis;

@end
