//
//  HouseGoodsDetailViewController.m
//  WDJR
//
//  Created by zlkj on 2017/3/6.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import "HouseGoodsDetailViewController.h"
#import "HomeModel.h"
#import "HouseDetailHeaderView.h"
#import "CommonCell.h"

@interface HouseGoodsDetailViewController ()<TWlALertviewDelegate>

@property(nonatomic, strong) NSArray *itemsArray;
@property(nonatomic, strong) NSArray *itemsIcons;

@property(nonatomic, strong) HomeModel  *homeModel;
@property(nonatomic, strong)UIButton *bigBtn;
@property(nonatomic, strong) NSString *phoneStr,*userStatu;
@property(nonatomic, strong) HouseDetailHeaderView *headerView;
@property(nonatomic, strong) UILabel *fabuDay;
@property(nonatomic, strong) UILabel *huankuanDay;

@end

@implementation HouseGoodsDetailViewController


-(void)setIntentDic:(NSDictionary *)intentDic
{
    
    self.homeModel           = intentDic[@"HomeModel"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self isOpenOrActive];
    self.title = self.homeModel.title;
    
    self.itemsArray = @[@"项目详情",@"资质认证",@"投资记录",@"还款计划"];
    self.itemsIcons = @[@"db",@"jl",@"plan",@"plan"];
    
    
    
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.tableHeaderView =[self headerView];
    _tableView.tableFooterView = [self footerView];
    
    //没有分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    //把状态栏的中的颜色改为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage buildImageWithColor:[AppAppearance sharedAppearance].mainColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;

}


-(UIView *)headerView
{
    if (!_headerView) {
        
        _headerView = [[HouseDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, _tableView.bounds.size.height/2.8)];
        
        [_headerView setHomeModel:_homeModel];
        
        
    }
    return _headerView;
}



-(UIView *)footerView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 90)];
    
    UIButton *exitBtn = [[UIButton alloc] init];
    
    [exitBtn setBackgroundColor:[AppAppearance sharedAppearance].yellowColor];
    [exitBtn setTitle:@"立即投资" forState:UIControlStateNormal];
    [exitBtn setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
    exitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    exitBtn.layer.cornerRadius = 10;
    exitBtn.layer.masksToBounds = YES;
    
    exitBtn.frame = CGRectMake(20, 10, self.view.frame.size.width-40, 40);
    [exitBtn addTarget:self action:@selector(InvestClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:exitBtn];
    
    _fabuDay = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(exitBtn.frame)+5, WIDTH/2-5, 21)];
    _fabuDay.textAlignment =  NSTextAlignmentRight;
    _fabuDay.text = @"发布日期:2016-10-26";
    _fabuDay.font = shierFont;
    _fabuDay.textColor = [AppAppearance sharedAppearance].title2TextColor;
    [footerView addSubview:_fabuDay];
    
    _huankuanDay = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2+5, CGRectGetMaxY(exitBtn.frame)+5, WIDTH/2, 21)];
    _huankuanDay.textAlignment =  NSTextAlignmentLeft;
    _huankuanDay.text = @"还款日期:2017-10-26";
    _huankuanDay.font = shierFont;
    _huankuanDay.textColor = [AppAppearance sharedAppearance].title2TextColor;
    [footerView addSubview:_huankuanDay];
    
    
    
    _fabuDay.text = [NSString stringWithFormat:@"发布日期:%@",[_homeModel.open_at  substringToIndex:10]];
    _huankuanDay.text = [NSString stringWithFormat:@"还款日期:%@",_homeModel.repay_at];
    
    
    return footerView;
}
-(void)isOpenOrActive{
    [RequestManager getRequestWithURLPath:KURLUserStatus withParamer:nil completionHandler:^(id responseObject) {
        
        
        NSLog(@"hhhh%@",responseObject);
        
        if ([responseObject[@"result"] integerValue]==1){
            NSDictionary *dic=responseObject[@"data"][@"info"];
            _userStatu=dic[@"status"];
            //            if ([dic[@"status"] integerValue]!=2) {
            //                [self showbigbtn];
            //                return;
            //            }
        }
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        [self finishRequest];
        [_svc hideLoadingView];
        if (statusCode == 401) {
            
            [_svc presentViewController:_svc.loginViewController];
        }
        
    }];
}
//立即投资
-(void)InvestClick
{
    if ([_homeModel.is_secret integerValue] == 1) {
        
        [self loadAlertView:@"投标" contentStr:nil btnNum:2 btnStrArr:[NSArray arrayWithObjects:@"取消",@"确定", nil] type:11];
        
    }else{
        
        [self loadAlertView:@"投标" contentStr:nil btnNum:2 btnStrArr:[NSArray arrayWithObjects:@"取消",@"确定", nil] type:12];
    }
}

- (void)loadAlertView:(NSString *)title contentStr:(NSString *)content btnNum:(NSInteger)num btnStrArr:(NSArray *)array type:(NSInteger)typeStr
{
    
    TWLAlertView *alertView = [[TWLAlertView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [alertView initWithTitle:title contentStr:content type:typeStr btnNum:num btntitleArr:array];
    alertView.delegate = self;
    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview: alertView];
    
}


-(void)didClickButtonAtIndex:(NSUInteger)index password:(NSString *)password userMoney:(NSString *)money{
    
    [self.view endEditing:YES];
    if (index==100) {
        return;
    }
    if ([_userStatu integerValue]!=2) {
        [self showbigbtn];
        return;
    }
    switch (index) {
        case 101:
            NSLog(@"Click ok");
            
            if (password.length>0) {
                
                
                [RequestManager postRequestWithURLPath:KURLdealTender withParamer:@{@"bid":_homeModel.salt,@"amount":money,@"secret":password} completionHandler:^(id responseObject) {
                    
                    
                    NSLog(@"%@",responseObject);
                    
                    
                    NSDictionary *firstdic = (NSDictionary *)responseObject[@"data"];
                    
                    if ([responseObject[@"result"] integerValue]==1) {
                        NSDictionary *response = firstdic[@"form"];
                        NSDictionary *dic      = response[@"request_arr"];
                        
                        NSString *body =@"";
                        for (NSString *key in dic) {
                            NSLog(@"key: %@ value: %@", key, dic[key]);
                            body=[body stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,dic[key]]];
                        }
                        [_svc pushViewController:_svc.withDrawWebViewController withObjects:@{@"url":response[@"request_url"],@"body":body}];
                        
                    }else{
                        
                        
                        if ([firstdic[@"message"] isEqualToString:@"token_expired"]) {
                            
                            [_svc showMessage:@"权限过期，请重新登录"];
                            [_svc presentViewController:_svc.loginViewController];
                            
                        }else{
                            
                            
                            
                                [_svc showMessage:firstdic[@"message"]];

                            
                            
                        }
                        
                    }
                    
                    
                    
                    
                    [self finishRequest];
                    [_svc hideLoadingView];
                    
                } failureHandler:^(NSError *error, NSUInteger statusCode) {
                    
                    [self finishRequest];
                    [_svc hideLoadingView];
                    if (statusCode == 401) {
                        
                        [_svc presentViewController:_svc.loginViewController];
                    }
                    
                }];
                
                
                
                
            }else{
                
                //没有定向标
                [RequestManager postRequestWithURLPath:KURLdealTender withParamer:@{@"bid":_homeModel.salt,@"amount":money} completionHandler:^(id responseObject) {
                    
                    
                    NSLog(@"%@",responseObject);
                    
                    
                    NSDictionary *firstdic = (NSDictionary *)responseObject[@"data"];
                    
                    if ([responseObject[@"result"] integerValue]==1) {
                        NSDictionary *response = firstdic[@"form"];
                        NSDictionary *dic      = response[@"request_arr"];
                        
                        NSString *body =@"";
                        for (NSString *key in dic) {
                            NSLog(@"key: %@ value: %@", key, dic[key]);
                            body=[body stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,dic[key]]];
                        }
                        [_svc pushViewController:_svc.withDrawWebViewController withObjects:@{@"url":response[@"request_url"],@"body":body}];
                        
                    }else{
                        
                        
                        if ([firstdic[@"message"] isEqualToString:@"token_expired"]) {
                            
                            [_svc showMessage:@"权限过期，请重新登录"];
                            [_svc presentViewController:_svc.loginViewController];
                            
                        }else{
                            
                            
                                                           [_svc showMessage:firstdic[@"message"]];
                            
                            
                            
                        }
                        
                    }
                    
                    
                    
                    
                    [self finishRequest];
                    [_svc hideLoadingView];
                    
                } failureHandler:^(NSError *error, NSUInteger statusCode) {
                    
                    [self finishRequest];
                    [_svc hideLoadingView];
                    if (statusCode == 401) {
                        
                        [_svc presentViewController:_svc.loginViewController];
                    }
                    
                }];
                
            }
            
            
            
            
            break;
        case 100:
            NSLog(@"Click cancle");
            
            break;
        default:
            break;
    }
}

















#pragma mark ----------UITableViewDelegate---------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonCell *cell = [CommonCell commonCellWithTableView:tableView];
    
    
    cell.iconImg.image = [UIImage imageNamed:self.itemsIcons[indexPath.row]];
    cell.titlelbl.text = self.itemsArray[indexPath.row];
    
    
        
    if (indexPath.row == 2) {
        
        cell.detaillbl.text = [NSString stringWithFormat:@"已投资%@笔",_homeModel.times];
        cell.detaillbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
        
    }else if (indexPath.row ==3){
        
        cell.detaillbl.text = @"满标后计息";
        cell.detaillbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
        
    }else{
        
        cell.detaillbl.text = nil;
        
    }
        
    

    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row ==0) {
        //项目详情
        
        [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[NSString stringWithFormat:@"%@v1/h5/house/%@/about",KBaseURL,self.homeModel.salt]}];
        
    }else if (indexPath.row ==1){
        //资质认证
        [_svc pushViewController:_svc.qualificationViewController withObjects:@{@"HomeModel":self.homeModel}];
    
    }else if (indexPath.row ==2){
        //投资记录
         [_svc pushViewController:_svc.investRecodersViewController withObjects:@{@"salt":_homeModel.salt}];
    
    }else{
    
        //还款计划
        [_svc pushViewController:_svc.repaymentScheduleViewController withObjects:@{@"salt":_homeModel.salt}];
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}


//让UITableView的section header view不悬停的方法
-(UITableViewStyle)tableViewStyle
{
    return UITableViewStyleGrouped;
}

//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }
    return 2.5;//section头部高度
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 2.5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 2.5)];
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

-(void)showbigbtn{
    _bigBtn=[[UIButton alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _bigBtn.backgroundColor=[UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:0.3];
    [_bigBtn addTarget:self action:@selector(empty) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:_bigBtn];
    
    UIImageView *alertview=[[UIImageView alloc]initWithFrame:CGRectMake(30, 104, WIDTH-60, (WIDTH-60)*1.32)];
    alertview.clipsToBounds=YES;
    alertview.layer.cornerRadius=10;
    alertview.userInteractionEnabled=YES;
    alertview.image=[UIImage imageNamed:@"wdjr_alert"];
    [_bigBtn addSubview:alertview];
    
    UIButton *closeBtn=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-100, 0, 40, 40)];
    [closeBtn addTarget:self action:@selector(empty) forControlEvents:UIControlEventTouchUpInside];
    [alertview addSubview:closeBtn];
    
    UIButton *toOpenBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, (WIDTH-60)*1.32*0.8, WIDTH-100, (WIDTH-60)*1.32*0.18)];
    [toOpenBtn addTarget:self action:@selector(toOpenClick) forControlEvents:UIControlEventTouchUpInside];
    [alertview addSubview:toOpenBtn];
    
}
-(void)toOpenClick{
    [_bigBtn removeFromSuperview];
    if ([_userStatu integerValue]==0) {
        [_svc pushViewController:_svc.OpenAccountViewController];
    }else{
        [_svc pushViewController:_svc.ActiveAccountViewController];
    }
}
-(void)empty{
    [_bigBtn removeFromSuperview];
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
