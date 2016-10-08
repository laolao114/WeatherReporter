//
//  TopView.h
//  WeatherReporter
//
//  Created by laolao on 16/9/14.
//  Copyright © 2016年 laolao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"

@interface TopView : UIView

@property(nonatomic,strong)UILabel *label;

@property(nonatomic,strong)UILabel *qlty;

@property(nonatomic,strong)UILabel *tips;

@property(nonatomic,strong)UILabel *city;

@property(nonatomic,strong)UILabel *temp;

@property(nonatomic,strong)UILabel *status;

@property(nonatomic,strong)UICollectionView *cv;

-(void)getTheModel:(WeatherModel *)model1;

@property(nonatomic,strong)UILabel *aqi_title;

@property(nonatomic,strong)UILabel *aqi_label1;

@property(nonatomic,strong)UILabel *aqi_label2;

@end
