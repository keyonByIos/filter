//
//  ScrollControl.m
//  filter_improvise
//
//  Created by keyon on 2016/11/24.
//  Copyright © 2016年 keyon. All rights reserved.
//

#import "ScrollControl.h"
#import "keyon.h"
#import <objc/runtime.h>
@implementation ScrollControl
@synthesize type_filter;
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.type_filter = [[NSArray alloc] initWithObjects:
                          @"曝光",@"对比度",@"饱和度",@"伽马线",@"怀旧",
                          @"不透明度",@"阴影弱化",@"色度",@"十字",nil];
    long count = [type_filter count];
    self.contentSize = CGSizeMake(count * (50 + 5) +5, 60);
    self.showsHorizontalScrollIndicator = NO;
    self.backgroundColor = UIColorFromRGB(0xfd9426, 1);
    for (int i = 0; i <count; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(5 + i * (50 + 5), 5, 50, 50)];
        [btn setBackgroundColor:UIColorFromRGB(0x000000, 1)];
        btn.layer.cornerRadius = 1;
        btn.layer.borderWidth = 1;
        btn.tag = i;
        btn.layer.borderColor = UIColorFromRGB(0xffffff, 1).CGColor;
        [self addSubview:btn];
        [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        //
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 50, 15)];
        label.text = (NSString *)type_filter[i];
        label.textColor = UIColorFromRGB(0xfd9426, 1);
        label.font = [UIFont systemFontOfSize:10.0f];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = UIColorFromRGB(0x929292, 0.75);
        [btn addSubview:label];
        //
        //btn添加标记
        objc_setAssociatedObject(btn, @"VTag", type_filter[i],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return  self;
}
- (UIView *)antimationView{
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = UIColorFromRGB(0xffffff, 1);
    
    return  self;
}
- (void)pop{
    
}
@end
