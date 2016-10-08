//
//  TipsCollectionViewCell.h
//  WeatherReporter
//
//  Created by laolao on 16/9/14.
//  Copyright © 2016年 laolao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"

@interface TipsCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UILabel *time;

@property(nonatomic,strong)UILabel *wind;

@property(nonatomic,strong)UILabel *weather;

@property(nonatomic,strong)UILabel *tmp;

@property(nonatomic,strong)UIImageView *iv;

-(void)initWithModel:(WeatherModel *)model indexPath:(NSIndexPath*)indexPath;

@end
