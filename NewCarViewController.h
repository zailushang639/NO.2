//
//  NewCarViewController.h
//  MyItem
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
@class NewCarViewController;
@protocol carViewDelegate <NSObject>

-(void)returnToNextPage:(DetailViewController *)detail;

@end
@interface NewCarViewController : UIViewController
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,weak)id<carViewDelegate>delegate;
@end
