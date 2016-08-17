//
//  JLControl.m
//  BigPrivateSchool
//
//  Created by 沈家林 on 15/9/29.
//  Copyright (c) 2015年 沈家林. All rights reserved.
//

#import "JLControl.h"
//#define IOS7   [[UIDevice currentDevice]systemVersion].floatValue>=7.0

@implementation JLControl

//清除缓存
+ (void)cancelWebCache
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])  {
        [storage deleteCookie:cookie];
    }
}

+ (BOOL)checkPhoneNumber:(NSString *)str
{
    NSString *regex = @"^(1)\\d{10}$";
    NSPredicate *phonenum = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [phonenum evaluateWithObject:str];
}

//保存数据到本地
+ (void)saveLocalData:(id)obj forKey:(NSString *)key
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//移除本地数据
+ (void)removeLocalData:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//读取本地数据
+ (id)getLocalData:(NSString *)key
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (void)makeCall:(UIView *)view phoneNum:(NSString *)str
{
    //判断设备
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",str]];
        UIWebView *callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:url]];
        [view addSubview:callWebview];
    } else {
        //[self showMessage:@"该设备不支持拨打电话功能" Type:1];
    }
}


+ (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0 , 0, newSize.width, newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}



+(NSString *)stringFromDateWithHourAndMinute:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}


+ (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize

{
    
    return [JLControl labelAutoCalculateRectWith:text Font:[UIFont systemFontOfSize:fontSize] MaxSize:maxSize];
    
}

+ (CGSize)labelAutoCalculateRectWith:(NSString*)text Font:(UIFont *)font MaxSize:(CGSize)maxSize

{
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    
    if (!font||!text) {
        return  CGSizeMake(0, 0);
    }
    NSDictionary* attributes =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    labelSize.height=ceil(labelSize.height);
    labelSize.width=ceil(labelSize.width);
    return labelSize;
    
}

+ (BOOL)isNumber:(NSString*)string{
    if (string.length>0) {
        NSScanner* scan = [NSScanner scannerWithString:string];
        int val;
        return[scan scanInt:&val] && [scan isAtEnd];
    }else{
        return NO;
    }
}
+ (BOOL)isNumberAndString:(NSString*)string{
    if (string.length>0) {
        for (NSInteger i=0; i<string.length; i++) {
            NSInteger a=[string characterAtIndex:i];
            if (!((a>='0'&&a<='9')||(a>='a'&&a<='z')||(a>='A'&&a<='Z'))) {
                return NO;
            }
        }
        return YES;
    }else{
        return NO;
    }

}

+ (BOOL)isContainChinese:(NSString*)string{
    if (string.length>0) {
        for (NSInteger i=0; i<string.length; i++) {
            NSInteger a=[string characterAtIndex:i];
            //汉字编码区间
            if (a>0x4e00&&a<0x9fff) {
                return YES;
            }
        }
        return NO;
    }else{
        return NO;
    }
}


@end
