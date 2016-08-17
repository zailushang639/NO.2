//
//  ChooseViewController.m
//  MyItem
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import "ChooseViewController.h"
#import "Const.h"
#import "QFRequestManager.h"
#import "CarModel.h"
#import "CarClassCell.h"
#import "UIImageView+AFNetworking.h"
#import "TabButton.h"
#import "NewCarViewController.h"
#import "TopicViewController.h"
#import "ChartsViewController.h"
#import "HotCarViewController.h"
#import "ChooseDeatilViewController.h"
@interface ChooseViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    UITableView *_tableView;
    NSMutableArray* _dataArray;
    NSMutableArray * _resultArray;
    UISearchBar * _searchBar;
}
@end

@implementation ChooseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(150, 4, 75, 36)];
    label.text = @"找车";
    label.font = [UIFont boldSystemFontOfSize:17];
    label.textColor=[UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView=label;
    [self createUI];
    [self prepareData];
    
}
-(void)createUI
{
    _dataArray=[[NSMutableArray alloc]init];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, _WIDTH, _HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    
    //添加按钮
    NSArray * arrayTitle = @[@"新车上市",@"热门车",@"关注前十榜",@"优惠排行榜"];
    NSArray * arrPic = @[@"iconfont-iconfontnew",@"iconfont-fire",@"iconfont-shujuzhanshi2",@"iconfont-iconfonttehuijingxuan"];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, _WIDTH, 60)];
    imageView.image = [UIImage imageNamed:@"bg10.png"];
    imageView.alpha = 0.8;
    _tableView.tableHeaderView = imageView;
    imageView.userInteractionEnabled = YES;
    for (int i=0; i<4; i++)
    {
        TabButton * btn = [[TabButton alloc]initWithFrame:CGRectMake(10+(_WIDTH-20)/4.0*i, 5, 65, 50)];
        
        [imageView addSubview:btn];
        btn.tag = 150+i;
        [btn setImage:[UIImage imageNamed:arrPic[i]] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [btn setTitle:arrayTitle[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    //搜索栏
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, _WIDTH, 44)];
    [self.view addSubview:_searchBar];
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;
    _searchBar.backgroundColor = [UIColor clearColor];
    

    
}
-(void)btnClick:(UIButton *)sender
{
    if (sender.tag == 150)
    {
        //新车上市
        NewCarViewController * new = [[NewCarViewController alloc]init];
        [new setHidesBottomBarWhenPushed:YES];
        self.navigationItem.title = sender.titleLabel.text;
        [self.navigationController pushViewController:new animated:YES];
    }
    else if (sender.tag == 151)
    {
        //热门车
        HotCarViewController * hot =[[HotCarViewController alloc]init];
        [hot setHidesBottomBarWhenPushed:YES];
        self.navigationItem.title = sender.titleLabel.text;
        [self.navigationController pushViewController:hot animated:YES];
    }
    else if (sender.tag == 152)
    {
        //关注排行榜
        TopicViewController * topic = [[TopicViewController alloc]init];
        [topic setHidesBottomBarWhenPushed:YES];
        self.navigationItem.title = sender.titleLabel.text;
        [self.navigationController pushViewController:topic animated:YES];
    }
    else if (sender.tag == 153)
    {
        //优惠排行榜
        ChartsViewController * charits = [[ChartsViewController alloc]init];
        [charits setHidesBottomBarWhenPushed:YES];
        self.navigationItem.title = sender.titleLabel.text;
        [self.navigationController pushViewController:charits animated:YES];
    }

}
-(void)prepareData
{
    [[QFRequestManager sharedManager] requestGETData:kUrlChoose finish:^(NSData *data) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray * array1 = dic[@"groups"];
        
        for (NSDictionary * dict in array1) {
            NSArray * array = dict[@"brands"];
            
            NSArray * arraydata1 = [CarModel arrayOfModelsFromDictionaries:array];
            
            [_dataArray addObject:arraydata1];
            
        }
        _resultArray = [[NSMutableArray alloc]initWithArray:_dataArray];
        [_tableView reloadData];
        
    } failed:^(NSData *data) {
        NSLog(@"error");
    }];

}
#pragma mark - UITableView ---

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"dix";
    CarClassCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell=[[CarClassCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (_resultArray.count == _dataArray.count)
    {
        cell.model = _resultArray[indexPath.section][indexPath.row];
    }
    else
    {
        cell.model = _resultArray[indexPath.row];
    }
    return cell;
}

//每组的单元格数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_resultArray.count == _dataArray.count)
    {
        return [_resultArray[section] count];
    }
    else{
        
        return _resultArray.count;
    }
    
    
}

//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_resultArray.count == _dataArray.count)
    {
        
        return _resultArray.count;
    }
    
    else
    {
        
        return 1;
    }
    
}
//单元格 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

//每组标题名字
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section<=3)
    {
        return [NSString stringWithFormat:@"%c",(unichar)(section+65)];
    }
    else if (section>3&&section<=6)
    {
        return [NSString stringWithFormat:@"%c",(unichar)(section+66)];
    }
    else if (section>6&&section<=12)
    {
        return [NSString stringWithFormat:@"%c",(unichar)(section+67)];
    }
    else if (section>12&&section<17)
    {
        return [NSString stringWithFormat:@"%c",(unichar)(section+68)];
    }
    else if (section==17)
    {
        return [NSString stringWithFormat:@"%c",(unichar)(section+69)];
    }
    else
    {
        return [NSString stringWithFormat:@"%c",(unichar)(section+70)];
    }
}


//设置每组的标题高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 25;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarModel *model=_dataArray[indexPath.section][indexPath.row];
    ChooseDeatilViewController *detailVC=[[ChooseDeatilViewController alloc]init];
    detailVC.currentBrandId=model.brandId;
    detailVC.titles=model.brandName;
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

//实现时时搜索（当搜索文本内容变化时调用此协议方法）
//参数searchText是用户输入的搜索内容，也可以用searchBar.text获取
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    [_resultArray removeAllObjects];
    //创建一个谓词对象
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"self contains [c]%@",searchText];
    //在_dataArray中利用predicate筛查，将数组中满足条件的元素取出组成一个新的数组返回
    
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    NSMutableArray * arr2 = [[NSMutableArray alloc]init];
    for (NSArray * arr1 in _dataArray) {
        for (CarModel * model in arr1) {
            [arr addObject:model.brandName];
            
        }
        [arr2 addObjectsFromArray:arr1];
    }
    NSArray * result =[[NSMutableArray alloc]initWithArray:[arr filteredArrayUsingPredicate:predicate]];
    
    for (NSString * str in result) {
        for (CarModel * model in arr2) {
            if (str == model.brandName) {
                [_resultArray addObject:model];
            }
        }
    }
    
    
    //当用户不需要搜索时显示原来的所有数据
    if(searchText.length==0){
        _resultArray=[[NSMutableArray alloc]initWithArray:_dataArray];
    }
    [_tableView reloadData];
}

//当单击Cancel按钮取消搜索时隐藏键盘
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

////返回索引对应的组，title是选中索引的标题，index是索引标题所在的下标
//-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    //如果return -1;不会出现滚动
//    //    NSLog(@"%@",title);
//    return index;
//}





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
