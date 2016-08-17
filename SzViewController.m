//
//  SzViewController.m
//  MyItem
//
//  Created by qianfeng on 16/3/29.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import "SzViewController.h"
#import "Const.h"
#import "UIImageView+AFNetworking.h"
#import "JLControl.h"
@interface SzViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView * _tableView;
    UILabel *_hcLable;
}
@end

@implementation SzViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    [self ConfigUI];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(150, 4, 75, 36)];
    label.text = @"设置";
    label.font = [UIFont boldSystemFontOfSize:17];
    label.textColor=[UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView=label;
}

-(void)ConfigUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, _WIDTH, _HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
//        NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
//        NSString *cachPath=[path objectAtIndex:0];
    
    //设置定时器实时调用计算缓存的方法
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(updateHuancun) userInfo:nil repeats:YES];
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    //去除section外的分割线
//    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    NSArray * array = @[@"隐私与安全",@"检查更新",@"清除缓存",@"收藏车型",@"清理收藏"];
    static NSString * IDE = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:IDE];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDE];
    }
    cell.textLabel.text = array[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.tag=indexPath.row;
    if (cell.tag==2)
    {
        
        _hcLable=[UILabel new];
        _hcLable.font=[UIFont systemFontOfSize:13];
        _hcLable.frame=CGRectMake(260, 25, 100, 20);
       [cell.contentView addSubview:_hcLable];
    }
   
   
    return cell;
}
-(void)updateHuancun
{
    NSString * cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    float size=[self folderSizeWithPath:cachePath];
    NSString * str = [NSString stringWithFormat:@"%.2fM缓存",size];
    _hcLable.text=str;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _WIDTH/6;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            
            
        }break;
        case 1:
        {
            //点击检查更新
            
        }break;
        case 2:
        {
            //清理缓存
            [self deleteHuanCun];
            
        }break;
        case 3:
        {
            
        }break;
        case 4:
        {
           
            
        }break;
            
        default:
            break;
    }
}


-(void)deleteHuanCun
{
    NSString * cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    float size=[self folderSizeWithPath:cachePath];
    NSString * str = [NSString stringWithFormat:@"是否确定清除%.2fM缓存",size];
    
    UIAlertController *ac=[UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleActionSheet];
    [ac addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [ac addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
    {
       [self deleteCaches:cachePath];
        
       
    }]];
    
     [self presentViewController:ac animated:YES completion:nil];
}







//计算文件夹的大小
-(float)folderSizeWithPath:(NSString *)folderPath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    NSEnumerator * childFilesEnumerator = [[manager subpathsAtPath:folderPath]objectEnumerator];
    NSString * fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject])!=nil) {
        NSString * fileAbsoulutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsoulutePath];
    }
    return folderSize/(1024.0*1024.0);
}
//计算文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
-(void)deleteCaches:(NSString *)delePath
{
     NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:delePath error:nil];
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
