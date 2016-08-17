//
//  QFRefresh.h
//  项目一
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 HFK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFRefresh : NSObject

-(void)startRefresh:(NSString *)url isHeardRef:(BOOL)isHead;

@property (nonatomic,copy)void(^finishBlock)(NSData*);

@property (nonatomic,strong)NSData *receiveData;
@end
