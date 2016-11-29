//
//  KVController.m
//  KQCApp
//
//  Created by reginx on 15/7/16.
//  Copyright (c) 2015年 CiNing. All rights reserved.
//

#import "KVController.h"
//    UIViewAnimationOptionLayoutSubviews //提交动画的时候布局子控件，表示子控件将和父控件一同动画。
//    UIViewAnimationOptionAllowUserInteraction //动画时允许用户交流，比如触摸
//    UIViewAnimationOptionBeginFromCurrentState //从当前状态开始动画
//    UIViewAnimationOptionRepeat //动画无限重复
//    UIViewAnimationOptionAutoreverse //执行动画回路,前提是设置动画无限重复
//    UIViewAnimationOptionOverrideInheritedDuration //忽略外层动画嵌套的执行时间
//    UIViewAnimationOptionOverrideInheritedCurve //忽略外层动画嵌套的时间变化曲线
//    UIViewAnimationOptionAllowAnimatedContent //通过改变属性和重绘实现动画效果，如果key没有提交动画将使用快照
//    UIViewAnimationOptionShowHideTransitionViews //用显隐的方式替代添加移除图层的动画效果
//    UIViewAnimationOptionOverrideInheritedOptions //忽略嵌套继承的选项
//    //时间函数曲线相关
//    UIViewAnimationOptionCurveEaseInOut //时间曲线函数，由慢到快
//    UIViewAnimationOptionCurveEaseIn //时间曲线函数，由慢到特别快
//    UIViewAnimationOptionCurveEaseOut //时间曲线函数，由快到慢
//    UIViewAnimationOptionCurveLinear //时间曲线函数，匀速
//    //转场动画相关的
//    UIViewAnimationOptionTransitionNone //无转场动画
//    UIViewAnimationOptionTransitionFlipFromLeft //转场从左翻转
//    UIViewAnimationOptionTransitionFlipFromRight //转场从右翻转
//    UIViewAnimationOptionTransitionCurlUp //上卷转场
//    UIViewAnimationOptionTransitionCurlDown //下卷转场
//    UIViewAnimationOptionTransitionCrossDissolve //转场交叉消失
//    UIViewAnimationOptionTransitionFlipFromTop //转场从上翻转
//    UIViewAnimationOptionTransitionFlipFromBottom //转场从下翻转
// 当前登录的用户
@implementation KVController

@synthesize VTag;

- (void) viewDidLoad {
    [super viewDidLoad];
    self.isInited = NO;
}



- (id) initWithVTag:(NSString *)text {
    if (self == [super self]) {
        [self setVTag:text];
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

+ (void)TransitionFrom :(UIViewController *)startVC
                    To :(UIViewController *)endVC
         WithAnimation :(UIViewAnimationOptions)animation{
    
    [[KVController getCurrentVC] transitionFromViewController:startVC
                                             toViewController:endVC
                                                     duration:0.2
                                                      options:animation
                                                   animations:nil
                                                   completion:nil];
    
}


+ (void) showMessage:(NSString *)message btn:(UIButton *)btn {
    if (btn != nil) {
        btn.enabled = NO;
    }
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview = [[UIView alloc]initWithFrame:CGRectMake(0, SRVAL(132.0f) + 20, GWID, SRVAL(62.0f))];
    showview.backgroundColor = UIColorFromRGB(0xfd9426, 1);
    showview.alpha = 0.8f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, GWID, SRVAL(62.0f))];
    label.text = message;
    label.textColor = [UIColor blackColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:SRVAL(31.0f)];
    [showview addSubview:label];
    [UIView animateWithDuration:2.0f animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
        if (btn != nil) {
            btn.enabled =YES;
        }
    }];
}
//获取当前屏幕显示的viewcontroller
+ (UIViewController *) getCurrentVC {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    [nextResponder isKindOfClass:[UIViewController class]] ? (result = nextResponder) :(result = window.rootViewController);
    return result;
}
+ (NSString *)GetFlowInVC:(NSString *)VTag ByControl:(NSString *)control{
    NSMutableDictionary *dic = (NSMutableDictionary *)[UerDafault valueForKey:@"flow"];
    NSString *result = [[dic valueForKey:VTag] valueForKey:control];
    return result;
}
@end
