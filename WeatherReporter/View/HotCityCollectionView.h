//
//  HotCityCollectionView.h
//  WeatherReporter
//
//  Created by laolao on 16/9/18.
//  Copyright © 2016年 laolao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotCityCollectionView;

@protocol ClickDelegate <NSObject>

-(void)collectionview:(HotCityCollectionView *)collectionview clickTheLabel:(NSString *)city_name;

@end


@interface HotCityCollectionView : UIView

@property(nonatomic,strong)UICollectionView *cv;

@property(nonatomic,assign)id<ClickDelegate> delegate;

-(NSString *)selectTheCity;

@end
