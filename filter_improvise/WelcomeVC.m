//
//  WelcomeVC.m
//  filter_improvise
//
//  Created by keyon on 2016/11/24.
//  Copyright © 2016年 keyon. All rights reserved.
//

#import "WelcomeVC.h"
#import "keyon.h"
#import "HomeVC.h"
@interface WelcomeVC ()

@end

@implementation WelcomeVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xffffff, 1);
//    NSTimer *timer = [NSTimer timerWithTimeInterval:3.0f
//                                             target:self
//                                           selector:@selector(jump)
//                                           userInfo:nil
//                                            repeats:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)jump{
    NSLog(@"done");
    HomeVC *home = [[HomeVC alloc] init];
    [self.navigationController pushViewController:home animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
