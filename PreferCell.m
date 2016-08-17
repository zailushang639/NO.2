//
//  PreferCell.m
//  MyItem
//
//  Created by qianfeng on 16/3/25.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import "PreferCell.h"
#import "UIImageView+AFNetworking.h"
#import "Const.h"
@implementation PreferCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setFrame:(CGRect)frame{
    
    frame.size.width = _WIDTH;
    [super setFrame:frame];
    
    
    
    
}
-(void)setModel:(CarModel *)model{
    
    _model = model;
    _carNameLable.text = model.carName;
    _carPriceLabel.text =[NSString stringWithFormat:@"现价:%@万",model.carPrice] ;
    [_carImage setImageWithURL:[NSURL URLWithString:model.carImage]];
    
    float num = [model.guidePrice floatValue]-[model.carPrice floatValue];
    _preferPriceLabel.text = [NSString stringWithFormat:@"最高优惠:%g万",num];
    _seriesNameLabel.text = model.dealerName;
    
    
}

- (IBAction)teleAction:(id)sender {
    NSLog(@"打电话");
}

- (IBAction)turnToWebAction:(id)sender {
     _pushBlock();
}
@end
