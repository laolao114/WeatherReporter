//
//  HotCityCollectionViewCell.h
//  WeatherReporter
//
//  Created by laolao on 16/9/18.
//  Copyright © 2016年 laolao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotCityCollectionViewCell;

@protocol HotCityCellDelegate <NSObject>

-(void)cell:(HotCityCollectionViewCell *)cell didTheLabelClick:(NSString *)city_name;

@optional

@end

@interface HotCityCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UILabel *title1;

@property(nonatomic,assign)id<HotCityCellDelegate>delegate;

@end
