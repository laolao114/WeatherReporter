//
//  ViewController.m
//  WeatherReporter
//
//  Created by laolao on 16/8/22.
//  Copyright © 2016年 laolao. All rights reserved.
//

#import "ViewController.h"
#import "WeatherModel.h"
#import "WeatherViewController.h"
#import "WeatherModel.h"
#import "TipsCollectionViewCell.h"
#import "TopView.h"
#import "MJRefresh.h"
#import "SuggestionTableViewCell.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,WeatherViewControllerDelegate>{
    NSDictionary *dic;
    WeatherModel *model;
    NSArray *array;
    NSArray *cityarr;
    NSMutableArray *mutarray;
    NSInteger statuscode;
    NSString *str;
    NSString *city_id_string;
}

@property(nonatomic,strong)TopView *view1;

@property(nonatomic,strong)UITableView *tv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    NSString *httpUrl = [NSString stringWithFormat:@"https://api.heweather.com/x3/weather?cityid=%@&key=6d6f1e69a598405ba3c23cd0ad53ee05",city_id_string];  
    [self request: httpUrl];
}

-(void)initView{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.title = @"天气预报";
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"地標icon"] style:UIBarButtonItemStylePlain target:self action:@selector(action)];
    self.navigationItem.rightBarButtonItem = item2;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.tv];
    [self.tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
 
   }

-(void)action{
    WeatherViewController *wvc = [[WeatherViewController alloc]init];
    wvc.delegate = self;
    [self.navigationController pushViewController:wvc animated:YES];
}

-(void)wvc:(WeatherViewController *)wvc didSelectACity:(NSString *)city_id{
    city_id_string = city_id;
    NSString *httpUrl = [NSString stringWithFormat:@"https://api.heweather.com/x3/weather?cityid=%@&key=6d6f1e69a598405ba3c23cd0ad53ee05",city_id_string];
    [self request: httpUrl];
}

-(void)changeBgView{
    switch (statuscode) {
        case 100:{       //晴
            [self.view1 setBackgroundColor:UIColorFromRGBA(0x6495ED, 1)];
        }
            break;
        case 101:
        case 103:{      //多云
            [self.view1 setBackgroundColor:UIColorFromRGBA(0x4169E1, 1)];
        }
            break;
        case 102:{      //少云
            [self.view1 setBackgroundColor:UIColorFromRGBA(0x87CEFA, 1)];
        }
        case 104:{      //阴
            [self.view1 setBackgroundColor:UIColorFromRGBA(0x708090, 1)];
        }
        case 200:
        case 201:
        case 202:
        case 203:
        case 204:{       //有风
            [self.view1 setBackgroundColor:UIColorFromRGBA(0x20B2AA, 1)];
        }
            break;
        case 205:
        case 206:
        case 207:
        case 208:
        case 209:
        case 210:
        case 211:
        case 212:
        case 213:{
             [self.view1 setBackgroundColor:UIColorFromRGBA(0x191970, 1)];
        }
        case 300:
        case 305:
        case 309:{      //阵雨
            [self.view1 setBackgroundColor:UIColorFromRGBA(0xB0C4DE, 1)];
        }
            break;
        case 301:
        case 302:
        case 303:
        case 304:
        case 306:
        case 307:
        case 308:
        case 310:
        case 311:
        case 312:{
            [self.view1 setBackgroundColor:UIColorFromRGBA(0x4B0082, 1)];
        }
        case 400:{     //小雪
            [self.view1 setBackgroundColor:UIColorFromRGBA(0xE1FFFF, 1)];
        }
            break;
        case 401:
        case 402:
        case 403:
        case 404:
        case 405:
        case 406:
        case 407:{
            [self.view1 setBackgroundColor:UIColorFromRGBA(0x000080, 1)];
        }
        case 500:
        case 501:
        case 502:
        case 503:
        case 504:
        case 506:{      //薄雾
            [self.view1 setBackgroundColor:UIColorFromRGBA(0xFAFAD2, 1)];
        }
            break;
        case 507:
        case 508:{
            [self.view1 setBackgroundColor:UIColorFromRGBA(0x778899, 1)];
        }
        case 900:{
            [self.view1 setBackgroundColor:UIColorFromRGBA(0xFF0000, 1)];
        }
        case 901:{
             [self.view1 setBackgroundColor:UIColorFromRGBA(0x0000FF, 1)];
        }
        default:
            break;
    }
}

-(void)request: (NSString*)httpUrl {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@", httpUrl];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                                   [self.tv.mj_header endRefreshing];
                               } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   dic = [[[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error] valueForKey:@"HeWeather data service 3.0"] objectAtIndex:0];
                                   model = [[WeatherModel alloc]initWithDictionary:dic error:&error];
                                   [self.view1 getTheModel:model];
                                   [self changeTheUIData];
                                   [self.tv.mj_header endRefreshing];
                                NSLog(@"%ld",(long)responseCode);
                               }
                           }];
}

-(void)changeTheUIData{
    self.view1.city.text = model.basic.city;
    self.view1.temp.text = [NSString stringWithFormat:@"%@°",model.now.tmp];
    statuscode = [[[[model valueForKey:@"now"]valueForKey:@"cond"]valueForKey:@"code"] intValue];
    [self changeBgView];
    self.view1.status.text = [model.now.cond valueForKey:@"txt"];
    self.view1.qlty.text = [NSString stringWithFormat:@"空气质量 %@ >",[model.aqi.city valueForKey:@"qlty"]];
    self.view1.aqi_title.text = [NSString stringWithFormat:@"空气质量 %@",[model.aqi.city valueForKey:@"qlty"]];
    self.view1.aqi_label1.text = [NSString stringWithFormat:@"空气质量指数: %@\n\n\nCO: %@μg/m³\n\nNO2: %@μg/m³\n\nO3: %@μg/m³",[model.aqi.city valueForKey:@"aqi"],[model.aqi.city valueForKey:@"co"],[model.aqi.city valueForKey:@"no2"],[model.aqi.city valueForKey:@"o3"]];
    self.view1.aqi_label2.text = [NSString stringWithFormat:@"pm25: %@μg/m³\n\npm10: %@μg/m³\n\nso2: %@μg/m³",[model.aqi.city valueForKey:@"pm25"],[model.aqi.city valueForKey:@"pm10"],[model.aqi.city valueForKey:@"so2"]];
    [self.view1.cv reloadData];
    [self.tv reloadData];
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////


#pragma mark -UITableview delegate

////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SuggestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"table_cell"];
    if(model != nil){
    switch (indexPath.row) {
        case 0:
            cell.suggestion_title.text = @"舒适度";
            cell.brf.text = [[model.suggestion valueForKey:@"comf"] valueForKey:@"brf"];
            cell.detail.text = [[model.suggestion valueForKey:@"comf"] valueForKey:@"txt"];
            break;
        case 1:
            cell.suggestion_title.text = @"洗车建议";
            cell.brf.text = [[model.suggestion valueForKey:@"cw"] valueForKey:@"brf"];
            cell.detail.text = [[model.suggestion valueForKey:@"cw"] valueForKey:@"txt"];
            break;
        case 2:
            cell.suggestion_title.text = @"穿衣建议";
            cell.brf.text = [[model.suggestion valueForKey:@"drsg"] valueForKey:@"brf"];
            cell.detail.text = [[model.suggestion valueForKey:@"drsg"] valueForKey:@"txt"];
            break;
        case 3:
            cell.suggestion_title.text = @"防感冒建议";
            cell.brf.text = [[model.suggestion valueForKey:@"flu"] valueForKey:@"brf"];
            cell.detail.text = [[model.suggestion valueForKey:@"flu"] valueForKey:@"txt"];
            break;
        case 4:
            cell.suggestion_title.text = @"运动建议";
            cell.brf.text = [[model.suggestion valueForKey:@"sport"] valueForKey:@"brf"];
            cell.detail.text = [[model.suggestion valueForKey:@"sport"] valueForKey:@"txt"];
            break;
        case 5:
            cell.suggestion_title.text = @"旅游建议";
            cell.brf.text = [[model.suggestion valueForKey:@"trav"] valueForKey:@"brf"];
            cell.detail.text = [[model.suggestion valueForKey:@"trav"] valueForKey:@"txt"];
        case 6:
            cell.suggestion_title.text = @"防晒建议";
            cell.brf.text = [[model.suggestion valueForKey:@"uv"] valueForKey:@"brf"];
            cell.detail.text = [[model.suggestion valueForKey:@"uv"] valueForKey:@"txt"];
            break;
        default:
            break;
    }
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(TopView *)view1{
    if(_view1 == nil){
        _view1 = [[TopView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 410)];

    }
    return _view1;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y > scrollView.contentSize.height - ScreenHeight){
        [scrollView setContentOffset:CGPointMake(0, scrollView.contentSize.height - ScreenHeight)];
    }
}

-(UITableView *)tv{
    if(_tv == nil){
        _tv = [[UITableView alloc]init];
        _tv.delegate = self;
        _tv.dataSource = self;
        _tv.showsVerticalScrollIndicator = NO;
        _tv.allowsSelection = NO;
        MJRefreshHeader *header = [[MJRefreshHeader alloc]init];
        header = [MJRefreshHeader headerWithRefreshingBlock:^{
            [self updateData];
        }];
        [_tv setMj_header:header];
        [_tv setTableHeaderView:self.view1];
        [_tv registerClass:[SuggestionTableViewCell class] forCellReuseIdentifier:@"table_cell"];
        _tv.separatorStyle =  UITableViewCellSeparatorStyleNone;
        city_id_string = @"CN101280101";
    }
    return _tv;
}

-(void)updateData{
    NSString *httpUrl = [NSString stringWithFormat:@"https://api.heweather.com/x3/weather?cityid=%@&key=6d6f1e69a598405ba3c23cd0ad53ee05",city_id_string];
    [self request: httpUrl];
    [self.tv.mj_header endRefreshing];
}

@end
