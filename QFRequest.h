//
//  QFRequestPost.h
//  项目一
//
//  Created by qianfeng on 15/10/12.
//  Copyright (c) 2015年 HFK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFRequest : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic,strong) NSMutableData *receiveData;

-(void)startRequestWithGET:(NSString *)urlString;

-(void)startRequestWithPOST:(NSString *)url parameter:(NSDictionary *)parameter;

@property (nonatomic,copy)void(^finishBlock)(NSData *);

@property (nonatomic,copy)void(^failBlock)(NSData *);
@end
