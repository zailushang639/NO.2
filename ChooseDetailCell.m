//
//  ChooseDetailCell.m
//  MyItem
//
//  Created by qianfeng on 16/3/24.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import "ChooseDetailCell.h"
#import "UIImageView+AFNetworking.h"
#import "Const.h"
#import "Masonry.h"
@implementation ChooseDetailCell
{
    UIView *_bgView;
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    KWS(ws);
    
    _bgView=[UIView new];
    [self.contentView addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    _picImage=[UIImageView new];
    [_bgView addSubview:_picImage];
    
    _seriesNameLabel=[UILabel new];
    [_bgView addSubview:_seriesNameLabel];
    
    _seriesPriceLabel=[UILabel new];
    [_bgView addSubview:_seriesPriceLabel];
    
    _guideLabel=[UILabel new];
    [_bgView addSubview:_guideLabel];
    
    _guidePriceLabels=[UILabel new];
    [_bgView addSubview:_guidePriceLabels];
    
    _typePic=[UIImageView new];
    [_bgView addSubview:_typePic];
    
    [_picImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView).offset(8);
        make.top.equalTo(_bgView).offset(4);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(55);
      
    }];
    
    _seriesNameLabel.font=[UIFont boldSystemFontOfSize:17];
    _seriesNameLabel.textAlignment=NSTextAlignmentLeft;
    
    [_seriesNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_picImage.mas_right).offset(4);
        make.top.equalTo(_bgView).offset(4);
        make.width.mas_equalTo(179);
        make.height.mas_equalTo(21);
        
    }];
    
    _seriesPriceLabel.textAlignment=NSTextAlignmentLeft;
    _seriesPriceLabel.font=[UIFont systemFontOfSize:15];
    
    [_seriesPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_picImage.mas_right).offset(4);
        make.top.equalTo(_seriesNameLabel.mas_bottom).offset(4);
        make.width.mas_equalTo(179);
        make.height.mas_equalTo(21);
        
        
    }];
    
    _guideLabel.textAlignment=NSTextAlignmentLeft;
    _guideLabel.font=[UIFont systemFontOfSize:14];
    _guideLabel.textColor=[UIColor blackColor];
    _guideLabel.text=@"指导价:";
    
    [_guideLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_picImage.mas_right).offset(4);
        make.top.equalTo(_seriesNameLabel.mas_bottom).offset(4);
        make.width.mas_equalTo(51);
        make.height.mas_equalTo(21);
        
    }];
    
    _guidePriceLabels.textAlignment=NSTextAlignmentLeft;
    _guidePriceLabels.textColor=[UIColor redColor];
    _guideLabel.font=[UIFont systemFontOfSize:15];
    
    [_guidePriceLabels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_guideLabel.mas_right).offset(0);
        make.top.equalTo(_seriesNameLabel.mas_bottom).offset(4);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(21);
        
    }];
    
    [_typePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView).offset(8);
        make.top.equalTo(_bgView).offset(4);
        make.width.mas_equalTo(36);
        make.height.mas_equalTo(27);
    }];
}





-(void)setModel:(CarModel *)model
{
    
    _model = model;
    [_picImage setImageWithURL:[NSURL URLWithString:model.seriesImage]];
    
    _seriesNameLabel.text = model.seriesName;
    
    if (self.typeId == 0)
    {
        _seriesPriceLabel.hidden = NO;
        _guideLabel.hidden = YES;
        _guidePriceLabels.hidden = YES;
        _seriesPriceLabel.text =model.seriesPrice;
        
    }
    
    if (self.typeId == 1)
    {
        _seriesPriceLabel.hidden = YES;
        _guideLabel.hidden = NO;
        _guidePriceLabels.hidden = NO;
        
        _guidePriceLabels.text = model.guidePrice;
        
        _typePic.image = [UIImage imageNamed:@"iconfont-iconfontnewjiaobiao.png"];
    }
    
    if (self.typeId == 2)
    {
        _seriesPriceLabel.hidden = YES;
        _guideLabel.hidden = NO;
        _guidePriceLabels.hidden = NO;
        
        _guidePriceLabels.text = model.seriesPrice;
        
        _typePic.image = [UIImage imageNamed:@"iconfont-iconfonthot.png"];
        
    }
    
    if (self.typeId == 3)
    {
        _seriesPriceLabel.hidden = YES;
        _guideLabel.hidden = NO;
        _guidePriceLabels.hidden = NO;
        
        _guidePriceLabels.text = model.guidePrice;
    }
    
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
