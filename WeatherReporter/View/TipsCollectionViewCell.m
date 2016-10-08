//
//  TipsCollectionViewCell.m
//  WeatherReporter
//
//  Created by laolao on 16/9/14.
//  Copyright © 2016年 laolao. All rights reserved.
//

#import "TipsCollectionViewCell.h"

@implementation TipsCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.time];
        [self addSubview:self.tmp];
        [self addSubview:self.iv];
        [self addSubview:self.weather];
        [self addSubview:self.wind];
        [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.centerX.equalTo(self);
        }];
        [self.tmp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.time.mas_bottom).offset(5);
            make.centerX.equalTo(self);
        }];
        [self.iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tmp.mas_bottom).offset(5);
            make.height.width.equalTo(@20);
            make.centerX.equalTo(self);
        }];
        [self.weather mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iv.mas_bottom).offset(5);
            make.centerX.equalTo(self);
        }];
        [self.wind mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.weather.mas_bottom).offset(5);
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

-(void)initWithModel:(WeatherModel *)model indexPath:(NSIndexPath *)indexPath{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:[[model.daily_forecast objectAtIndex:indexPath.section] valueForKey:@"date"]];
    [formatter setDateFormat:@"MM.dd"];
    self.time.text = [formatter stringFromDate:date];
    self.tmp.text = [NSString stringWithFormat:@"%@°~%@°",[[[model.daily_forecast objectAtIndex:indexPath.section]valueForKey:@"tmp"] valueForKey:@"min"],[[[model.daily_forecast objectAtIndex:indexPath.section]valueForKey:@"tmp"] valueForKey:@"max"]];
    self.wind.text = [NSString stringWithFormat:@"%@ %@级",[[[model.daily_forecast objectAtIndex:indexPath.section] valueForKey:@"wind"] valueForKey:@"dir"],[[[model.daily_forecast objectAtIndex:indexPath.section] valueForKey:@"wind"] valueForKey:@"sc"]];
    
    self.weather.text = [[[model.daily_forecast objectAtIndex:indexPath.section]valueForKey:@"cond"] valueForKey:@"txt_d"];
    
    NSString *str = [[[model.daily_forecast objectAtIndex:indexPath.section]valueForKey:@"cond"] valueForKey:@"code_d"];
    [self.iv setImage:[UIImage imageNamed:str]];
    
}

-(UILabel *)time{
    if(_time == nil){
        _time = [[UILabel alloc]init];
        _time.textColor = UIColorFromRGBA(0x999999, 1);
        _time.font = [UIFont boldSystemFontOfSize:10];
        _time.text = @"time";
    }
    return _time;
}

-(UILabel *)tmp{
    if(_tmp == nil){
        _tmp = [[UILabel alloc]init];
        _tmp.textColor = UIColorFromRGBA(0x999999, 1);
        _tmp.font = [UIFont boldSystemFontOfSize:10];
        _tmp.text = @"tmp";
    }
    return _tmp;
}

-(UILabel *)wind{
    if(_wind == nil){
        _wind = [[UILabel alloc]init];
        _wind.textColor = UIColorFromRGBA(0x999999, 1);
        _wind.font = [UIFont boldSystemFontOfSize:10];
        _wind.text = @"wind";
    }
    return _wind;
}

-(UILabel *)weather{
    if(_weather == nil){
        _weather = [[UILabel alloc]init];
        _weather.textColor = UIColorFromRGBA(0x999999, 1);
        _weather.font = [UIFont boldSystemFontOfSize:10];
        _weather.text = @"weather";
    }
    return _weather;
}

-(UIImageView *)iv{
    if(_iv == nil){
        _iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"999"]];
    }
    return _iv;
}

@end
