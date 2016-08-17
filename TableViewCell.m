//
//  TableViewCell.m
//  MyItem
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import "TableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "Const.h"
#import "Masonry.h"
@implementation TableViewCell
{
    UIView *_bgView;
    UIView *_lastView;
    
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
    
    _titleLabel=[UILabel new];
    [_bgView addSubview:_titleLabel];
    
    _originLabel=[UILabel new];
    [_bgView addSubview:_originLabel];
    
    _pubLishTimelabel=[UILabel new];
    [_bgView addSubview:_pubLishTimelabel];
    
    _communtCountLabel=[UILabel new];
    [_bgView addSubview:_communtCountLabel];
    
    
    [_picImage mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.equalTo(_bgView).offset(3);
        make.left.equalTo(_bgView).offset(8);
        make.height.mas_equalTo(67);
        make.width.mas_equalTo(96);
        make.bottom.equalTo(_bgView).offset(-3);
        
    }];
    
    
    _originLabel.font=[UIFont systemFontOfSize:13];
    _originLabel.textColor=[UIColor blackColor];
    _originLabel.textAlignment=NSTextAlignmentLeft;
    [_originLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.equalTo(_bgView).offset(50);
        make.left.equalTo(_picImage.mas_right).offset(5);
        make.width.mas_equalTo(69);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(_bgView).offset(-3);
    }];
    
    
    _pubLishTimelabel.font=[UIFont systemFontOfSize:13];
    _pubLishTimelabel.textAlignment=NSTextAlignmentLeft;
    _pubLishTimelabel.textColor=[UIColor blackColor];
    [_pubLishTimelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.equalTo(_bgView).offset(50);
        make.left.equalTo(_originLabel.mas_right).offset(5);
        make.width.mas_equalTo(69);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(_bgView).offset(-3);
    }];
    
    
    
    _communtCountLabel.font=[UIFont systemFontOfSize:13];
    _communtCountLabel.textColor=[UIColor blackColor];
    _communtCountLabel.textAlignment=NSTextAlignmentLeft;
    [_communtCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.equalTo(_bgView).offset(50);
        make.left.equalTo(_pubLishTimelabel.mas_right).offset(5);
        make.right.equalTo(_bgView).offset(-10);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(_bgView).offset(-3);
        
        
    }];
    
    
    _titleLabel.font=[UIFont boldSystemFontOfSize:16];
    _titleLabel.textAlignment=NSTextAlignmentLeft;
    _titleLabel.textColor=[UIColor blackColor];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgView).offset(7);
        make.left.equalTo(_picImage.mas_right).offset(5);
        make.right.equalTo(_bgView).offset(-10);
        make.height.mas_equalTo(21);
        
        
    }];
    
    
    
}



-(void)setFrame:(CGRect)frame
{
    
    frame.size.width = _WIDTH;
    
    [super setFrame:frame];
    
}
-(void)setModel:(SubModel *)model{
    _model = model;
    [_picImage setImageWithURL:[NSURL URLWithString:model.picUrlList[0]]];
    
    _titleLabel.text = model.title;
    _originLabel.text = model.origin;
    _communtCountLabel.text =[NSString stringWithFormat:@"评论(%@)",model.CommuntCount];
    _pubLishTimelabel.text = model.publishTime;
    
    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
