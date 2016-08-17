//
//  ChartsViewController.m
//  MyItem
//
//  Created by qianfeng on 16/3/24.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import "ChartsViewController.h"
#import "QFRequestManager.h"
#import "CarModel.h"
#import "PreferCell.h"
#import "DetailViewController.h"
#import "Const.h"
@interface ChartsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    
    NSMutableArray * _dataArray;
}
@end

@implementation ChartsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _dataArray=[[NSMutableArray alloc]init];
    _seriesId = 0;
    _brandId = 0;
    _sortType = 1;
    [self requestData];
    [self createUI];
}
-(void)createUI
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,_WIDTH , _HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];

}
-(void)requestData
{
    NSString * url = [NSString stringWithFormat:kUrlPrefer,(long)_seriesId,(long)_brandId,(long)_sortType,(long)_carId];
    
    [[QFRequestManager sharedManager] requestGETData:url finish:^(NSData *data) {
        
        NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        _dataArray = [CarModel arrayOfModelsFromDictionaries:array];
        
        [_tableView reloadData];
        
        
    } failed:^(NSData *data) {
        NSLog(@"error");
    }];

}
#pragma mark - UITableView ---

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"dis";
    PreferCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[NSBundle mainBundle] loadNibNamed:@"PreferCell" owner:self options:nil][0];
    }
    cell.model=_dataArray[indexPath.row];
    cell.pushBlock=^{
        DetailViewController * detail = [[DetailViewController alloc]init];
        CarModel * model = _dataArray[indexPath.row];
        detail.urlString = model.newsLink;
        [self.navigationController pushViewController:detail animated:YES];
    };
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController * detail = [[DetailViewController alloc]init];
    CarModel * model = _dataArray[indexPath.row];
    detail.urlString = model.webLink;
    [self.navigationController pushViewController:detail animated:YES];
    
    
    
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
