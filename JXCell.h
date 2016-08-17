//
//  JXCell.h
//  MyItem
//
//  Created by qianfeng on 16/3/23.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXModel.h"
@interface JXCell : UITableViewCell
@property (nonatomic, strong) UIImageView *picUrl;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *excerptLabel;
@property (strong, nonatomic) UILabel *publishTime;
@property (nonatomic, strong) JXModel * model;
@end
