//
//  Const.h
//  LimitFree
//
//  Created by gaokunpeng on 15/1/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#ifndef LimitFree_Const_h
#define LimitFree_Const_h

//缓存路径
#define _kCachePaths @[@"com.hackemist.SDWebImageCache.default", @"SDDataCache"]

///Users/qianfeng/Library/Caches/MyCache

//定义一些项目中的常量或者宏

#define KWS(ws) __weak typeof(&*self) ws=self
//资讯
//标题大图
//classId=%d(表示第几个页面)
#define kUrlTitle @"http://api.qctt.cn/qctt-api/4.9/index.php/Adverqctt/getFocus"

//表视图
//classId=%d(表示第几个页面)   page=%d(表示表视图的第几页)
#define kUrlNew @"http://api.qctt.cn/qctt-api/4.9/index.php/News/getNewsList"
//详情(webView)
#define kUrldetail @"http://m.qctt.cn/html/mobile/news/showapi5-%@.html"


//精选
//page=%d
#define kUrlJX @"http://api.qctt.cn/qctt-api/4.9/index.php/Cars/getNewCarList"

//选车(GET请求)
#define kUrlChoose @"http://mi.xcar.com.cn/interface/gcpapp/brands.php"

//选择详情分类(POST请求)
//brandId=%d(选择车的品牌)
#define kUrlChooseDetail @"http://mi.xcar.com.cn/interface/gcpapp/series.php"


//新品上市(GET)
#define kUrlNewCar @"http://mi.xcar.com.cn/interface/gcpapp/newCarList.php"
//热门车(GET)
#define kUrlHotCar @"http://mi.xcar.com.cn/interface/gcpapp/hotSeries.php"
//排行榜(GET)
//type(子页面 1代表第一个)
//offset(数据条数)(刷新用 10代表第一页,20.....)
//limit(每页显示的条数)
#define kUrlCharts @"http://mi.xcar.com.cn/interface/gcpapp/followCarList.php?type=%lu&offset=%lu&limit=10"

//优惠排行榜(GET)
//
#define kUrlPrefer @"http://mi.xcar.com.cn/interface/gcpapp/getCutPriceRakingList.php?cityId=507&provinceId=2&seriesId=%lu&brandId=%lu&sortType=%lu&carId=%lu"


//新品上市 选择详情(GET)
//
#define kUrlChooseCarDetail @"http://mi.xcar.com.cn/interface/gcpapp/seriesInfo.php?seriesId=%@&uid=0&provinceId=2&cityId=507"


#define _WIDTH [UIScreen mainScreen].bounds.size.width
#define _HEIGHT [UIScreen mainScreen].bounds.size.height
#endif
