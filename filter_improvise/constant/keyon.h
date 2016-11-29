//
//  KQC.h
//  KQCApp
//
//  Created by reginx on 15/7/15.
//  Copyright (c) 2015年 CiNing. All rights reserved.
//



#import "KVController.h"
#ifndef KQCApp_KQC_h

#define KQCApp_KQC_h
//UserDefault
#define UerDafault [NSUserDefaults standardUserDefaults]
// 设计稿高度
#define SWID 1080.0f
// 设备宽度
#define GWID  [[UIScreen mainScreen] bounds].size.width

// 设备长度
#define GHIT [[UIScreen mainScreen] bounds].size.height

// 缩放比率
#define SRAT (GWID == 414.0f ? (1 / 2.46f * 0.96f) : (GWID == 375.0f ? (750.0f / SWID / 2.0f) : (640.0f / SWID  * 0.5)))

// 缩放值
#define SRVAL(w) w * SRAT

// 获取对应位置
#define GPOS(pos) (float)(GWID == 320 ? (pos / 3) : (GWID == 414 ? pos : (pos / 2)))

// 获取 UIColor 对象
#define UIColorFromRGB(rgbValue, alp) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alp]

// 单例header 定义
#define DEFINE_SINGLETON_HEADER(className) \
\
+ (className *)shared##className;

// 单例 impl 实现
#define DEFINE_SINGLETON_IMPLEMENTATION(className) \
\
static className *shared##className = nil; \
static dispatch_once_t pred; \
\
+ (className *)shared##className { \
dispatch_once(&pred, ^{ \
shared##className = [[super allocWithZone:NULL] init]; \
}); \
return shared##className; \
} \
\
+ (id)allocWithZone:(NSZone *)zone { \
return [self shared##className];\
} \
\
- (id)copyWithZone:(NSZone *)zone { \
return self; \
}

#endif
