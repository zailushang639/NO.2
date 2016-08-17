//
//  TabBarController.m
//  MyItem
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import "TabBarController.h"
#import "NewsViewController.h"
#import "HotViewController.h"
#import "ChooseViewController.h"
#import "SzViewController.h"
#import "BaseViewController.h"
#import "TabButton.h"
#import "Const.h"
#import "Masonry.h"
@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createViewController];
    [self createTabBarButton];
    
}
-(void)createTabBarButton
{
    //self.navigationController.navigationBar.frame=CGRectMake(0, 0, _WIDTH, 54);
    self.tabBar.backgroundColor = [UIColor lightGrayColor];
    //添加3个按钮
    NSArray * array = @[@"iconfont-3home-2",@"iconfont-9duihuakuang-2",@"iconfont-iconfontqiche",@"iconfont-shezhi-3"];
    NSArray * selectArray = @[@"iconfont-3home",@"iconfont-9duihuakuang",@"iconfont-iconfontqiche-2",@"iconfont-shezhi"];
    NSArray *titles=@[@"资讯",@"热议",@"找车",@"设置"];
    
    //遍历TabBar上得item,将其删除,再添加自定义的item
    for (UIView * view in self.tabBar.subviews)
    {
        [view removeFromSuperview];
    }
    
    //TabButton(自己创建的类有一个自己创建的对象方法setImageWithBtn)
    for(int i=0;i<array.count;i++)
    {
        TabButton *btn=[[TabButton alloc]initWithFrame:CGRectMake(i*_WIDTH/4, 0, _WIDTH/4+1, 49)];
        [btn setImageWithBtn:[UIImage imageNamed:@"button.jpg"]];
        
        [btn setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:selectArray[i]] forState:UIControlStateSelected];
        
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=200+i;
        
        [self.tabBar addSubview:btn];
        
        //默认启动时显示的是第一个界面，所以第一个按钮应该处于选中状态
        if(i==0)
        {
            btn.selected=YES;
        }
    }
    
}

-(void)btnClick:(UIButton *)sender
{
    //实现视图切换
    NSInteger index=sender.tag-200;
    
    //selectedIndex(系统自带)
    self.selectedIndex=index;
    
    
    //改变按钮的状态(当前的为选中状态，其他的为非选中状态）
    
    for(UIView *view in self.tabBar.subviews)
    {
        if([view isKindOfClass:[TabButton class]])
        {
            TabButton *tb=(TabButton*)view;
            if(tb.tag==sender.tag)
            {
                tb.selected=YES;
            }else
            {
                tb.selected=NO;
            }
        }
    }
    
}


-(void)createViewController
{
    NSArray *array=@[@"NewsViewController",@"HotViewController",@"ChooseViewController",@"SzViewController"];
    NSMutableArray *viewControllers=[[NSMutableArray alloc]init];
    for (int i=0; i<array.count; i++)
    {
        Class class=  NSClassFromString(array[i]);
        BaseViewController *root=[[class alloc]init];
        
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:root];
        nav.automaticallyAdjustsScrollViewInsets=NO;
        [viewControllers addObject:nav];
    }
        
    self.viewControllers =viewControllers;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
