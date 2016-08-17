//
//  JXCell.m
//  MyItem
//
//  Created by qianfeng on 16/3/23.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import "JXCell.h"
#import "Const.h"
#import "UIImageView+AFNetworking.h"
#import "Masonry.h"

@implementation JXCell
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

    
    _picUrl=[UIImageView new];
    [_bgView addSubview:_picUrl];
    
    _titleLabel=[UILabel new];
    [_bgView addSubview:_titleLabel];
    
    _excerptLabel=[UILabel new];
    [_bgView addSubview:_excerptLabel];
    
    _publishTime=[UILabel new];
    [_bgView addSubview:_publishTime];
    
    _model=[JXModel new];
    
    [_picUrl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgView).offset(8);
        make.left.equalTo(_bgView).offset(8);
        make.right.equalTo(_bgView).offset(-15);
        //make.width.mas_equalTo(359);
        make.height.mas_equalTo(174);
        
    }];
    
    _titleLabel.font=[UIFont boldSystemFontOfSize:16];
    _titleLabel.textAlignment=NSTextAlignmentLeft;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_picUrl.mas_bottom).offset(1);
        make.left.equalTo(_bgView).offset(8);
         make.right.equalTo(_bgView).offset(-15);
        make.height.mas_equalTo(28);
        
    }];
    
    _excerptLabel.font=[UIFont systemFontOfSize:13];
    _excerptLabel.textAlignment=NSTextAlignmentLeft;
    //自动换行
    _excerptLabel.lineBreakMode=NSLineBreakByCharWrapping;
    //有多少行显示多少行
    _excerptLabel.numberOfLines=0;
    [_excerptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(1);
        make.left.equalTo(_bgView).offset(8);
        make.right.equalTo(_bgView).offset(-15);
        make.height.mas_equalTo(40);
    }];
    
    _publishTime.font=[UIFont systemFontOfSize:12];
    _publishTime.textAlignment=NSTextAlignmentLeft;
    
    [_publishTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView).offset(8);
        make.top.equalTo(_excerptLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(14);
        
    }];
    
}
-(void)setFrame:(CGRect)frame
{
    
    frame.size.width = _WIDTH;
    [super setFrame:frame];
    
    
    
    
}


-(void)setModel:(JXModel *)model{
    
    _model = model;
    [_picUrl setImageWithURL:[NSURL URLWithString:model.picUrl]];
    
    _titleLabel.text = model.title;
    
    _excerptLabel.text = model.excerpt;
    
    _publishTime.text = model.publishTime;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
