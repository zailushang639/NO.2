//
//  QFRequestManager.m
//  项目一
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 HFK. All rights reserved.
//

#import "QFRequestManager.h"

@implementation QFRequestManager

+(id)sharedManager
{
    static QFRequestManager * manager = nil;
    
    @synchronized(self)
    {
        manager = [[QFRequestManager alloc]init];
    }
    return manager;
}


//GET请求
-(void)requestGETData:(NSString *)url finish:(void (^)(NSData *))finish failed:(void (^)(NSData *))failed{
    QFRequest * request = [[QFRequest alloc]init];
    request.finishBlock = finish;
    request.failBlock = failed;
    
    [request startRequestWithGET:url];
}

//POST请求（封装了请求方法）
-(void)requestPOSTData:(NSString *)url parameter:(NSDictionary *)parameter finish:(void (^)(NSData *))finish failed:(void (^)(NSData *))failed{
    
    QFRequest * request = [[QFRequest alloc]init];
    request.finishBlock = finish;
    request.failBlock = failed;
    
    
    [request startRequestWithPOST:url parameter:parameter];
    
    
}

@end
