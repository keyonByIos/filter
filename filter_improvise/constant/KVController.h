//
//  KVController.h
//  KQCApp
//
//  Created by reginx on 15/7/16.
//  Copyright (c) 2015年 CiNing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "keyon.h"

@interface KVController : UIViewController
// 是否初始化
@property (assign, atomic) BOOL isInited;
// VTag 标识
@property (assign, nonatomic) NSString * VTag;
// 提示消息
+ (void) showMessage:(NSString *)message btn:(UIButton *)btn;
// 标记
- (id) initWithVTag:(NSString *)text;
//获取当前视图
+ (UIViewController *) getCurrentVC;
//跳转方法
+ (void)TransitionFrom :(UIViewController *)startVC
                    To :(UIViewController *)endVC
         WithAnimation :(UIViewAnimationOptions)animation;
//设置流程树
+ (NSString *)GetFlowInVC:(NSString *)VTag ByControl:(NSString *)control;
@end
