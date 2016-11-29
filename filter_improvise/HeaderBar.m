//
//  HeaderBar.m
//  filter_improvise
//
//  Created by keyon on 2016/11/28.
//  Copyright © 2016年 keyon. All rights reserved.
//

#import "HeaderBar.h"

@implementation HeaderBar
@synthesize leftButton;
@synthesize clockwise;
@synthesize anticlockwise;
@synthesize reast;
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = UIColorFromRGB(0x000000, 1);
    
    //line
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 63, GWID, 1.0f)];
    line1.backgroundColor = UIColorFromRGB(0xfd9426, 1);
    [self addSubview:line1];
    //相册选择图片
    leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 26.5f, 30, 30)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [self addSubview:leftButton];
    //顺时针
    clockwise = [[UIButton alloc] initWithFrame:CGRectMake(50, 26.5f, 30, 30)];
    [clockwise setTitle:@"顺" forState:UIControlStateNormal];
    clockwise.titleLabel.font = [UIFont systemFontOfSize:30];
    [clockwise setTitleColor:UIColorFromRGB(0xfd9426, 1) forState:UIControlStateNormal];
    [self addSubview:clockwise];
    //逆时针
    anticlockwise  = [[UIButton alloc] initWithFrame:CGRectMake(90, 26.5f, 30, 30)];
    [anticlockwise  setTitle:@"逆" forState:UIControlStateNormal];
    anticlockwise.titleLabel.font = [UIFont systemFontOfSize:30];
    [anticlockwise  setTitleColor:UIColorFromRGB(0xfd9426, 1) forState:UIControlStateNormal];
    [self addSubview:anticlockwise];
    //重置
    reast = [[UIButton alloc] initWithFrame:CGRectMake(130, 26.5f, 30, 30)];
    [reast setBackgroundImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
    [self addSubview:reast];
    
    return  self;
}

@end
