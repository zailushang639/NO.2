//
//  TableViewCell.h
//  MyItem
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubModel.h"
@interface TableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *picImage;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *originLabel;
@property(nonatomic,strong)UILabel *pubLishTimelabel;
@property(nonatomic,strong)UILabel *communtCountLabel;
@property(nonatomic,strong)SubModel *model;

@end
