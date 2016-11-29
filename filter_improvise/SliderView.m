//
//  SliderView.m
//  filter_improvise
//
//  Created by keyon on 2016/11/28.
//  Copyright © 2016年 keyon. All rights reserved.
//

#import "SliderView.h"
#import "keyon.h"
@implementation SliderView
@synthesize save;
@synthesize cancel;
@synthesize slider;
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = UIColorFromRGB(0x000000, 1);
    //保存
    save = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    save.backgroundColor = UIColorFromRGB(0xffffff, 1);
    [self addSubview:save];
    //取消
    cancel = [[UIButton alloc] initWithFrame:CGRectMake(GWID - 30, 10, 20, 20)];
    cancel.backgroundColor = UIColorFromRGB(0xffffff, 1);
    [self addSubview:cancel];
    //滑块
    slider = [[UISlider alloc] initWithFrame:CGRectMake(40, 10, GWID - 80, 20)];
    slider.minimumTrackTintColor = UIColorFromRGB(0xffffff, 1);
    slider.maximumTrackTintColor = UIColorFromRGB(0xfd9426, 1);
    [slider setThumbImage:nil forState:UIControlStateNormal];
    [self addSubview:slider];
    return  self;
}
@end
