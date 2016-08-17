//
//  CarModel.h
//  项目一
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 HFK. All rights reserved.
//

#import "JSONModel.h"

@interface CarModel : JSONModel
@property (nonatomic,copy)NSString<Optional> * brandIcon;
@property (nonatomic,copy)NSString<Optional> * brandId;
@property (nonatomic,copy)NSString<Optional> * brandName;



@property (nonatomic,copy)NSString<Optional> * seriesImage;
@property (nonatomic,copy)NSString<Optional> * seriesId;
@property (nonatomic,copy)NSString<Optional> * seriesName;
@property (nonatomic,copy)NSString<Optional> * seriesPrice;
@property (nonatomic,strong)NSMutableDictionary<Optional> * messageDic;

@property (nonatomic,copy)NSString<Optional> * guidePrice;

//
@property (nonatomic,copy)NSString<Optional> * dealerName;
@property (nonatomic,copy)NSString<Optional> * dealerId;
@property (nonatomic,copy)NSString<Optional> * carId;
@property (nonatomic,copy)NSString<Optional> * dealerTel;
@property (nonatomic,copy)NSString<Optional> * carPrice;
@property (nonatomic,copy)NSString<Optional> * newsId;
@property (nonatomic,copy)NSString<Optional> * newsTitle;
@property (nonatomic,copy)NSString<Optional> * newsLink;
@property (nonatomic,copy)NSString<Optional> * webLink;
@property (nonatomic,copy)NSString<Optional> * carName;
@property (nonatomic,copy)NSString<Optional> * carImage;

@end
