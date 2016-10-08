//
//  HotCityCollectionViewCell.m
//  WeatherReporter
//
//  Created by laolao on 16/9/18.
//  Copyright © 2016年 laolao. All rights reserved.
//

#import "HotCityCollectionViewCell.h"

@implementation HotCityCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubview:self.title1];
        [self.title1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(self);
        }];
    }
    return self;
}


-(UILabel *)title1{
    if(_title1 == nil){
        _title1 = [[UILabel alloc]init];
        _title1.font = [UIFont boldSystemFontOfSize:13];
        _title1.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_action)];
        [_title1 addGestureRecognizer:tap];
    }
    return _title1;
}

-(void)tap_action{
    if(self.delegate && [self.delegate respondsToSelector:@selector(cell:didTheLabelClick:)]){
        [self.delegate cell:self didTheLabelClick:self.title1.text];
    }
}

@end
