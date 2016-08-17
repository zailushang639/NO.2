//
//  SubViewController.h
//  MyItem
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
@class SubViewController;

@protocol SubViewDelegate <NSObject>

-(void)turnToNextPage:(DetailViewController *)detail;

@end

@interface SubViewController : UIViewController
@property (nonatomic,assign)NSInteger currentClassId;
@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,weak)id<SubViewDelegate>delegate;
@end
