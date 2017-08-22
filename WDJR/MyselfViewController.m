//
//  MyselfViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/10/25.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "MyselfViewController.h"
#import "MyselfHeaderView.h"
#import "MyselfCell.h"
#import "CommonCell.h"
#import "MyBalanceModel.h"

@interface MyselfViewController ()<MyselfHeaderViewDelegate,TWlALertviewDelegate>

@property(nonatomic, strong) MyselfHeaderView *headerView;

@property(nonatomic, strong) NSArray *itemsArray;
@property(nonatomic, strong) NSArray *itemsIcons;

@property(nonatomic, strong) MyBalanceModel *myBankModel;
@property(nonatomic, strong)UIButton *bigBtn;
@property(nonatomic, strong) NSString *phoneStr,*userStatu;


@end

@implementation MyselfViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"woyun" image:[UIImage imageNamed:@"foot-icon3"] tag:1];
        //self.tabBarItem.selectedImage=[UIImage imageNamed:@"shouye_sel"];
        self.title = @"我的账号";
        self.tabBarItem.title = @"我的账号";
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(-3,0, 3, 0);
        
        //调整tabbaritem中文字的位置
        self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.itemsArray = @[@[@""],@[@"我的投资",@"资金记录",@"安全中心",@"推荐奖励",@"自动投标",@"专享客服"]];
    self.itemsIcons = @[@[@""],@[@"touzi",@"zijin",@"safe",@"gift",@"toubiao",@"kefu"]];
    
    
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.tableHeaderView =[self headerView];
    _tableView.tableFooterView = [self footerView];
    
    //没有分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
}





-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
    
    //把状态栏的中的颜色改为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage buildImageWithColor:[AppAppearance sharedAppearance].mainColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                                                      NSForegroundColorAttributeName:[AppAppearance sharedAppearance].whiteColor}];
    
    [self requestRefresh];
    
}



-(void)requestRefresh
{
    [MyBalanceModel requestMyBalanceModelSuccessHandle:^(id object) {
        
        _myBankModel = (MyBalanceModel *)object;
        
        [_headerView setMyBankModel:_myBankModel];

//        [self.tableView reloadData];
//        [self finishRequest];
//        [_svc hideLoadingView];
        [self requestContact];
        
    } failureHandle:^(NSError *error, NSUInteger statusCode) {
        
        [self finishRequest];
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
        [_tableView reloadData];

    }];
}

//获取联系方式
-(void)requestContact
{
    [RequestManager getRequestWithURLPath:KURLContact withParamer:nil completionHandler:^(id responseObject) {
        
        if ([responseObject[@"result"] intValue] ==1) {
            
            
            NSDictionary *dic = responseObject[@"data"];
            self.phoneStr = dic[@"info"][@"phone_400"];
            
        }
        
        
        
        [self.tableView reloadData];
        [self finishRequest];
        [_svc hideLoadingView];
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        [self finishRequest];
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
        [_tableView reloadData];
        
    }];
}


-(UIView *)headerView
{
    if (!_headerView) {
        
        _headerView = [[MyselfHeaderView alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, _tableView.bounds.size.height/3.5)];
        _headerView.delegate = self;
 
    }
    return _headerView;
}


-(UIView *)footerView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 70)];
    
    UIButton *exitBtn = [[UIButton alloc] init];
    
    [exitBtn setBackgroundColor:[AppAppearance sharedAppearance].mainColor];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBtn setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
    exitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    exitBtn.layer.cornerRadius = 10;
    exitBtn.layer.masksToBounds = YES;
    
    exitBtn.frame = CGRectMake(20, 10, self.view.frame.size.width-40, 50);
    [exitBtn addTarget:self action:@selector(exitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:exitBtn];
    
    return footerView;
}

//退出登陆
-(void)exitButtonAction:(UIButton *)button
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"确认退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[AppDataManager defaultManager] logout];
        
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"TabBarControllerSelectedIndex" object:nil userInfo:@{@"index":@"0"}];
        [_svc presentViewController:_svc.loginViewController];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
    
    
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
    CommonCell *cell = [CommonCell commonCellWithTableView:tableView];
    
    MyselfCell *mycell = [MyselfCell myselfCellWithTableView:tableView];

    if (indexPath.section == 0) {
        
        mycell.myBalanceModel = _myBankModel;
        return mycell;
    }else{
        
        cell.iconImg.image = [UIImage imageNamed:self.itemsIcons[indexPath.section][indexPath.row]];
        cell.titlelbl.text = self.itemsArray[indexPath.section][indexPath.row];
        
        //        if (indexPath.section == 0) {
        //
        //            cell.detaillbl.text =[NSString stringWithFormat:@"%@元",[Utility priceChange:[self.sumModel.yishoulixi floatValue]]];
        //            cell.detaillbl.textColor = [UIColor redColor];
        //
        //        }
        if (indexPath.row == 5) {
            
            cell.detaillbl.text = self.phoneStr;
            cell.detaillbl.textColor = [AppAppearance sharedAppearance].mainColor;
        }else{
        
            cell.detaillbl.text =@"";
        }
        
        // 设置箭头
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==1) {
        
        if (indexPath.row == 0) {
            
            [_svc pushViewController:_svc.myInvestViewController];
            
        }else if (indexPath.row ==1){
            
            [_svc pushViewController:_svc.moneyRecordViewController];
        
        }else if (indexPath.row ==2){
            
            [_svc pushViewController:_svc.safeManagerViewController];
        
        }else if (indexPath.row ==3){
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":_myBankModel.invite_url}];
        
        }else if (indexPath.row ==4){
            //自动投标
            [_svc pushViewController:_svc.autoTenderViewController];
        
        }else if (indexPath.row == 5){
        
            
            //客服热线
            NSString *phoneNum = self.phoneStr;
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:phoneNum preferredStyle:UIAlertControllerStyleAlert];
            
            
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNum]]];
                
            }];
            
            [alertController addAction:okAction];
            [alertController addAction:cancelAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        return 75;
    }
    return 44;
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



#pragma mark ---MyselfHeaderViewDelegate-------
//提现
-(void)withDrawClick
{
   

    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提现" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    
    // 创建文本框
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"请输入充值金额";
        textField.secureTextEntry = NO;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *userMoney = alertController.textFields.firstObject;
        
        [RequestManager getRequestWithURLPath:KURLUserStatus withParamer:nil completionHandler:^(id responseObject) {
            
            
            NSLog(@"hhhh%@",responseObject);
            
            if ([responseObject[@"result"] integerValue]==1){
                NSDictionary *dic=responseObject[@"data"][@"info"];
                _userStatu=dic[@"status"];
                if ([dic[@"status"] integerValue]!=2) {
                    [self showbigbtn];
                    return;
                }
            }
        } failureHandler:^(NSError *error, NSUInteger statusCode) {
            
            [self finishRequest];
            [_svc hideLoadingView];
            if (statusCode == 401) {
                
                [_svc presentViewController:_svc.loginViewController];
            }
            
        }];
        [RequestManager postRequestWithURLPath:KURLwithDraw withParamer:@{@"amount":userMoney.text} completionHandler:^(id responseObject) {
            
            
            NSLog(@"%@",responseObject);
            
            NSDictionary *fistDic = responseObject[@"data"];
            
            if ([responseObject[@"result"] integerValue]==1) {
                
                
                NSDictionary *response = fistDic[@"form"];
                NSDictionary *dic      = response[@"request_arr"];
                
                NSString *body =@"";
                for (NSString *key in dic) {
                    NSLog(@"key: %@ value: %@", key, dic[key]);
                    body=[body stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,dic[key]]];
                }
                [_svc pushViewController:_svc.withDrawWebViewController withObjects:@{@"url":response[@"request_url"],@"body":body}];

                
                
            }else{
                
                NSDictionary *firstdic = (NSDictionary *)responseObject[@"data"];
                
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
                 [_svc showMessage:@"权限过期，请重新登录"];
                [_svc presentViewController:_svc.loginViewController];
            }
            
        }];
        
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
    
    
    
    
    
   
}
-(void)topUpClick
{

    
        [RequestManager getRequestWithURLPath:KURLUserStatus withParamer:nil completionHandler:^(id responseObject) {
            
            
            NSLog(@"hhhh%@",responseObject);
           
            if ([responseObject[@"result"] integerValue]==1){
                NSDictionary *dic=responseObject[@"data"][@"info"];
                _userStatu=dic[@"status"];
                if ([dic[@"status"] integerValue]!=2) {
                    [self showbigbtn];
                }else{
                    [_svc pushViewController:_svc.RechargeViewController];
                }
            }
        } failureHandler:^(NSError *error, NSUInteger statusCode) {
            
            [self finishRequest];
            [_svc hideLoadingView];
            if (statusCode == 401) {
                
                [_svc presentViewController:_svc.loginViewController];
            }
            
        }];
        
        
//    }];
//    
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
//    
//    [alertController addAction:okAction];
//    [alertController addAction:cancelAction];
    
  //  [self.navigationController presentViewController:alertController animated:YES completion:nil];
    

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


-(BOOL)shouldShowGetMore
{
    return NO;
}


-(BOOL)shouldShowBackItem
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
