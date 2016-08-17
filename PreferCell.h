//
//  PreferCell.h
//  MyItem
//
//  Created by qianfeng on 16/3/25.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"
@interface PreferCell : UITableViewCell

@property(nonatomic,copy)void(^pushBlock)();

@property (weak, nonatomic) IBOutlet UILabel *carNameLable;
@property (weak, nonatomic) IBOutlet UIImageView *carImage;
@property (weak, nonatomic) IBOutlet UILabel *preferPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *carPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *seriesNameLabel;
- (IBAction)teleAction:(id)sender;
- (IBAction)turnToWebAction:(id)sender;
@property (nonatomic,strong)CarModel *model;

@end
