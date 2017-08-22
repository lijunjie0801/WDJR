//
//  ManageMoneyViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/10/25.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "ManageMoneyViewController.h"
#import "DOPDropDownMenu.h"
#import "HomeCell.h"
#import "HomeModel.h"

@interface ManageMoneyViewController ()<DOPDropDownMenuDataSource, DOPDropDownMenuDelegate,HomeCellDelegate,TWlALertviewDelegate>
{
    int pageNum;
    int status ;
    NSString *dealine;
    NSString *quanSalt;
}


@property(nonatomic, strong) NSArray *borrowStateArray;

@property(nonatomic, strong) NSArray *borrowDayArray;

@property(nonatomic, strong) NSMutableArray *borrowList;

@property(nonatomic, strong)UIButton *bigBtn;
@property(nonatomic, strong) NSString *phoneStr,*userStatu;

@end

@implementation ManageMoneyViewController


-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"woyun" image:[UIImage imageNamed:@"foot-icon2"] tag:1];
        //self.tabBarItem.selectedImage=[UIImage imageNamed:@"shouye_sel"];
        self.title = @"我要理财";
        self.tabBarItem.title = @"我要理财";
        
        //调整tabbaritem中文字的位置
        self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    pageNum = 1;
    status  = 0;
    dealine = @"0";
    _borrowList = [NSMutableArray array];
    
    _borrowStateArray = @[@"借款状态",@"全部",@"即将发布",@"投标中",@"投标结束",@"还款中",@"还款结束"];
    _borrowDayArray   = @[@"借款期限",@"全部",@"天标",@"1个月",@"3个月",@"6个月",@"12个月"];
    
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:40];
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];
    
    
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(menu.frame), WIDTH, HEIGHT-40);
    
    [self requestRefresh];
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    //把状态栏的中的颜色改为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage buildImageWithColor:[AppAppearance sharedAppearance].mainColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                                                      NSForegroundColorAttributeName:[AppAppearance sharedAppearance].whiteColor}];
    
//    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
    
    
}

//下拉刷新
-(void)requestRefresh
{
    [_borrowList removeAllObjects];
    pageNum = 1;
    NSLog(@"pageNum=%d,status=%d, deadline=%@",pageNum,status,dealine);
    [self.tableView reloadData];
    [_svc  showLoadingWithMessage:@"加载中..." inView:[UIApplication sharedApplication].keyWindow ];
    
    [HomeModel requestHomeModelManagerPage:pageNum andStatus:status andDeadline:dealine CompletionHandler:^(id object) {
        
        
        NSArray *array = (NSArray *)object;

        [_borrowList addObjectsFromArray:array];
        [self finishRequest];
        [_svc hideLoadingView];
        
        [self.tableView reloadData];
        
    } failHandler:^(NSError *error, NSUInteger statusCode) {
        
        [self finishRequest];
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
    }];
}

-(void)requestGetMore
{
    pageNum+=1;
    NSLog(@"pageNum=%d,status=%d, deadline=%@",pageNum,status,dealine);
    [HomeModel requestHomeModelManagerPage:pageNum andStatus:status andDeadline:dealine CompletionHandler:^(id object) {
        
        
        NSArray *array = (NSArray *)object;
       
        [_borrowList addObjectsFromArray:array];
        [self finishRequest];
        [_svc hideLoadingView];
        
        [self.tableView reloadData];
        
    } failHandler:^(NSError *error, NSUInteger statusCode) {
        
        [self finishRequest];
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
    }];
}



- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu {
    return 2;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    
    if (column == 0) {
        
        return _borrowStateArray.count;
    }
    return _borrowDayArray.count;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    switch (indexPath.column) {
        case 0:
      
            return (NSString *)self.borrowStateArray[indexPath.row];
            break;
        case 1:

            return (NSString *)self.borrowDayArray[indexPath.row];
            break;
        default:
            return nil;
            break;
    }
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath {
    NSLog(@"column:%li row:%li", (long)indexPath.column, (long)indexPath.row);
    NSLog(@"%@",[menu titleForRowAtIndexPath:indexPath]);
    NSString *title = [menu titleForRowAtIndexPath:indexPath];
    if (indexPath.column == 0) {
        
        if (indexPath.row ==0) {
            
            status = 0;
        }else{
        
            status = indexPath.row -1;
            
        }
    }else{
    
        if ([title isEqualToString:@"借款期限"]) {
            
            dealine= @"0";
        }else if ([title isEqualToString:@"全部"]){
            
            dealine = @"0";
        }
        else if ([title isEqualToString:@"天标"]){
        
            dealine = @"d";
        }else if ([title isEqualToString:@"1个月"]){
            
            dealine = @"1";
        }else if ([title isEqualToString:@"3个月"]){
            
            dealine = @"3";
        }else if ([title isEqualToString:@"6个月"]){
            
            dealine = @"6";
        }else if ([title isEqualToString:@"12个月"]){
            
            dealine = @"12";
        }
    }
    
    NSLog(@"%d----%@",status,dealine);
    

   [_borrowList removeAllObjects];
    
    [self requestRefresh];
    //[self.tableView reloadData];
}



#pragma mark ---UITableViewDelegate------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _borrowList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [HomeCell HomeCellWithTableView:tableView];
    cell.delegate = self;
    
    HomeModel *model = _borrowList[indexPath.row];
    cell.homeModel = model;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeModel *model = _borrowList[indexPath.row];
    
    if ([model.type_name isEqualToString:@"房贷"]) {
        
        [_svc pushViewController:_svc.houseGoodsDetailViewController withObjects:@{@"HomeModel":model}];
        
    }else{
        
        [_svc pushViewController:_svc.goodDetaileViewController withObjects:@{@"HomeModel":model}];
        
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


#pragma mark ---HomeCellDelegate-----

-(void)touBiaoClick:(NSString *)salt andisSecret:(NSString *)secret
{
    
    quanSalt = salt;
    
    if ([secret isEqualToString:@"1"]) {
        
        [self loadAlertView:@"投标" contentStr:nil btnNum:2 btnStrArr:[NSArray arrayWithObjects:@"取消",@"确定", nil] type:11];
        
    }else{
        
        [self loadAlertView:@"投标" contentStr:nil btnNum:2 btnStrArr:[NSArray arrayWithObjects:@"取消",@"确定", nil] type:12];
    }
    
}



- (void)loadAlertView:(NSString *)title contentStr:(NSString *)content btnNum:(NSInteger)num btnStrArr:(NSArray *)array type:(NSInteger)typeStr
{
    [self isOpenOrActive];
    TWLAlertView *alertView = [[TWLAlertView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [alertView initWithTitle:title contentStr:content type:typeStr btnNum:num btntitleArr:array];
    alertView.delegate = self;
    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview: alertView];
    
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
            NSLog(@"Click ok ==%@====%@",password,money);
            
            if (password.length>0) {
            
                [RequestManager postRequestWithURLPath:KURLdealTender withParamer:@{@"bid":quanSalt,@"amount":money,@"secret":password} completionHandler:^(id responseObject) {
                    
                    
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
                [RequestManager postRequestWithURLPath:KURLdealTender withParamer:@{@"bid":quanSalt,@"amount":money} completionHandler:^(id responseObject) {
                    
                    
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
