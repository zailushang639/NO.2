//
//  HotViewController.m
//  MyItem
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import "HotViewController.h"
#import "Const.h"
#import "JXCell.h"
#import "QFRequestManager.h"
#import "JXModel.h"
#import "DetailViewController.h"
#import "MJRefresh.h"
@interface HotViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataArray;
}
@end

@implementation HotViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor=[UIColor lightGrayColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(150, 4, 60, 30)];
    label.text = @"热议";
    label.font = [UIFont boldSystemFontOfSize:17];
    label.textColor=[UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;

    [self createUI];
    [self loadData];
    
}
-(void)createUI
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _WIDTH, _HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    
    
    _tableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _currentPage=0;
        [self loadData];
    }];
    _tableView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _currentPage++;
        [self loadData];
        
    }];
}
-(void)loadData
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@(_currentPage),@"page", nil];
    [[QFRequestManager sharedManager]requestPOSTData:kUrlJX parameter:dic finish:^(NSData *data) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * arr = dic[@"data"];
        NSArray * arr1 = [JXModel arrayOfModelsFromDictionaries:arr];
        
        if (_currentPage == 0) {
            _dataArray = [JXModel arrayOfModelsFromDictionaries:arr];
        }
        else{
            [_dataArray addObjectsFromArray:arr1];
        }
        
        
        [_tableView reloadData];
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        
    } failed:^(NSData *data) {
        NSLog(@"error");
    }];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString * identifier = @"dis";

  JXCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];

  if (cell == nil)
  {
      cell=[[JXCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
      
  }
    cell.model=_dataArray[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailViewController * detail = [[DetailViewController alloc]init];
    
    JXModel * model = _dataArray[indexPath.row];
    
    //detail.urlString =[NSString stringWithFormat:kUrldetail,model.resourceLoc] ;
    
    detail.urlString =model.resourceLoc;
    
    [self.navigationController pushViewController:detail animated:YES];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 280;
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
