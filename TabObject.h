//
//  TabObject.h
//  MyItem
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubViewController.h"
#import "NewCarViewController.h"
@interface TabObject : NSObject
@property (nonatomic,copy)NSString * title;
@property (nonatomic,strong)SubViewController * viewController;
@property (nonatomic,strong)NewCarViewController *carViewController;
@end
