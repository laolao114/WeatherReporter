//
//  WeatherViewController.h
//  WeatherReporter
//
//  Created by laolao on 16/9/13.
//  Copyright © 2016年 laolao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherViewController;

@protocol WeatherViewControllerDelegate <NSObject>

-(void)wvc:(WeatherViewController *)wvc didSelectACity:(NSString *)city_id;

@end


@interface WeatherViewController : UIViewController

@property(nonatomic,assign)id<WeatherViewControllerDelegate>delegate;

@end
