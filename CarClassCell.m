//
//  CarClassCell.m
//  MyItem
//
//  Created by qianfeng on 16/3/24.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import "CarClassCell.h"
#import "UIImageView+AFNetworking.h"
#import "Masonry.h"
#import "Const.h"
@implementation CarClassCell
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
    
    
    _icon=[UIImageView new];
    [_bgView addSubview:_icon];
    _name=[UILabel new];
    [_bgView addSubview:_name];
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView).offset(8);
        make.top.equalTo(_bgView).offset(8);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(35);
        
    }];
    
    _name.textAlignment=NSTextAlignmentLeft;
    _name.font=[UIFont boldSystemFontOfSize:17];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).offset(25);
        make.top.equalTo(_bgView).offset(15);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(20);
    }];
    
}

-(void)setModel:(CarModel *)model{
    _model=model;
    [_icon setImageWithURL:[NSURL URLWithString:model.brandIcon]];
    _name.text = model.brandName;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
