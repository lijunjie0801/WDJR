//
//  MyInvestViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "MyInvestViewController.h"
#import "MyInvestRecodeViewController.h"
#import "SecondGoodViewController.h"
#import "DueInDetailsViewController.h"
#import "AlreadyReturnViewController.h"
#import "SegmentView.h"

@interface MyInvestViewController ()

@end

@implementation MyInvestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的投资";
    
    MyInvestRecodeViewController *recode = [[MyInvestRecodeViewController alloc] init];
    SecondGoodViewController *second = [[SecondGoodViewController alloc] init];
    DueInDetailsViewController *dueIn = [[DueInDetailsViewController alloc] init];
    AlreadyReturnViewController *alreturn = [[AlreadyReturnViewController alloc] init];


    NSArray *controllers = @[recode,second,dueIn,alreturn];
    NSArray *titleArrays = @[@"投资记录",@"在投项目",@"待收明细",@"已回款",@"消息"];
    
    
    
    
    SegmentView *segment = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) controllers:controllers titleArray:titleArrays ParentController:self];
    segment.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
    
    [self.view addSubview:segment];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
