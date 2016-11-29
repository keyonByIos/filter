//
//  OperationVC.m
//  filter_improvise
//
//  Created by keyon on 2016/11/24.
//  Copyright © 2016年 keyon. All rights reserved.
//

#import "OperationVC.h"
#import "keyon.h"
#import "ScrollControl.h"
@interface OperationVC ()
@end

@implementation OperationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, GHIT - 60, GWID, 60);
    
    //[self.view addSubview:[ScrollControl draw:[[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil]]];
}

@end
