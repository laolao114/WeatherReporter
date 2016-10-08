//
//  WeatherViewController.m
//  WeatherReporter
//
//  Created by laolao on 16/9/13.
//  Copyright © 2016年 laolao. All rights reserved.
//




#import "WeatherViewController.h"
#import "WeatherModel.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "HotCityCollectionView.h"


@interface WeatherViewController ()<CLLocationManagerDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,ClickDelegate>{
    NSDictionary *dic;
    CLLocationManager *locationmanager;
    NSString *cityid;
    NSString *location_name;
}

@property(nonatomic,strong)WeatherModel *wmodel;

@property(nonatomic,strong)UIButton *button1;

@property(nonatomic,strong)UIActivityIndicatorView *indicator; 

@property(nonatomic,strong)UISearchBar *scv;

@property(nonatomic,strong)NSMutableArray *all_city_info;

@property(nonatomic,strong)NSMutableArray *city_arr;

@property(nonatomic,strong)NSMutableArray *filter_city;

@property(nonatomic,strong)UITableView *tv;

@property(nonatomic,strong)HotCityCollectionView *hccv;

@property(nonatomic,strong)UIBarButtonItem *item;

@end


@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *cityURL = @"https://api.heweather.com/x3/citylist?search=allchina&key=6d6f1e69a598405ba3c23cd0ad53ee05";
    [self cityrequest : cityURL];
    [self.view setBackgroundColor:UIColorFromRGBA(0xffffff, 1)];
    [self.navigationItem setTitle:@"选择城市"];
    
    
    [self.view addSubview:self.scv];
    [self.scv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
    }];
    [self.view addSubview:self.tv];
    [self.tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scv.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@300);
    }];
    
    [self.view addSubview:self.hccv];
    [self.hccv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(150);
        make.height.equalTo(@320);
        make.left.equalTo(self.view).offset(20);
        make.width.mas_equalTo(ScreenWidth - 40);
    }];

    locationmanager = [[CLLocationManager alloc]init];
    [locationmanager setDesiredAccuracy:kCLLocationAccuracyBest];
    locationmanager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
    locationmanager.delegate = self;
    [locationmanager requestAlwaysAuthorization];
    [locationmanager startUpdatingLocation];
}

-(void)action{
    self.tv.hidden = YES;
    [self.scv resignFirstResponder];
    self.hccv.hidden = NO;
//    self.navigationItem.rightBarButtonItem
}

-(void)cityrequest:(NSString *)cityURL{
    NSURL *URL = [NSURL URLWithString:cityURL];
    NSMutableURLRequest *requeset = [[NSMutableURLRequest alloc]initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [requeset setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:requeset queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError){
            NSLog(@"httperror: %@%ld",connectionError.localizedDescription,connectionError.code);
        }else{
            self.all_city_info = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&connectionError] valueForKey:@"city_info"];
            self.city_arr = [self.all_city_info valueForKey:@"city"];
            self.filter_city = [self.city_arr mutableCopy];
            [self.tv reloadData];
        }
    }];
}


-(void)collectionview:(HotCityCollectionView *)collectionview clickTheLabel:(NSString *)city_name{
    NSLog(@"%@",city_name);
    if([city_name isEqualToString:@"定位"]){
        city_name = location_name;
    }
    
    
    for(int i = 0; i< [self.all_city_info count]; i++){
        if([[self.all_city_info[i] valueForKey:@"city"] isEqualToString:city_name]){
            cityid = [self.all_city_info[i] valueForKey:@"id"];
            NSLog(@"%@",cityid);
            break;
        }
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(wvc:didSelectACity:)]){
        [self.delegate wvc:self didSelectACity:cityid];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"error!");
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    NSLog(@"%lu", (unsigned long)[locations count]);
    CLLocation *newLocation = locations[0];
    CLLocationCoordinate2D oldCoordinate = newLocation.coordinate;
    NSLog(@"旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);
    [manager stopUpdatingLocation];
    
    //------------------位置反编码---5.0之后使用-----------------
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks, NSError *error){
                       
                       for (CLPlacemark *place in placemarks) {
//                           NSLog(@"name,%@",place.name);                       // 位置名
//                           NSLog(@"thoroughfare,%@",place.thoroughfare);       // 街道
//                           NSLog(@"subThoroughfare,%@",place.subThoroughfare); // 子街道
//                           NSLog(@"locality,%@",place.locality);               // 市
                           location_name = [place.locality substringToIndex:place.locality.length -1];
                           NSLog(@"%@",location_name);
//                           NSLog(@"subLocality,%@",place.subLocality);         // 区
//                           NSLog(@"country,%@",place.country);                 // 国家
                       }
                   }];
    [self.indicator stopAnimating];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    for(int i = 0; i< [self.all_city_info count]; i++){
        if([[self.all_city_info[i] valueForKey:@"city"] isEqualToString:cell.textLabel.text]){
            cityid = [self.all_city_info[i] valueForKey:@"id"];
            NSLog(@"%@",cityid);
            break;
        }
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(wvc:didSelectACity:)]){
        [self.delegate wvc:self didSelectACity:cityid];
    }
    [self.navigationController popViewControllerAnimated:YES];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.filter_city count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"table_cell" forIndexPath:indexPath];
    cell.textLabel.text = self.filter_city[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UIBarButtonItem *)item{
    if(_item == nil){
        _item = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(action)];
    }
    return _item;
}

-(UIButton *)button1{
    if(_button1 == nil){
        _button1 = [[UIButton alloc]init];
        [_button1 setTitle:@"click" forState:UIControlStateNormal];
        [_button1 setBackgroundColor:[UIColor redColor]];
        [_button1 addTarget:self action:@selector(click_action) forControlEvents:UIControlEventTouchDown];
    }
    return _button1;
}

-(UIActivityIndicatorView *)indicator{
    if(_indicator == nil){
        _indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    }
    return _indicator;
}

-(UISearchBar *)scv{
    if(_scv == nil){
        _scv = [[UISearchBar alloc]init];
        _scv.placeholder = @"查找城市";
        _scv.delegate = self;
    }
    return _scv;
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar; {
    self.tv.hidden = NO;
    self.hccv.hidden = YES;
    self.navigationItem.rightBarButtonItem = self.item;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(![self.scv.text isEqualToString:@""]){
        [self.filter_city removeAllObjects];
        NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", self.scv.text];
        self.filter_city = [[self.city_arr filteredArrayUsingPredicate:searchPredicate] mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tv reloadData];
        });
    }
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    self.tv.hidden = YES;
    self.hccv.hidden = NO;
    self.navigationItem.rightBarButtonItem = nil;
}


-(UITableView *)tv{
    if(_tv == nil){
        _tv = [[UITableView alloc]init];
        _tv.delegate = self;
        _tv.dataSource = self;
        [_tv registerClass:[UITableViewCell class] forCellReuseIdentifier:@"table_cell"];
        _tv.hidden = YES;
    }
    return _tv;
}

-(void)click_action{
    NSLog(@"click");
    [locationmanager startUpdatingLocation];
}

-(NSMutableArray *)city_arr{
    if(_city_arr == nil){
        _city_arr = [[NSMutableArray alloc]init];
    }
    return _city_arr;
}

-(NSMutableArray *)filter_city{
    if(_filter_city == nil){
        _filter_city = [[NSMutableArray alloc]init];
    }
    return _filter_city;
}

-(NSMutableArray *)all_city_info{
    if(_all_city_info == nil){
        _all_city_info = [[NSMutableArray alloc]init];
    }
    return _all_city_info;
}

-(HotCityCollectionView *)hccv{
    if(_hccv == nil){
        _hccv = [[HotCityCollectionView alloc]init];
        _hccv.delegate = self;
    }
    return _hccv;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(![self.scv isExclusiveTouch]){
        [self.scv resignFirstResponder];
    }
    if([self.tv isExclusiveTouch]){
        [self.scv resignFirstResponder];
    }
}

@end
