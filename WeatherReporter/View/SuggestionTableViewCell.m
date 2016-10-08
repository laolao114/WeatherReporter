//
//  SuggestionTableViewCell.m
//  WeatherReporter
//
//  Created by laolao on 16/9/14.
//  Copyright © 2016年 laolao. All rights reserved.
//

#import "SuggestionTableViewCell.h"

@implementation SuggestionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self addSubview:self.suggestion_title];
        [self addSubview:self.brf];
        [self addSubview:self.detail];
        [self addSubview:self.line1];
        
        [self.suggestion_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self).offset(10);
        }];
        [self.brf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.suggestion_title.mas_bottom).offset(10);
            make.left.equalTo(self).offset(10);
        }];
        [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.brf.mas_bottom).offset(5);
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
        }];
        [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@1);
        }];
    }
    return self;
}

-(UILabel *)suggestion_title{
    if(_suggestion_title == nil){
        _suggestion_title = [[UILabel alloc]init];
        _suggestion_title.text = @"标题";
        _suggestion_title.font = [UIFont boldSystemFontOfSize:14];
        _suggestion_title.textColor = UIColorFromRGBA(0x666666, 1);
    }
    return _suggestion_title;
}

-(UILabel *)brf{
    if(_brf == nil){
        _brf = [[UILabel alloc]init];
        _brf.text = @"简介";
        _brf.font = [UIFont boldSystemFontOfSize:12];
        _brf.textColor = UIColorFromRGBA(0x333333, 1);
    }
    return _brf;
}

-(UILabel *)detail{
    if(_detail == nil){
        _detail = [[UILabel alloc]init];
        _detail.text = @"详细建议";
        _detail.numberOfLines = 0;
        _detail.font = [UIFont boldSystemFontOfSize:12];
        _detail.textColor = UIColorFromRGBA(0x333333, 1);
    }
    return _detail;
}

-(UIView *)line1{
    if(_line1 == nil){
        _line1 = [[UIView alloc]init];
        [_line1 setBackgroundColor:UIColorFromRGBA(0x999999, 1)];
    }
    return _line1;
}

@end
