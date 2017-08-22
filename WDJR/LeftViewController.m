//
//  LeftViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/10/27.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftHeaderView.h"
#import "LeftCell.h"

@interface LeftViewController ()

@property(nonatomic, strong) LeftHeaderView *headerView;

@property(nonatomic, strong) NSArray *itemsArray;
@property(nonatomic, strong) NSArray *itemsIcons;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:17/255.0 green:23/255.0 blue:28/255.0 alpha:1];
    
    
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableHeaderView =[self headerView];
    //没有分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.itemsArray = @[@[@"首页",@"我要理财",@"平台数据",@"投资指南",@"我的账号"]];
    self.itemsIcons = @[@[@"home",@"licai",@"shuju",@"zhinan",@"leftmy"]];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
    
     _headerView.phoneStr = [AppDataManager defaultManager].PhoneAccount;
}


-(UIView *)headerView
{
    if (!_headerView) {
        
        _headerView = [[LeftHeaderView alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, _tableView.bounds.size.height/5)];
        //_headerView.delegate = self;
        
        
        
    }
    return _headerView;
}




#pragma mark - UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.itemsArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    NSArray *arr = self.itemsArray[section];
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftCell *cell = [LeftCell leftCellWithTableView:tableView];
 
    cell.backgroundColor = [UIColor clearColor];
    cell.iconImg.image = [UIImage imageNamed:self.itemsIcons[indexPath.section][indexPath.row]];
    cell.titlelbl.text = self.itemsArray[indexPath.section][indexPath.row];
    cell.titlelbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    cell.titlelbl.font = shiliuFont;

    return cell;
  
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    LeftCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.titlelbl.textColor = [AppAppearance sharedAppearance].whiteColor;
//    cell.backgroundColor = [UIColor colorWithRed:15/255.0 green:19/255.0 blue:22/255.0 alpha:1];
    
    [self rightClick];
    
    if (indexPath.row == 0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TabBarControllerSelectedIndex" object:nil userInfo:@{@"index":@"0"}];
        
    }else if (indexPath.row ==1){
        
           [[NSNotificationCenter defaultCenter] postNotificationName:@"TabBarControllerSelectedIndex" object:nil userInfo:@{@"index":@"1"}];
    
    }else if (indexPath.row ==2){
    
        [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLPingTaiShuJu]}];
    }else if (indexPath.row ==3){
        
         [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLTouZiZhiNanWangZhan]}];
    
    }else if (indexPath.row ==4){
        
           [[NSNotificationCenter defaultCenter] postNotificationName:@"TabBarControllerSelectedIndex" object:nil userInfo:@{@"index":@"2"}];
    
    }

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}




-(void)rightClick
{
    
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}



//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CommonCell *cell = [CommonCell commonCellWithTableView:tableView];
//    cell.backgroundColor = [UIColor clearColor];
//    cell.titlelbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
//
//}



-(BOOL)shouldShowGetMore
{
    return NO;
}

-(BOOL)shouldShowRefresh
{
    return NO;
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
