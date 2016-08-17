//
//  QFRequestPost.m
//  项目一
//
//  Created by qianfeng on 15/10/12.
//  Copyright (c) 2015年 HFK. All rights reserved.
//

#import "QFRequest.h"
#import "MJRefresh.h"
@implementation QFRequest
{
    
    NSURLConnection * _connection;
}



//GET请求
-(void)startRequestWithGET:(NSString *)urlString{
    NSURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
    
    _connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_receiveData appendData:data];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    _receiveData = [[NSMutableData alloc]init];
    [_receiveData setLength:0];
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    _finishBlock(_receiveData);
}

//POST请求
-(void)startRequestWithPOST:(NSString *)url parameter:(NSDictionary *)parameter
{
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    
    
    //解析请求参数，用NSDictionary来存参数，通过自定义的函数parseParams把它解析成一个post格式的字符串
    NSString *parseParamsResult = [self parseParams:parameter];
    
    NSData *postData = [parseParamsResult dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    _connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    
}

//把NSDictionary解析成post格式的NSString字符串
- (NSString *)parseParams:(NSDictionary *)params
{
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString new];
//    //实例化一个key枚举器用来存放dictionary的key
//    NSEnumerator *keyEnum = [params keyEnumerator];
//    id key;
//    while (key = [keyEnum nextObject]) {
//        keyValueFormat = [NSString stringWithFormat:@"%@=%@&",key,[params valueForKey:key]];
//        [result appendString:keyValueFormat];
//        NSLog(@"post()方法参数解析结果：%@",result);
//    }
//    
    NSArray * allkey = [params allKeys];
    NSArray * allValue = [params allValues];
    
    for (int i=0; i<allkey.count; i++)
    {
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&",allkey[i],allValue[i]];
        [result appendString:keyValueFormat];

    }
    
    return result;
}


@end
