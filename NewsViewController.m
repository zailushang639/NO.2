//
//  NewsViewController.m
//  MyItem
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import "NewsViewController.h"
#import "Const.h"
#import "SubViewController.h"
#import "TabObject.h"

@interface NewsViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate,SubViewDelegate>
{
    UIPageViewController * _pageViewController;
    NSMutableArray * _dataArray;
    NSInteger  _currentPage;
    UIScrollView * _scrollerView;
    UIView * _coverView;
    
}
@end

@implementation NewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationController.navigationBar.frame=CGRectMake(0, 0, _WIDTH, 54);
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(150, 4, 50, 30)];
    label.text = @"资讯";
    label.font = [UIFont boldSystemFontOfSize:17];
    label.textColor=[UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
//    self.navigationItem.title=@"资讯";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self prepareData];
    [self configPageViewController];
    [self configSrollerView];
    
}
-(void)prepareData
{
    NSArray * array1 = @[@"头条",@"新车",@"行业",@"导购",@"用车"];
    
    _dataArray = [[NSMutableArray alloc]init];
    //创建了4个 tab
    for (int i=0; i<array1.count; i++)
    {
        TabObject * tab = [[TabObject alloc]init];
        tab.title = array1[i];
        tab.viewController = [[SubViewController alloc]init];
        
        tab.viewController.currentClassId = i;
        
        [_dataArray addObject:tab];
    }

    
    
}
//创建滚动视图(在上面的 scrollerView 上面添加 button)
-(void)configSrollerView
{
    
    _scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _WIDTH, 30)];
    _scrollerView.backgroundColor = [UIColor lightGrayColor];
    _scrollerView.alpha = 0.7;
    [self.view addSubview:_scrollerView];
    //5个80长度的 button
    _scrollerView.contentSize = CGSizeMake(80*_dataArray.count+10, 30);
    
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _coverView = [[UIView alloc]init];
    _coverView.backgroundColor = [UIColor whiteColor];
    [_scrollerView addSubview:_coverView];
    
    //在 scrollerView 的上面添加 button
    for (int i =0; i<_dataArray.count; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        btn.frame = CGRectMake(10+(_WIDTH-20)/5.0*i, 0, (_WIDTH-20)/5.0-10, 30);
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        btn.tintColor = [UIColor redColor];
        [btn setTitle:[_dataArray[i]title] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(changeTab:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        
        [_scrollerView addSubview:btn];
        
        //初始化第一个按钮为选中
        if (i ==0)
        {
            _coverView.frame = btn.frame;
        }
    }
}
//单击 按钮 切换视图
-(void)changeTab:(UIButton *)sender
{
    
    NSInteger index = sender.tag-100;
    
    
    // [_dataArray[index] viewController]要切换的到的视图 切换视图涉及代理的传值
    //[_dataArray[index] == tab
    SubViewController * sub = [_dataArray[index] viewController];
    sub.delegate =self;
    
    [_pageViewController setViewControllers:@[sub] direction:_currentPage>index animated:YES completion:^(BOOL finished)
     {
         _currentPage = index;
     }];
    
    
}

-(void)configPageViewController
{
    //设置水平方向滚动的_pageViewController
    _pageViewController=[[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    //实例化一个sub给_pageViewController当第一个显示的图片
    SubViewController * sub = [_dataArray[_currentPage]viewController];
    sub.delegate = self;
    sub.view.backgroundColor = [UIColor cyanColor];
    
    //这是一个大的pageViewController 大小是整个界面 每次显示选中那个sub setViewControllers:@[sub]
    [_pageViewController setViewControllers:@[sub] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    _pageViewController.view.frame = CGRectMake(0, 64, _WIDTH, _HEIGHT-64);
    
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    
    [self.view addSubview:_pageViewController.view];
    
    //获取里面的显示的滚动视图subviews[0]
    UIScrollView * sv = _pageViewController.view.subviews[0];
    sv.delegate =self;

    
    
    
    
}
#pragma mark - UIPageViewController协议方法

//往右滑下一张调用的方法（方法返回要显示的下一张viewController）
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    //这里的 viewController 代表上一个界面的 viewController
    SubViewController * sub = (SubViewController *)viewController;
    NSInteger index = sub.currentClassId;
    index++;
    
    //如果跳到了最后一张,继续回到第一张
    if (index>=_dataArray.count)
    {
        index = 0;
        
    }
    SubViewController * svc = [_dataArray[index]viewController];
    
    return svc;
    
}

//往左滑上一张调用的方法
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    SubViewController * sub = (SubViewController *)viewController;
    NSInteger index = sub.currentClassId;
    index--;
    if (index<0)
    {
        index = _dataArray.count-1;
        
    }
    
    //[_dataArray[index]viewController];切换的时候把currentClassId也传过去了currentClassId代表哪个界面
    SubViewController * svc = [_dataArray[index]viewController];
    
    return svc;
    
}
//翻页完成后执行的协议方法（不管是滑动 pageController 切换还是点击按钮切换都要及时把 _currentPage 更新过来）
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    
    SubViewController * sub = (SubViewController *)pageViewController.viewControllers[0];
    sub.delegate = self;
    _currentPage =sub.currentClassId;
    
}

#pragma mark - UIScrolerView协议方法
//滑动视图时调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIButton * btn = (UIButton *)[_scrollerView viewWithTag:100+_currentPage];
    
    //在pageViewController上添加一个scrollView是为了滑动的时候那个和选中的button.frame相同的白色也跳过去
    [UIView animateWithDuration:0.1 animations:^
     {
         _coverView.frame = btn.frame;
     }];
    
}

#pragma mark - SubViewController协议方法

-(void)turnToNextPage:(DetailViewController *)detail
{
    
    [self.tabBarController setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:detail animated:YES];
}


- (void)didReceiveMemoryWarning
{
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
