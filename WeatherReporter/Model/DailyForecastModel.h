//
//  DailyForecastModel.h
//  WeatherReporter
//
//  Created by laolao on 16/9/13.
//  Copyright © 2016年 laolao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DailyForecastModel

@end

@interface astroModel : JSONModel

@property(nonatomic)NSString<Optional> *sr;

@property(nonatomic)NSString<Optional> *ss;

@end

@interface condModel_daily : JSONModel

@property(nonatomic)NSString<Optional> *code_d;

@property(nonatomic)NSString<Optional> *txt_d;

@property(nonatomic)NSString<Optional> *code_n;

@property(nonatomic)NSString<Optional> *txt_n;

@end

@interface tmpModel : JSONModel

@property(nonatomic)NSInteger *max;

@property(nonatomic)NSInteger *min;

@end

@interface windModel_daily : JSONModel

@property(nonatomic)NSString<Optional> *spd;

@property(nonatomic)NSString<Optional> *sc;

@property(nonatomic)NSString<Optional> *deg;

@property(nonatomic)NSString<Optional> *dir;

@end

@interface DailyForecastModel : JSONModel

@property(nonatomic)astroModel<Optional> *astro;

@property(nonatomic)NSString<Optional>  *date;

@property(nonatomic)tmpModel<Optional> *tmp;

@property(nonatomic)windModel_daily<Optional> *wind;

@property(nonatomic)condModel_daily<Optional> *cond;

@property(nonatomic)NSString<Optional> *pcnc;

@property(nonatomic)NSString<Optional> *pop;

@property(nonatomic)NSString<Optional> *hum;

@property(nonatomic)NSString<Optional> *pres;

@property(nonatomic)NSString<Optional> *vis;

@end
