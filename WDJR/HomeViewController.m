//
//  HomeViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/10/25.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "HomeViewController.h"
#import "XlScrollViewController.h"
#import "BannerModel.h"
#import "HomeCell.h"
#import "MessageScrollerView.h"
#import "MessageScrollerModel.h"
#import "HomeModel.h"

@interface HomeViewController ()<HomeCellDelegate,TWlALertviewDelegate>
{
    NSString *quanSalt;
}
//存放广告信息
@property(nonatomic, strong) NSArray        *bannerList;
@property(nonatomic, strong) UIView         *headerView;
@property(nonatomic, strong) XlScrollViewController *adScrollView;
@property(nonatomic, strong)UIButton *bigBtn;
@property(nonatomic, strong) NSString *phoneStr,*userStatu;

//滚动广告
@property(nonatomic, strong)  MessageScrollerView *MessageView;
@property(nonatomic, strong)  NSMutableArray *messageList;



@property(nonatomic, strong) NSArray *homeList;


@end

@implementation HomeViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"woyun" image:[UIImage imageNamed:@"foot-icon1"] tag:1];
        //self.tabBarItem.selectedImage=[UIImage imageNamed:@"shouye_sel"];
        self.title = @"皖都金融";
        self.tabBarItem.title = @"首页";
        
        //调整tabbaritem中文字的位置
        self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    }
    return self;
}


-(NSMutableArray *)messageList
{
    if (_messageList ==nil) {
        
        _messageList = [[NSMutableArray alloc] init];
    }
    return _messageList;
}



//-(void)tuoyuan
//{
//    UIImageView *imgView = [[UIImageView alloc] init];
//    [imgView setImageWithURL:[NSURL URLWithString:@"http://lending.wdjr999.com/files/18?v=1487822183"] placeholderImage:[UIImage imageNamed:@"image.jpg"]];
//    
//    UIImage * srcImg =imgView.image;
//    CGFloat width = srcImg.size.width;
//    CGFloat height = srcImg.size.height;
//    //开始绘制图片
//    UIGraphicsBeginImageContext(srcImg.size);
//    CGContextRef gc = UIGraphicsGetCurrentContext();
//    ////绘制Clip区域
//    //我的图片是120*160
//    CGContextAddEllipseInRect(gc, CGRectMake(0, 0,160, 100)); //椭圆
//    CGContextClosePath(gc);
//    CGContextClip(gc);
//    //坐标系转换
//    //因为CGContextDrawImage会使用Quartz内的以左下角为(0,0)的坐标系
//    CGContextTranslateCTM(gc, 0, 160);
//    CGContextScaleCTM(gc, 1, -1);
//    
//    
//    CGContextDrawImage(gc, CGRectMake(0, 0, 160, 160), [srcImg CGImage]);
//    
//    
//    //结束绘画
//    UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    UIImageView * view =[[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 160, 160)];
//    view.center = self.view.center;
//    [view setImage:destImg];
//    [self.view addSubview:view];
//    view.hidden = YES;
//    imgView.hidden = YES;
//
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self isOpenOrActive];
    
//    [self tuoyuan];
    
    [self showRightItem];
   
    
    //如果没有登录，跳到登录页面
    if(![AppDataManager defaultManager].hasLogin){
        [_svc presentViewController:_svc.loginViewController];
    }else{
        //手势开启情况下
        if ([AppDataManager defaultManager].isOff && ![AppDataManager defaultManager].isShowGestures) {
            [_svc presentViewController:_svc.gesturePasswordController withObjects:@{@"type":@(1)}];
        }
    }
    
    
    _tableView.showsVerticalScrollIndicator   = NO;
    _tableView.tableHeaderView = [self headerViews];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    [self requestRefresh];

 
    //监听侧滑事件
//    UISwipeGestureRecognizer *recognizer;
//    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightClick)];
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
//    [self.view addGestureRecognizer:recognizer];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //self.tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-50);
    
    //把状态栏的中的颜色改为黑色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage buildImageWithColor:[AppAppearance sharedAppearance].whiteColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                                                      NSForegroundColorAttributeName:[AppAppearance sharedAppearance].blackColor}];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //把状态栏的中的颜色改为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage buildImageWithColor:[AppAppearance sharedAppearance].mainColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                                                      NSForegroundColorAttributeName:[AppAppearance sharedAppearance].whiteColor}];
    
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}




-(void)requestRefresh
{
    [self getBannerRequest];
}

//广告栏信息
-(void)getBannerRequest
{
    [BannerModel requestBannerModelOfCompletionHandler:^(NSArray * object) {
        
        if (object.count > 0) {
            
            _bannerList = object;
            [_adScrollView updateOfInterface:_bannerList];
            
            [self getMessage];
        }
        
    } failHandler:^(NSError *error, NSUInteger statusCode) {
        
        [self finishRequest];
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
    }];
  
}

//获取滚动消息
-(void)getMessage
{
 
    
    [MessageScrollerModel requestMessageScrollerModelOfCompletionHandler:^(id object) {
        
        
        _messageList = (NSMutableArray *)object;
        
        [_MessageView setDataMessageArray:_messageList];
        
        [self getHomeData];

        
    } failHandler:^(NSError *error, NSUInteger statusCode) {
        
        [_svc showMessage:error.domain];
        [self finishRequest];
        [_svc hideLoadingView];
        
        [self.tableView reloadData];
    }];
    

}

-(void)getHomeData
{
    
    
    [HomeModel requestHomeModelCompletionHandler:^(id object) {
        
        NSArray *array = (NSArray *)object;
        _homeList = array;
        
        [self finishRequest];
        [_svc hideLoadingView];
        
        [self.tableView reloadData];
        
    } failHandler:^(NSError *error, NSUInteger statusCode) {
        
        [self finishRequest];
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
    }];
    
}







-(UIView *)headerViews
{
    if (!_headerView) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH/3+35)];
        _headerView.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
        //图片轮播器
        _adScrollView = [[XlScrollViewController alloc] init];
//        _adScrollView.view.frame = CGRectMake(0, 0, _headerView.bounds.size.width, _headerView.bounds.size.height-40);
        
        _adScrollView.view.frame = CGRectMake(0, 0, WIDTH, WIDTH/3);
        _adScrollView.animationDuration = 3.f;
        _adScrollView.pageNumber = 0;
        _adScrollView.view.backgroundColor = [UIColor whiteColor];
        _adScrollView.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [_headerView addSubview:_adScrollView.view];
        [self addChildViewController:_adScrollView];
        
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_adScrollView.view.frame)+5, 25, 25)];
        img.image = [UIImage imageNamed:@"gg"];
        [_headerView addSubview:img];
        
        _MessageView = [[MessageScrollerView alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(_adScrollView.view.frame)+9, WIDTH-120, 21)];
        [_headerView addSubview:_MessageView];
        
        
        UILabel *morelbl = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH-70, CGRectGetMaxY(_adScrollView.view.frame)+9, 60, 22)];
        morelbl.font = shierFont;
        morelbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
        morelbl.text = @"查看更多>";
        [_headerView addSubview:morelbl];
        morelbl.userInteractionEnabled = YES;
        UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreMessage)];
        [morelbl addGestureRecognizer:tag];
    
    }
    
    return _headerView;
}

//更多消息
-(void)moreMessage
{
 
    
    [RequestManager getRequestWithURLPath:KURLMoreNews withParamer:nil completionHandler:^(id responseObject) {
        
        
        if ([responseObject[@"result"] integerValue] ==1) {
            
            responseObject = responseObject[@"data"];
         
             [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":responseObject[@"url"]}];
            
        }else{
            
            [_svc showMessage:responseObject[@"data"]];
        }
        
   
        
        [self finishRequest];
        [_svc hideLoadingView];
       
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        [self finishRequest];
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
        
    }];

}




#pragma mark ---UITableViewDelegate------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.homeList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [HomeCell HomeCellWithTableView:tableView];
    cell.delegate = self;
    
    HomeModel *model = _homeList[indexPath.row];
    cell.homeModel = model;
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *secionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    secionView.backgroundColor = [UIColor whiteColor];
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 5)];
    view.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    [secionView addSubview:view];
    
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(view.frame)+7, 20, 20)];
    iconImage.image = [UIImage imageNamed:@"zxtz"];
    [secionView addSubview:iconImage];
    
    UILabel *titlelbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImage.frame)+5, CGRectGetMaxY(view.frame)+7, 100, 25)];
    titlelbl.text = @"最新投标";
    //titlelbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    titlelbl.font = shisiFont;
    titlelbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    [secionView addSubview:titlelbl];
    
    
    
    return secionView;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[_svc pushViewController:_svc.companyDyamicViewController];
    
    HomeModel *model = _homeList[indexPath.row];
    
  
    if ([model.type_name isEqualToString:@"房贷"]) {
        
         [_svc pushViewController:_svc.houseGoodsDetailViewController withObjects:@{@"HomeModel":model}];
        
    }else{
    
         [_svc pushViewController:_svc.goodDetaileViewController withObjects:@{@"HomeModel":model}];
        
    }
    
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
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
   // [self isOpenOrActive];
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
                
                
                [RequestManager postRequestWithURLPath:KURLdealTender withParamer:@{@"bid":quanSalt,@"amount":money,@"secret":password} completionHandler:^(id responseObject) {
                     [self isOpenOrActive];
                    
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
        
                   // [self isOpenOrActive];
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




//让UITableView的section header view不悬停的方法
-(UITableViewStyle)tableViewStyle
{
    return UITableViewStyleGrouped;
}

////section头部间距
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 10;
//    }
//    return 5;//section头部高度
//}
////section头部视图
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 5)];
//    view.backgroundColor = [UIColor clearColor];
//    return view;
//}

//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 2)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}




-(void)showRightItem
{
    UIButton *btn = [self.class buttonWithImage:[UIImage imageNamed:@"dh"] title:nil target:self action:@selector(rightClick)];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];

    [self addItemForLeft:NO withItem:item spaceWidth:0];
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



@end
