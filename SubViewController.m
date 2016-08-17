//
//  SubViewController.m
//  MyItem
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import "SubViewController.h"
#import "Const.h"
#import "QFRequestManager.h"
#import "SubModel.h"
#import "TitleModel.h"
#import "UIImageView+AFNetworking.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
#import "TableViewCell.h"
@interface SubViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UIScrollView * _scrollerView;
    
    UITableView * _tableView;
    
    NSMutableArray * _ADdataArray;
    
    NSMutableArray * _dataArray;
    
    NSInteger _currentIndex;
    //定时器
    NSTimer *timer;
    
    
    
    BOOL _needRefresh;
    MJRefreshGifHeader *gifHeader;
}
@end

@implementation SubViewController
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!_needRefresh) {
        [_tableView.header beginRefreshing];
        _needRefresh = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //切换到此视图的时候，此视图有currentClassId属性，每个不同的SubViewController都有一个ID
    //根据不同的currentClassId请求不同的数据显示出来
    _dataArray = [[NSMutableArray alloc]init];
    _ADdataArray = [[NSMutableArray alloc]init];
    _currentPage = 0;
    
    [self creatUI];
    //[self loadData];
}
-(void)creatUI
{
    _scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _WIDTH, 200)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _WIDTH, _HEIGHT-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    //添加下拉刷新的头部
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _currentPage = 0;
        [self loadData];
    }];
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _currentPage++;
        [self loadData];
    }];
    _tableView.tableHeaderView = _scrollerView;
    
    //自动滚动
    _currentIndex=0;

    [self addTimer];
    

}
/**
 *  添加定时器
 */
-(void)addTimer
{
    if (_currentClassId==0)
    {
       timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(prepareeData) userInfo:nil repeats:YES];
        //解决拖动其他UIScrollView时 定时器不再滚动
        //下面这句话的作用是,当在滑动别的scrollerView或者pageViewController的时候不会阻挡这个定时器的继续运行
        //这个时候如果我们在界面上滚动一个scrollview，那么我们会发现在停止滚动前，控制台不会有任何输出，就好像scrollView在滚动的时候将timer暂停了一样，在查看相应文档后发现，这其实就是runloop的mode在做怪。
        //runloop可以理解为cocoa下的一种消息循环机制，用来处理各种消息事件，我们在开发的时候并不需要手动去创建一个runloop，因为框架为我们创建了一个默认的runloop,通过[NSRunloop currentRunloop]我们可以得到一个当前线程下面对应的runloop对象，不过我们需要注意的是不同的runloop之间消息的通知方式。
        
        //接着上面的话题，在开启一个NSTimer实质上是在当前的runloop中注册了一个新的事件源，而当scrollView滚动的时候，当前的MainRunLoop是处于UITrackingRunLoopMode的模式下，在这个模式下，是不会处理NSDefaultRunLoopMode的消息(因为RunLoop Mode不一样)，要想在scrollView滚动的同时也接受其它runloop的消息，我们需要改变两者之间的runloopmode.
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}
/**
 *  移除定时器
 */
-(void)removeTimer
{
    [timer invalidate];
    //因为定时器停止后则变为无效定时器 所以需要从内存中移除
    timer = nil;
}
-(void)prepareeData
{
    if (_currentIndex<7)
    {
        _currentIndex++;
        [_scrollerView setContentOffset:CGPointMake(_currentIndex*_WIDTH, 0) animated:YES];
        
    }
    else if (_currentIndex==7)
    {
        _currentIndex=1;
        [_scrollerView setContentOffset:CGPointMake(1*_WIDTH, 0) animated:NO];
        _currentIndex++;
        [_scrollerView setContentOffset:CGPointMake(_currentIndex*_WIDTH, 0) animated:YES];

    }

}

-(void)loadData
{
    //请求数据 建立父类的请求数据的方法
    //_scrollerView数据
    //parameterDic请求数据要传送的setHTTPBody
    NSDictionary * parameterDic = [[NSDictionary alloc]initWithObjectsAndKeys:@(_currentClassId),@"classId", nil];
    
    [[QFRequestManager sharedManager]requestPOSTData:kUrlTitle parameter:parameterDic finish:^(NSData *data)
    {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary * dict = dic[@"data"];
        NSArray * array = dict[@"focusList"];
        _ADdataArray = [TitleModel arrayOfModelsFromDictionaries:array];
        [self createAD];
    
        
    } failed:^(NSData *data)
     {
         NSLog(@"error");
    }];
    
    
    //tableView数据
    NSDictionary * parameterDic2 = [NSDictionary dictionaryWithObjectsAndKeys:@(_currentClassId),@"classId",@(_currentPage),@"page",nil];
    
    //classId=%d(表示第几个页面)   page=%d(表示表视图的第几页)
    //请求数据用到的封装的方法
    [[QFRequestManager sharedManager] requestPOSTData:kUrlNew parameter:parameterDic2 finish:^(NSData *data)
     {
         NSDictionary *dic =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         NSDictionary * dict = dic[@"data"];
         NSArray * array = dict[@"newsList"];
         
         //三方库 JSONModel 里的方法
         NSArray * arr = [SubModel arrayOfModelsFromDictionaries:array];
         
         if (_currentPage == 0)
         {
             _dataArray = [SubModel arrayOfModelsFromDictionaries:array];
         }
         else
         {
             [_dataArray addObjectsFromArray:arr];
         }
         
         
         NSString *cachePath = @"/Users/qianfeng/Library/Caches/MyCache"; //  /Library/Caches/MyCache
         [data writeToFile:cachePath atomically:YES];
         
         
         
         [_tableView reloadData];
         [_tableView.footer endRefreshing];
         [_tableView.header endRefreshing];
         
     }   failed:^(NSData *data) {
         NSLog(@"error");
     }];

    
}
-(void)createAD
{
    _scrollerView.contentSize=CGSizeMake((_ADdataArray.count+2)*_WIDTH, 200);//前后再加两张图片 _ADdataArray.count+2
    _scrollerView.pagingEnabled=YES;
    _scrollerView.delegate=self;
    for (int i=0; i<_ADdataArray.count; i++)
    {
        
        TitleModel *model=_ADdataArray[i];
        
        if (i==0) {
            NSUInteger a=_ADdataArray.count-1;
            model=_ADdataArray[a];
            
            
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _WIDTH, 200)];
            imageView.tag=200+a;
            imageView.userInteractionEnabled=YES;
            //添加轻按手势（点击跳到 detail 详情界面）
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handTap:)];
            [imageView addGestureRecognizer:tap];
            [imageView setImageWithURL:[NSURL URLWithString:model.picUrl]];
            
            //标题Lable
            UILabel * titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 180, _WIDTH-30, 20)];
            titlelabel.font = [UIFont systemFontOfSize:13];
            titlelabel.backgroundColor = [UIColor blackColor];
            titlelabel.alpha = 0.7;
            titlelabel.text = model.title;
            titlelabel.textColor = [UIColor whiteColor];
            //页码
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(_WIDTH-30, 180, 30, 20)];
            label.text = [NSString stringWithFormat:@"%lu/%lu",a+1,_ADdataArray.count];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:16];
            label.backgroundColor = [UIColor blackColor];
            label.alpha = 0.7;
            
            
            [_scrollerView addSubview:imageView];
            [_scrollerView addSubview:titlelabel];
            [_scrollerView addSubview:label];
            
            
            model=_ADdataArray[i];
        }
        
         if (i==_ADdataArray.count-1) {
             NSUInteger a=0;
             model=_ADdataArray[a];
             //图片
             UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((i+2)*_WIDTH, 0, _WIDTH, 200)];
             imageView.tag=200;
             imageView.userInteractionEnabled=YES;
             //添加轻按手势（点击跳到 detail 详情界面）
             UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handTap:)];
             [imageView addGestureRecognizer:tap];
             [imageView setImageWithURL:[NSURL URLWithString:model.picUrl]];
             
             //标题Lable
             UILabel * titlelabel = [[UILabel alloc]initWithFrame:CGRectMake((i+2)*_WIDTH, 180, _WIDTH-30, 20)];
             titlelabel.font = [UIFont systemFontOfSize:13];
             titlelabel.backgroundColor = [UIColor blackColor];
             titlelabel.alpha = 0.7;
             titlelabel.text = model.title;
             titlelabel.textColor = [UIColor whiteColor];
             //页码
             UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(_WIDTH-30+(i+2)*_WIDTH, 180, 30, 20)];
             label.text = [NSString stringWithFormat:@"%d/%lu",1,_ADdataArray.count];
             label.textColor = [UIColor whiteColor];
             label.font = [UIFont systemFontOfSize:16];
             label.backgroundColor = [UIColor blackColor];
             label.alpha = 0.7;
             
             
             [_scrollerView addSubview:imageView];
             [_scrollerView addSubview:titlelabel];
             [_scrollerView addSubview:label];

             model=_ADdataArray[i];

         }
        
        
        //图片
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((i+1)*_WIDTH, 0, _WIDTH, 200)];
        imageView.tag=200+i;
        imageView.userInteractionEnabled=YES;
        //添加轻按手势（点击跳到 detail 详情界面）
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handTap:)];
        [imageView addGestureRecognizer:tap];
        [imageView setImageWithURL:[NSURL URLWithString:model.picUrl]];
        
        //标题Lable
        UILabel * titlelabel = [[UILabel alloc]initWithFrame:CGRectMake((i+1)*_WIDTH, 180, _WIDTH-30, 20)];
        titlelabel.font = [UIFont systemFontOfSize:13];
        titlelabel.backgroundColor = [UIColor blackColor];
        titlelabel.alpha = 0.7;
        titlelabel.text = model.title;
        titlelabel.textColor = [UIColor whiteColor];
        //页码
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(_WIDTH-30+(i+1)*_WIDTH, 180, 30, 20)];
        label.text = [NSString stringWithFormat:@"%d/%lu",i+1,_ADdataArray.count];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:16];
        label.backgroundColor = [UIColor blackColor];
        label.alpha = 0.7;
        
        
        [_scrollerView addSubview:imageView];
        [_scrollerView addSubview:titlelabel];
        [_scrollerView addSubview:label];
        
    }
}
-(void)handTap:(UITapGestureRecognizer *)sender
{
    NSArray * array1 = @[@"头条",@"新车",@"行业",@"导购",@"用车"];
    NSInteger index =sender.view.tag-200;
    
    TitleModel * model = _ADdataArray[index];
    
    DetailViewController * detail = [[DetailViewController alloc]init];
    detail.urlString =[NSString stringWithFormat:kUrldetail,model.resourceLoc] ;
    detail.titles = array1[_currentClassId];
    
    [self.delegate turnToNextPage:detail];
}
#pragma mark - TableView  ---
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"dis";
    TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=_dataArray[indexPath.row];
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array1 = @[@"头条",@"新车",@"行业",@"导购",@"用车"];
    SubModel * model = _dataArray[indexPath.row];
    
    DetailViewController * detail = [[DetailViewController alloc]init];
    
    detail.urlString =[NSString stringWithFormat:kUrldetail,model.resourceLoc] ;
    
//    detail.titles = array1[_currentClassId];
    detail.navigationItem.title=array1[_currentClassId];
    
    //self.delegate 是指 NewsViewController IndexViewController遵从了SubViewController的协议
    [self.delegate turnToNextPage:detail];

}




//scrollView设置pagingEnabled为YES，此协议方法一定会被调用
//只有滑动的时候方法才会被调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //重置_currentIndex的值
    _currentIndex=_scrollerView.contentOffset.x/_WIDTH;
    //向右滑动(滑到最后一张),自动变为第一张_currentIndex 变为 1
    if (_currentIndex==7)
    {
        [scrollView setContentOffset:CGPointMake(_WIDTH, 0) animated:NO];
        //这个地方没写_currentIndex=1;是因为上面的定时器循环的执行方法写了这句话
        _currentIndex=1;
    }
    //向左滑动(滑到第一张)
    if (_currentIndex==0)
    {
        [scrollView setContentOffset:CGPointMake(6*_WIDTH, 0) animated:NO];
        _currentIndex=6;
    }
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 停止定时器 一旦停止就不能再用了
    [self removeTimer];
}

/**
 *  停止拖拽的时候调用
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    // 添加定时器
    [self addTimer];
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
