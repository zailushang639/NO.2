//
//  HotCarViewController.m
//  MyItem
//
//  Created by qianfeng on 16/3/24.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import "HotCarViewController.h"
#import "QFRequestManager.h"
#import "Const.h"
#import "CarModel.h"
#import "ChooseDetailCell.h"
#import "DetailViewController.h"
@interface HotCarViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation HotCarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createUI];
    [self requestData];
}
-(void)createUI
{
    _dataArray=[[NSMutableArray alloc]init];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, _WIDTH, _HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
//    _tableView.rowHeight=UITableViewAutomaticDimension;
//    _tableView.estimatedRowHeight=70;
    
    [self.view addSubview:_tableView];



    
}
-(void)requestData
{
    [[QFRequestManager sharedManager] requestGETData:kUrlHotCar finish:^(NSData *data) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray * array = dic[@"subBrands"];
        
        for (NSDictionary * dict in array) {
            
            
            NSArray * array1 = dict[@"series"];
            NSArray * array2 = [CarModel arrayOfModelsFromDictionaries:array1];
            CarModel * model = array2[0];
            [model.messageDic setValuesForKeysWithDictionary:dict];
            [model.messageDic removeObjectForKey:@"series"];
            
            [_dataArray addObject:array2];
        }
        
        
        [_tableView reloadData];
    } failed:^(NSData *data) {
        NSLog(@"error");
    }];

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"dis";
    ChooseDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell=[[ChooseDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.typeId=2;
    }
    cell.model = _dataArray[indexPath.section][indexPath.row];
    return cell;

}


//每组的单元格数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_dataArray[section] count];
    
}
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArray.count;
    
}
//单元格 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}

//每组标题名字
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    CarModel * model = _dataArray[section][0];
    
    return model.messageDic[@"subBrandName"];
    
}

//设置每组的标题高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 25;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController * detail = [[DetailViewController alloc]init];
    CarModel * model = _dataArray[indexPath.section][indexPath.row];
    
    
    [[QFRequestManager sharedManager] requestGETData:[NSString stringWithFormat:kUrlChooseCarDetail,model.seriesId] finish:^(NSData *data) {
        
        NSDictionary  *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        detail.urlString = dic[@"webLink"];
        
        [self.navigationController pushViewController:detail animated:YES];
        
    } failed:^(NSData *data) {
        NSLog(@"error");
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
