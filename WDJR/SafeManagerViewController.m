//
//  SafeManagerViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "SafeManagerViewController.h"
#import "SafeCell.h"


@interface SafeManagerViewController ()

@property(nonatomic, strong) NSArray *itemsArray;

@end

@implementation SafeManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"安全中心";
    
    
      self.itemsArray = @[@[@"账户安全"],@[@"绑定银行卡"],@[@"手机认证"],@[@"交易密码"]];
    
    
    
    _tableView.showsVerticalScrollIndicator = NO;
    
    //没有分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//
//    AccountSafeViewController *accountSafe = [[AccountSafeViewController alloc] init];
//    BankCardViewController *bank = [[BankCardViewController alloc] init];
//    MobileCertificateViewController *mobile = [[MobileCertificateViewController alloc] init];
//    
//    NSArray *controllers = @[accountSafe,bank,mobile];
//    NSArray *titleArrays = @[@"账号安全",@"绑定银行卡",@"手机认证"];
//    
//    
//    
//    
//    SegmentView *segment = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) controllers:controllers titleArray:titleArrays ParentController:self];
//    segment.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
//    
//    [self.view addSubview:segment];
    
}


#pragma mark -----UITableViewDelegate---------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.itemsArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.itemsArray[section]  count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SafeCell *cell = [SafeCell safeCellTableView:tableView];
    cell.textLabel.text = _itemsArray[indexPath.section][indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [_svc pushViewController:_svc.accountSafeViewController];
    }else if (indexPath.section ==1){
        [_svc pushViewController:_svc.bankListViewController];
    }else if(indexPath.section ==2){
        [_svc pushViewController:_svc.mobileCertificateViewController];
    }else{
        [RequestManager getRequestWithURLPath:KURLPayment withParamer:nil completionHandler:^(id responseObject) {
            NSDictionary *firstdic = (NSDictionary *)responseObject[@"data"];
            NSDictionary *response = firstdic[@"form"];
            NSDictionary *dic      = response[@"request_arr"];
            NSString *body =@"";
            for (NSString *key in dic) {
                NSLog(@"key: %@ value: %@", key, dic[key]);
                body=[body stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,dic[key]]];
            }
            NSString *url=[NSString stringWithFormat:@"%@?%@",response[@"request_url"],[body substringFromIndex:1]];
            [_svc pushViewController:_svc.AddWebViewController withObjects:@{@"url":url}];
            
            
        } failureHandler:^(NSError *error, NSUInteger statusCode) {
            
            
        }];
    }
}










-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
}


//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 10;
//}



////让UITableView的section header view不悬停的方法
-(UITableViewStyle)tableViewStyle
{
    return UITableViewStyleGrouped;
}

//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 5;//section头部高度
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}



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
