//
//  HotCityCollectionView.m
//  WeatherReporter
//
//  Created by laolao on 16/9/18.
//  Copyright © 2016年 laolao. All rights reserved.
//

#import "HotCityCollectionView.h"
#import "HotCityCollectionViewCell.h"

@interface HotCityCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,HotCityCellDelegate>{
    NSArray *hot_city;
    NSString *choosed_city;
}


@end

@implementation HotCityCollectionView

-(instancetype)init{
    if(self = [super init]){
        hot_city = @[@"定位",@"北京",@"上海",@"广州",@"深圳",@"珠海",@"佛山",@"南京",@"苏州",@"杭州",@"济南",@"青岛",@"郑州",@"石家庄",@"福州",@"厦门",@"武汉",@"长沙",@"成都",@"重庆",@"太原",@"沈阳",@"南宁",@"西安"];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.cv];
        [self.cv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [hot_city count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotCityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"city_collection_cell" forIndexPath:indexPath];
    cell.layer.borderWidth = 0.5;
    cell.layer.borderColor = [UIColor grayColor].CGColor;
    cell.title1.text = hot_city[indexPath.row];
    cell.delegate = self;
    return cell;
}

-(void)cell:(HotCityCollectionViewCell *)cell didTheLabelClick:(NSString *)city_name{
    NSLog(@"view tap %@",city_name);
    if(self.delegate && [self.delegate respondsToSelector:@selector(collectionview:clickTheLabel:)]){
        [self.delegate collectionview:self clickTheLabel:city_name];
    }
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((ScreenWidth - 40 - 1)/3, 40);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0,0, 0, 0);//分别为上、左、下、右
}

-(UICollectionView *)cv{
    if(_cv == nil){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _cv = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 41, 320) collectionViewLayout:layout];
        [_cv setBackgroundColor:[UIColor whiteColor]];
        _cv.delegate = self;
        _cv.dataSource = self;
        _cv.showsHorizontalScrollIndicator = NO;
        _cv.scrollEnabled = NO;
        [_cv registerClass:[HotCityCollectionViewCell class] forCellWithReuseIdentifier:@"city_collection_cell"];
    }
    return _cv;
}

@end
