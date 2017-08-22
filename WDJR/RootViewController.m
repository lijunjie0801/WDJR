//
//  RootViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/10/25.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "RootViewController.h"
#import "HomeViewController.h"
#import "ManageMoneyViewController.h"
#import "MyselfViewController.h"
#import "AboutUsViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarControllerSelectedIndex:) name:@"TabBarControllerSelectedIndex" object:nil];
    
}
-(NSArray *)viewControllers
{
    return @[[HomeViewController new],[ManageMoneyViewController new],[MyselfViewController new],[AboutUsViewController new]];
    
}


-(void)tabBarControllerSelectedIndex:(NSNotification *)notification
{
    NSInteger index = [notification.userInfo[@"index"] integerValue];
    
    self.selectedIndex = index;
}




-(BOOL)shouldSelectIndex:(NSInteger)index viewController:(UIViewController *)viewController
{
    
    return YES;
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
