//
//  SubModel.h
//  项目一
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 HFK. All rights reserved.
//

#import "JSONModel.h"
#import "TitleModel.h"
@interface SubModel : JSONModel
//@property (nonatomic,strong)TitleModel * titleModel;
@property (nonatomic,copy)NSString<Optional> *resourceLoc;
@property (nonatomic,copy)NSString<Optional> *excerpt;
@property (nonatomic,copy)NSString<Optional> *title;
@property (nonatomic,copy)NSString<Optional> *publishTime;
@property (nonatomic,copy)NSString<Optional> *origin;
@property (nonatomic,copy)NSString<Optional> *author;
@property (nonatomic,copy)NSString<Optional> *readCount;
@property (nonatomic,copy)NSString<Optional> *CommuntCount;
@property (nonatomic,copy)NSString<Optional> *post_cat;
@property (nonatomic,copy)NSString<Optional> *jumpType;
@property (nonatomic,copy)NSString<Optional> *articleType;
@property (nonatomic,copy)NSArray<Optional> *picUrlList;
@end
