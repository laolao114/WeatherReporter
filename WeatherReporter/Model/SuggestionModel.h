//
//  SuggestionModel.h
//  WeatherReporter
//
//  Created by laolao on 16/9/13.
//  Copyright © 2016年 laolao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface comfModel : JSONModel

@property(nonatomic)NSString<Optional> *brf;

@property(nonatomic)NSString<Optional> *txt;

@end

@interface cwModel : JSONModel

@property(nonatomic)NSString<Optional> *brf;

@property(nonatomic)NSString<Optional> *txt;

@end

@interface drsgModel : JSONModel

@property(nonatomic)NSString<Optional> *brf;

@property(nonatomic)NSString<Optional> *txt;

@end

@interface fluModel : JSONModel

@property(nonatomic)NSString<Optional> *brf;

@property(nonatomic)NSString<Optional> *txt;

@end

@interface sportModel : JSONModel

@property(nonatomic)NSString<Optional> *brf;

@property(nonatomic)NSString<Optional> *txt;

@end

@interface travModel : JSONModel

@property(nonatomic)NSString<Optional> *brf;

@property(nonatomic)NSString<Optional> *txt;

@end

@interface uvModel : JSONModel

@property(nonatomic)NSString<Optional> *brf;

@property(nonatomic)NSString<Optional> *txt;

@end



@interface SuggestionModel : JSONModel

@property(nonatomic)comfModel<Optional> *comf;

@property(nonatomic)uvModel<Optional> *uv;

@property(nonatomic)cwModel<Optional> *cw;

@property(nonatomic)travModel<Optional> *trav;

@property(nonatomic)fluModel<Optional> *flu;

@property(nonatomic)sportModel<Optional> *sport;

@property(nonatomic,strong)drsgModel<Optional> *drsg;

@end
