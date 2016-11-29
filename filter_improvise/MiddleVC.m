//
//  MiddleVC.m
//  filter_improvise
//
//  Created by keyon on 2016/11/24.
//  Copyright © 2016年 keyon. All rights reserved.
//

#import "MiddleVC.h"
#import "keyon.h"
@interface MiddleVC ()

@end

@implementation MiddleVC
@synthesize imageView;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(SRVAL(15.0f), 44 + 20 + 20, GWID - SRVAL(30.0f), GHIT - 44 - 20 - 80 - 40);
    self.view.layer.borderWidth = 2;
    self.view.layer.borderColor = UIColorFromRGB(0xffffff, 1).CGColor;
    //
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
