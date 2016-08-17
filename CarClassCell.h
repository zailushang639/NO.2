//
//  CarClassCell.h
//  MyItem
//
//  Created by qianfeng on 16/3/24.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"
@interface CarClassCell : UITableViewCell
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)CarModel *model;

@end
