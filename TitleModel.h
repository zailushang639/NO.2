//
//  TitleModel.h
//  项目一
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 HFK. All rights reserved.
//

#import "JSONModel.h"

@interface TitleModel : JSONModel
@property (nonatomic,copy)NSString<Optional> *title;
@property (nonatomic,copy)NSString<Optional> *picUrl;
@property (nonatomic,copy)NSString<Optional> *jumpType;
@property (nonatomic,copy)NSString<Optional> *playTime;
@property (nonatomic,copy)NSString<Optional> *resourceLoc;
@end
