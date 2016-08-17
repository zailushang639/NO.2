//
//  JXModel.h
//  项目一
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 HFK. All rights reserved.
//

#import "JSONModel.h"

@interface JXModel : JSONModel
@property (nonatomic,copy)NSString<Optional> *title;
@property (nonatomic,copy)NSString<Optional> *resourceLoc;
@property (nonatomic,copy)NSString<Optional> *picUrl;
@property (nonatomic,copy)NSString<Optional> *article;
@property (nonatomic,copy)NSString<Optional> *publishTime;
@property (nonatomic,copy)NSString<Optional> *excerpt;
@end
