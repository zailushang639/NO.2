//
//  DetailViewController.m
//  MyItem
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 杨晨晨. All rights reserved.
//

#import "DetailViewController.h"
#import "Const.h"
@interface DetailViewController ()
{
    UIWebView *_webView;
    NSURLRequest *_request;
}
@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.navigationController.navigationBar.frame=CGRectMake(0, 0, _WIDTH, 54);
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 10, 30, 25);
    [btn setBackgroundImage:[UIImage imageNamed:@"iconfont-iconfontfanhui.png"] forState:UIControlStateNormal];
    
//    UILabel *lable=[[UILabel alloc]init];
//    lable.text=@"<-Back";
//    lable.textColor=[UIColor whiteColor];
    
    [btn addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * itemBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
//    //一级标题
//    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
//    label.text = _titles;
//    UIBarButtonItem * itemLabel = [[UIBarButtonItem alloc]initWithCustomView:label];
//    
//    //二级标题
//    UILabel * detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 80, 20)];
//    label.text = _detailTitle;
//    UIBarButtonItem * itemLabel2 = [[UIBarButtonItem alloc]initWithCustomView:detailLabel];
//    NSArray * array = @[itemBtn,itemLabel,itemLabel2];
    
    NSArray * array = @[itemBtn];
    self.navigationItem.leftBarButtonItems = array;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //detail.urlString =[NSString stringWithFormat:kUrldetail,model.resourceLoc] ;
    //上一级传过来的值
    _request  = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:_urlString]];
    //CGRectMake(0, -44, _WIDTH, _HEIGHT+44
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, _WIDTH, _HEIGHT+20)];
    
    //调整界面适应手机的界面
    _webView.scalesPageToFit=YES;
   
    [_webView loadRequest:_request];
    
    [self.view addSubview:_webView];

}
-(void)Back
{
    [self.navigationController popViewControllerAnimated:YES];
    
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
