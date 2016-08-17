//
//  NewCarViewController.m
//  MyItem
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import "NewCarViewController.h"
#import "Const.h"
#import "DetailViewController.h"
#import "CarModel.h"
#import "QFRequestManager.h"
#import "ChooseDetailCell.h"
#import "MJRefresh.h"
@interface NewCarViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * _dataArray;
    NSString * _url;
    
}
@end

@implementation NewCarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _currentPage=10;
    if (_type)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,_WIDTH , _HEIGHT-94) style:UITableViewStyleGrouped];
        
        _url = [NSString stringWithFormat:kUrlCharts,(long)_type,(long)_currentPage];
        
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _currentPage = 10;
            
            [self requestData];
        }];
        
        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _currentPage+=10;
            
            [self requestData];
        }];
    }
    else
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,_WIDTH , _HEIGHT) style:UITableViewStyleGrouped];
        _url = kUrlNewCar;
    }
    
    
    
    [self requestData];
    [self createUI];
    
}
-(void)createUI
{
    _dataArray = [[NSMutableArray alloc]init];
    self.automaticallyAdjustsScrollViewInsets = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
-(void)requestData
{
    [[QFRequestManager sharedManager] requestGETData:_url finish:^(NSData *data) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray * array = dic[@"seriesList"];
        
        //     _dataArray = [CarModel arrayOfModelsFromDictionaries:array];
        NSArray * arr1 = [CarModel arrayOfModelsFromDictionaries:array];
        
        if (_currentPage == 0)
        {
            _dataArray = [CarModel arrayOfModelsFromDictionaries:array];
        }
        else{
            [_dataArray addObjectsFromArray:arr1];
        }
        
        
        [_tableView reloadData];
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        
    }failed:^(NSData *data){
        NSLog(@"error");
    }];

}
#pragma mark - UITableView ---

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"dis";
    ChooseDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell=[[ChooseDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        //判断代表哪个页面
        if (_type)
        {
            cell.typeId = 3;
        }
        else
        {
            cell.typeId = 1;
        }

    }
    cell.model=_dataArray[indexPath.row];
    return cell;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController * detail = [[DetailViewController alloc]init];
    CarModel * model = _dataArray[indexPath.row];
    
    
    [[QFRequestManager sharedManager] requestGETData:[NSString stringWithFormat:kUrlChooseCarDetail,model.seriesId] finish:^(NSData *data) {
        
        NSDictionary  *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        detail.urlString = dic[@"webLink"];
        
        [self.navigationController pushViewController:detail animated:YES];
        
        if (self.delegate)
        {
            [self.delegate returnToNextPage:detail];
        }
    } failed:^(NSData *data)
    {
        NSLog(@"error");
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
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
