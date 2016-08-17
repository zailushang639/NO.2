//
//  ChooseDetailCell.h
//  MyItem
//
//  Created by qianfeng on 16/3/24.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"
@interface ChooseDetailCell : UITableViewCell
@property(nonatomic,strong)UIImageView *picImage;
@property(nonatomic,strong)UILabel *seriesNameLabel;

@property(nonatomic,strong)UILabel *seriesPriceLabel;
@property(nonatomic,strong)CarModel *model;
@property(nonatomic,strong)UILabel *guideLabel;

@property(nonatomic,strong)UILabel *guidePriceLabels;
@property (nonatomic,assign) NSInteger typeId;
@property(nonatomic,strong)UIImageView *typePic;

@end
