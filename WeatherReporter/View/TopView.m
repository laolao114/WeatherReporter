//
//  TopView.m
//  WeatherReporter
//
//  Created by laolao on 16/9/14.
//  Copyright © 2016年 laolao. All rights reserved.
//

#import "TopView.h"
#import "TipsCollectionViewCell.h"

@interface TopView ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    WeatherModel *model;
}

@property(nonatomic,strong)UIView *bgView;

@end

@implementation TopView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubview:self.city];
        [self addSubview:self.temp];
        [self addSubview:self.status];
        [self addSubview:self.qlty];
        [self addSubview:self.tips];
        [self.city mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(35);
            make.centerX.equalTo(self);
        }];
        [self.temp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.city.mas_bottom).offset(20);
        }];
        [self.status mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.temp.mas_bottom).offset(20);
        }];
        [self.qlty mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.status.mas_bottom).offset(10);
            make.centerX.equalTo(self);
        }];
        [self addSubview:self.cv];
        [self.cv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(300);
            make.left.right.equalTo(self);
            make.height.equalTo(@110);
        }];
        
        [self addSubview:self.bgView];
    }
    return self;
}

-(void)getTheModel:(WeatherModel *)model1{
    model = model1;
}

#pragma mark - UICollection Delegate
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if([model.daily_forecast count] <= 6)
        return 6;
    else
        return [model.daily_forecast count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TipsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tips_cell" forIndexPath:indexPath];
    if(model != nil){
        [cell initWithModel:model indexPath:indexPath];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((ScreenWidth -1)/4 , 110);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0,0, 0, 0);//分别为上、左、下、右
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.section);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.cv.contentOffset.x < 0){
        [self.cv setContentOffset:CGPointMake(0, 0)];
    }
    if(self.cv.contentOffset.x > (self.cv.contentSize.width - ScreenWidth)){
        [self.cv setContentOffset:CGPointMake(self.cv.contentSize.width - ScreenWidth, 0)];
    }
}

-(UILabel *)label{
    if(_label == nil){
        _label =  [[UILabel alloc]initWithFrame:CGRectZero];
        _label.text = @"city";
        _label.numberOfLines = 0;
    }
    return _label;
}


-(UILabel *)city{
    if(_city == nil){
        _city =  [[UILabel alloc]initWithFrame:CGRectZero];
        _city.text = @"city";
        _city.textColor = [UIColor whiteColor];
        _city.numberOfLines = 0;
    }
    return _city;
}


-(UILabel *)temp{
    if(_temp == nil){
        _temp =  [[UILabel alloc]initWithFrame:CGRectZero];
        _temp.text = @"temp";
        _temp.textColor = [UIColor whiteColor];
        _temp.font = [UIFont boldSystemFontOfSize:45];
        _temp.numberOfLines = 0;
    }
    return _temp;
}


-(UILabel *)status{
    if(_status == nil){
        _status =  [[UILabel alloc]initWithFrame:CGRectZero];
        _status.text = @"status";
        _status.textColor = [UIColor whiteColor];
        _status.numberOfLines = 0;
        _status.font = [UIFont boldSystemFontOfSize:12];
    }
    return _status;
}

-(UILabel *)qlty{
    if(_qlty == nil){
        _qlty =  [[UILabel alloc]initWithFrame:CGRectZero];
        _qlty.text = @"qlty";
        _qlty.numberOfLines = 0;
        _qlty.textColor = [UIColor whiteColor];
        _qlty.font = [UIFont boldSystemFontOfSize:12];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(qlty_action:)];
        _qlty.userInteractionEnabled = YES;
        [_qlty addGestureRecognizer:gesture];
        
    }
    return _qlty;
}

-(UILabel *)tips{
    if(_tips == nil){
        _tips =  [[UILabel alloc]initWithFrame:CGRectZero];
        _tips.text = @"tips";
        _tips.numberOfLines = 0;
        _tips.textColor = [UIColor whiteColor];
    }
    return _tips;
}

-(UICollectionView *)cv{
    if(_cv == nil){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [_cv setBackgroundColor:[UIColor whiteColor]];
        _cv = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 70) collectionViewLayout:layout];
        _cv.delegate = self;
        _cv.dataSource = self;
        _cv.showsHorizontalScrollIndicator = NO;
        [_cv registerClass:[TipsCollectionViewCell class] forCellWithReuseIdentifier:@"tips_cell"];
    }
    return _cv;
}

-(UIView *)bgView{
    if(_bgView == nil){
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView * effe = [[UIVisualEffectView alloc]initWithEffect:blur];
        effe.frame = CGRectMake(0,0,ScreenWidth,ScreenHeight);
        [_bgView setBackgroundColor:UIColorFromRGBA(0xffffff, 0.1)];
        [_bgView addSubview:effe];
        _bgView.hidden = YES;
        [_bgView addSubview:self.aqi_title];
        [_bgView addSubview:self.aqi_label1];
        [_bgView addSubview:self.aqi_label2];
        [self.aqi_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bgView).offset(100);
            make.left.equalTo(_bgView).offset(50);
        }];
        [self.aqi_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.aqi_title.mas_bottom).offset(25);
            make.left.equalTo(_bgView).offset(50);
            make.width.equalTo(@120);
        }];
        [self.aqi_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.aqi_title.mas_bottom).offset(68);
            make.right.equalTo(_bgView).offset(-50);
            make.left.greaterThanOrEqualTo(self.aqi_label1.mas_right).offset(15);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidden_action:)];
        _bgView.userInteractionEnabled = YES;
        [_bgView addGestureRecognizer:tap];
        
    }
    return _bgView;
}

-(UILabel *)aqi_title{
    if(_aqi_title == nil){
        _aqi_title =  [[UILabel alloc]initWithFrame:CGRectZero];
        _aqi_title.text = @"title";
        _aqi_title.numberOfLines = 0;
        _aqi_title.textColor = [UIColor whiteColor];
    }
    return _aqi_title;
}

-(UILabel *)aqi_label1{
    if(_aqi_label1 == nil){
        _aqi_label1 =  [[UILabel alloc]initWithFrame:CGRectZero];
        _aqi_label1.text = @"label1";
        _aqi_label1.numberOfLines = 0;
        _aqi_label1.textColor = [UIColor whiteColor];
        _aqi_label1.font = [UIFont boldSystemFontOfSize:12];
    }
    return _aqi_label1;
}

-(UILabel *)aqi_label2{
    if(_aqi_label2 == nil){
        _aqi_label2 =  [[UILabel alloc]initWithFrame:CGRectZero];
        _aqi_label2.text = @"label2  1 2311 31 11 3";
        _aqi_label2.numberOfLines = 0;
        _aqi_label2.textColor = [UIColor whiteColor];
        _aqi_label2.font = [UIFont boldSystemFontOfSize:12];
    }
    return _aqi_label2;
}


-(void)qlty_action:(UITapGestureRecognizer *)gesture{
    if([[gesture view] isEqual:self.qlty]){
        self.bgView.hidden = NO;
    }
}

-(void)hidden_action:(UITapGestureRecognizer *)tap{
    if([[tap view] isEqual:self.bgView]){
        self.bgView.hidden = YES;
    }
}


@end
