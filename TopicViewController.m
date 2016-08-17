//
//  TopicViewController.m
//  MyItem
//
//  Created by qianfeng on 16/3/24.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import "TopicViewController.h"
#import "Const.h"
#import "NewCarViewController.h"
#import "TabObject.h"
@interface TopicViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate,carViewDelegate>
{
    UIPageViewController * _pageViewController;
    NSMutableArray * _dataArray;
    NSInteger _currentPage;
    UIScrollView * _scrollerView;
    UIView * _coverView;
}

@end

//像第一页的视图
//_pageViewController上显示的是 tab.carViewController = [[NewCarViewController alloc]init];
//显示tab.carViewController 的时候要有 type 值传过去 根据type 的值确定 tab.carViewController 要用哪种 cell
//全部",@"SUV",@"紧凑型车 的cell 都不一样 tab.carViewController.type = i+1;

@implementation TopicViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareData];
    [self configPageViewController];
    [self configSrollerView];
}
-(void)prepareData
{
    NSArray * array1 = @[@"全部",@"SUV",@"紧凑型车"];
    
    _dataArray = [[NSMutableArray alloc]init];
    
    for (int i=0; i<array1.count; i++) {
        TabObject * tab = [[TabObject alloc]init];
        tab.title = array1[i];
        tab.carViewController = [[NewCarViewController alloc]init];
        //tab.carViewController 是  NewCarViewController 的属性
        //根据 type 的值确定用哪种 cell
//        if (_type)
//        {
//            cell.typeId = 3;
//        }

        tab.carViewController.type = i+1;
        
        [_dataArray addObject:tab];
    }
    
    _currentPage = 0;
}
-(void)configSrollerView
{
    _scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _WIDTH, 30)];
    _scrollerView.backgroundColor = [UIColor lightGrayColor];
    _scrollerView.alpha = 0.7;
    [self.view addSubview:_scrollerView];
    
    _coverView = [[UIView alloc]init];
    _coverView.backgroundColor = [UIColor whiteColor];
    [_scrollerView addSubview:_coverView];
    
    for (int i =0; i<_dataArray.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(10+(_WIDTH-20)/3.0*i, 0, (_WIDTH-20)/3.0-10, 30);
        
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        btn.tintColor = [UIColor blackColor];
        [btn setTitle:[_dataArray[i]title] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(changeTab:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        
        [_scrollerView addSubview:btn];
        
        //初始化第一个按钮为选中
        if (i ==0) {
            _coverView.frame = btn.frame;
        }
        
    }
    
}
//单击按钮切换视图
-(void)changeTab:(UIButton *)sender{
    
    NSInteger index = sender.tag-100;
    NewCarViewController * sub = [_dataArray[index]carViewController];
    sub.delegate = self;
    [_pageViewController setViewControllers:@[sub] direction:_currentPage>index animated:YES completion:^(BOOL finished) {
        _currentPage = index;
    }];
    
    
}

-(void)configPageViewController
{
    _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    NewCarViewController * sub = [_dataArray[_currentPage]carViewController
                                  ];
    sub.delegate =self;
    sub.view.backgroundColor = [UIColor cyanColor];
    [_pageViewController setViewControllers:@[sub] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    _pageViewController.view.frame = CGRectMake(0, 94, _WIDTH, _HEIGHT-94);
    
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    
    [self.view addSubview:_pageViewController.view];
    //获取里面的滚动视图
    UIScrollView * sv = _pageViewController.view.subviews[0];
    sv.delegate =self;
}
#pragma mark - UIPageViewController协议方法
//往右滑下一张调用的方法（方法返回要显示的下一张viewController）
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NewCarViewController * sub = (NewCarViewController *)viewController;
    
    NSInteger index = sub.type-1;
    index++;
    if (index>=_dataArray.count) {
        index = 0;
        return nil;
    }
    NewCarViewController * svc = [_dataArray[index]carViewController];
    
    return svc;
    
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NewCarViewController * sub = (NewCarViewController *)viewController;
    NSInteger index = sub.type-1;
    index--;
    if (index<0) {
        index = _dataArray.count-1;
        return nil;
    }
    NewCarViewController * svc = [_dataArray[index]carViewController];
    
    return svc;
    
}

//翻页完成后执行的协议方法
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    
    NewCarViewController * sub = (NewCarViewController *)pageViewController.viewControllers[0];
    sub.delegate =self;
    _currentPage =sub.type-1;
}

-(void)returnToNextPage:(DetailViewController *)detail{
    
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - UIScrolerView协议方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIButton * btn = (UIButton *)[_scrollerView viewWithTag:100+_currentPage];
    
    [UIView animateWithDuration:0.1 animations:^{
        _coverView.frame = btn.frame;
    }];
    
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
