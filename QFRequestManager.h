//
//  QFRequestManager.h
//  项目一
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 HFK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QFRequest.h"
@interface QFRequestManager : NSObject
+(id)sharedManager;

//GET
-(void)requestGETData:(NSString *)url finish:(void(^)(NSData *))finish failed:(void(^)(NSData *))failed;


//POST
-(void)requestPOSTData:(NSString *)url parameter:(NSDictionary *)parameter finish:(void(^)(NSData *))finish failed:(void(^)(NSData *))failed;

@end
