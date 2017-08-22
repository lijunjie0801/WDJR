//
//  SwitchViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/10/25.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "SwitchViewController.h"
#import "MBProgressHUD.h"
#import "BaseViewController.h"
#import "AppNavigationController.h"
#import "AppNavigationBar.h"
#import "RootViewController.h"
#import "LoginViewController.h"
#import "CompanyDyamicViewController.h"
#import "FindPwdViewController.h"
#import "RegisterViewController.h"
#import "GoodDetaileViewController.h"
#import "SafeManagerViewController.h"
#import "MyInvestViewController.h"
#import "InvestRecodersViewController.h"
#import "MyInvestDetailesViewController.h"
#import "AutoTenderViewController.h"
#import "BaseWebViewViewController.h"
#import "AccountSafeViewController.h"
#import "MobileCertificateViewController.h"
#import "AutoTenderWebViewController.h"
#import "GoodDeatileWebViewController.h"
#import "TopUpWebViewController.h"
#import "WithDrawWebViewController.h"
#import "BankCardViewController.h"
#import "MoneyRecordViewController.h"
#import "MoneyRecordDetailViewController.h"
#import "DredgeHuiFuWebViewController.h"
#import "RepaymentScheduleViewController.h"
#import "BankListViewController.h"
#import "GesturePasswordController.h"
#import "HouseGoodsDetailViewController.h"
#import "QualificationViewController.h"
#import "VoucherexchangeViewController.h"
#import "OpenAccountViewController.h"
#import "SelectBankViewController.h"
#import "ActiveAcountViewController.h"
#import "RechargeViewController.h"
#import "AddWebViewController.h"
#import "TestWebViewController.h"
@interface SwitchViewController ()<UIAlertViewDelegate>

{
    UINavigationController __weak* _topNavigationController;
    NSCache *_cacher;
}

@property(nonatomic, weak) UINavigationController *topNavigationController;
@property(nonatomic, strong) MBProgressHUD *hud;
@property(nonatomic, strong) MBProgressHUD *showMessage;

@end


@implementation SwitchViewController

+(instancetype)sharedSVC
{
    static SwitchViewController *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [SwitchViewController new];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cacher = [[NSCache alloc] init];
        //发出通知监听内存警告
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

//当发出内存警告，就释放缓存中的数据
-(void)didReceiveMemoryWarning
{
    [_cacher removeAllObjects];
}

-(void)hideHud
{
    [self.hud hide:YES];
}

-(void)hideLoadingView
{
    [_showMessage hide:YES];
}

-(void)hideHudAfterDelay:(NSTimeInterval)delay
{
    [self.hud hide:YES afterDelay:delay];
}


-(MBProgressHUD *)hud
{
    if (!_hud) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        _hud = [[MBProgressHUD alloc] initWithWindow:keyWindow];
        _hud.detailsLabelFont = [UIFont systemFontOfSize:16];
        self.hud.animationType = MBProgressHUDAnimationZoomIn;
        self.hud.cornerRadius = 5;
        [keyWindow addSubview:self.hud];
    }
    return _hud;
}

-(void)showMessage:(NSString *)message
{
    [self showMessage:message duration:2.0];
}

-(void)showMessage:(NSString *)message duration:(NSTimeInterval)time
{
    self.hud.mode = MBProgressHUDModeText;
    self.hud.detailsLabelText = message;
    [self.hud show:YES];
    [self.hud hide:YES afterDelay:time];
}

-(void)setHudMessage:(NSString *)message
{
    self.hud.detailsLabelText = message;
}


-(void)showLoadingWithMessage:(NSString *)message
{
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.detailsLabelText = message;
    [self.hud show:YES];
}



-(void)showLoadingWithMessage:(NSString *)message inView:(UIView *)view
{
    [_showMessage removeFromSuperview];
    
    _showMessage = [[MBProgressHUD alloc] initWithView:view];
    
    [view addSubview:_showMessage];
    
    _showMessage.labelText = message;
    [_showMessage show:YES];
}



-(void)pushReuseObject:(NSObject *)obj
{
    NSString *key = NSStringFromClass(obj.class);
    NSCache *cache = [_cacher objectForKey:key];
    if (!cache) {
        cache = [[NSCache alloc] init];
        //当缓存的数量超过countLimit，或者cost之和超过totalCostLimit，NSCache会自动释放部分缓存。
        [cache setCountLimit:1];
        [_cacher setObject:cache  forKey:key];
    }
    [cache setObject:obj forKey:key];
}

-(void)presentViewController:(BaseViewController *)vc
{
    AppNavigationController *nav =[self aNavigationControllerWithRootViewController:vc];
    //模态视图的动画效果
//    nav.modalPresentationStyle = UIModalPresentationCustom;
//    nav.transitioningDelegate = [TXTransition sharedtransition];
    
    [self.topNavigationController presentViewController:nav animated:YES completion:NULL];
    self.topNavigationController = nav;
}


-(void)presentViewController:(BaseViewController *)vc withObjects:(NSDictionary *)intentDic
{
    vc.intentDic = intentDic;
    
    [self presentViewController:vc];
}


-(void)setTopNavigationController:(UINavigationController *)topNavigationController
{
    if ([topNavigationController isKindOfClass:[UINavigationController class]]) {
        
        _topNavigationController = topNavigationController;
    }else {
        
        _topNavigationController = nil;
    }
}




#pragma mark --getters

-(UINavigationController *)topNavigationController {
    if (!_topNavigationController) {
        _topNavigationController = self.rootNaviController;
        if (!_topNavigationController) {
            return nil;
        }
        UINavigationController* vc = (UINavigationController*)_topNavigationController.presentedViewController;
        while (vc) {
            _topNavigationController = vc;
            //此视图控制器的视图控制器或其最近的祖先。
            vc = (UINavigationController*)_topNavigationController.presentedViewController;
        }
    }
    
    
    return _topNavigationController;
}


@synthesize rootNaviController = _rootNaviController;

-(AppNavigationController *)rootNaviController
{
    if (!_rootNaviController) {
        
        RootViewController *vc=[[RootViewController alloc] init];
        _rootNaviController = [self aNavigationControllerWithRootViewController:vc];
    }
    return _rootNaviController;
}



-(AppNavigationController *)aNavigationControllerWithRootViewController:(BaseViewController *)vc
{
    AppNavigationController *navi=[[AppNavigationController alloc] init];
    [navi pushViewController:vc animated:NO];
    return navi;
}

-(void)pushViewController:(BaseViewController *)vc
{
    [self.topNavigationController pushViewController:vc animated:YES];
}

-(void)pushViewController:(BaseViewController *)vc withObjects:(NSDictionary *)intentDic
{
    vc.intentDic = intentDic;
    [self pushViewController:vc];
}


-(void)popToViewController:(UIViewController *)vc
{
    [self.topNavigationController popToViewController:vc animated:YES];
}

//推出一个视图
-(BaseViewController *)popViewController
{
    BaseViewController *vc =(BaseViewController *)[self.topNavigationController popViewControllerAnimated:YES];
    if (vc.canBeCached) {
        
        [self pushReuseObject:vc];
    }
    return vc;
}

//重新进入一个视图，并且释放缓存
-(NSObject *)popReuseObjectForClass:(Class)class
{
    //把class类型转换成NString,就是获取class的类名
    NSString *key = NSStringFromClass(class);
    
    NSCache *cache = [_cacher objectForKey:key];
    NSObject *obj = [cache objectForKey:key];
    [cache removeObjectForKey:key];
    return obj;
    
}

-(void)dismissTopViewControllerCompletion:(void (^)(void))completion
{
    UINavigationController* navi = (UINavigationController*)self.topNavigationController.presentingViewController;
    NSArray* vcs = self.topNavigationController.viewControllers;
    
    [self.topNavigationController dismissViewControllerAnimated:YES completion:^{
        [vcs enumerateObjectsUsingBlock:^(BaseViewController *vc, NSUInteger idx, BOOL *stop) {
            if ([vc respondsToSelector:@selector(canBeCached)]) {
                if ([vc canBeCached]) {
                    [self pushReuseObject:vc];
                }
            }
        }];
        self.topNavigationController = navi;
        if (completion) {
            completion();
        }
    }];
    
}



#pragma mark ---- 跳转界面-----
-(BaseViewController *)loginViewController
{
    LoginViewController *vc = (LoginViewController *)[self popReuseObjectForClass:[LoginViewController class]];
    if (!vc)
    {
        vc = [[LoginViewController alloc]init];
    }
    return vc;
}


-(BaseViewController *)findPassViewController
{
    FindPwdViewController *vc = (FindPwdViewController *)[self popReuseObjectForClass:[FindPwdViewController class]];
    if (!vc)
    {
        vc = [[FindPwdViewController alloc]init];
    }
    return vc;
}

-(BaseViewController *)registerViewController
{
    RegisterViewController *vc = (RegisterViewController *)[self popReuseObjectForClass:[RegisterViewController class]];
    if (!vc)
    {
        vc = [[RegisterViewController alloc]init];
    }
    return vc;
}


//进入锁屏的页面
-(BaseViewController *)gesturePasswordController
{
    GesturePasswordController *vc = (GesturePasswordController *)[self popReuseObjectForClass:[GesturePasswordController class]];
    if (!vc) {
        
        vc = [[GesturePasswordController alloc] init];
    }
    return vc;
}
//开通账户
-(BaseViewController *)OpenAccountViewController{
    OpenAccountViewController *vc = (OpenAccountViewController *)[self popReuseObjectForClass:[OpenAccountViewController class]];
    if (!vc) {
        
        vc = [[OpenAccountViewController alloc] init];
    }
    return vc;
}

//投资界面的详情界面
-(BaseViewController *)goodDetaileViewController
{
    GoodDetaileViewController *vc = (GoodDetaileViewController *)[self popReuseObjectForClass:[GoodDetaileViewController class]];
    if (!vc)
    {
        vc = [[GoodDetaileViewController alloc]init];
    }
    return vc;
}

//房贷详情界面
-(BaseViewController *)houseGoodsDetailViewController
{
    HouseGoodsDetailViewController *vc = (HouseGoodsDetailViewController *)[self popReuseObjectForClass:[HouseGoodsDetailViewController class]];
    if (!vc)
    {
        vc = [[HouseGoodsDetailViewController alloc]init];
    }
    return vc;
}
//资质认证界面
-(BaseViewController *)qualificationViewController
{
    QualificationViewController *vc = (QualificationViewController *)[self popReuseObjectForClass:[QualificationViewController class]];
    if (!vc)
    {
        vc = [[QualificationViewController alloc]init];
    }
    return vc;

}


//投标的web界面
-(BaseViewController *)goodDeatileWebViewController
{
    GoodDeatileWebViewController *vc = (GoodDeatileWebViewController *)[self popReuseObjectForClass:[GoodDeatileWebViewController class]];
    if (!vc)
    {
        vc = [[GoodDeatileWebViewController alloc]init];
    }
    return vc;
}



//投资记录
-(BaseViewController *)investRecodersViewController
{
    InvestRecodersViewController *vc = (InvestRecodersViewController *)[self popReuseObjectForClass:[InvestRecodersViewController class]];
    if (!vc)
    {
        vc = [[InvestRecodersViewController alloc]init];
    }
    return vc;
}




//安全中心   SafeManagerViewController
-(BaseViewController *)safeManagerViewController
{
    SafeManagerViewController *vc = (SafeManagerViewController *)[self popReuseObjectForClass:[SafeManagerViewController class]];
    if (!vc)
    {
        vc = [[SafeManagerViewController alloc]init];
    }
    return vc;
}

//修改密码
-(BaseViewController *)accountSafeViewController
{
    AccountSafeViewController *vc = (AccountSafeViewController *)[self popReuseObjectForClass:[AccountSafeViewController class]];
    if (!vc)
    {
        vc = [[AccountSafeViewController alloc]init];
    }
    return vc;
}

//绑定银行卡
-(BaseViewController *)bankCardViewController
{
    BankCardViewController *vc = (BankCardViewController *)[self popReuseObjectForClass:[BankCardViewController class]];
    if (!vc)
    {
        vc = [[BankCardViewController alloc]init];
    }
    return vc;
}

//银行卡列表
-(BaseViewController *)bankListViewController
{
    BankListViewController *vc = (BankListViewController *)[self popReuseObjectForClass:[BankListViewController class]];
    if (!vc)
    {
        vc = [[BankListViewController alloc]init];
    }
    return vc;
}


//手机认证
-(BaseViewController *)mobileCertificateViewController
{
    MobileCertificateViewController *vc = (MobileCertificateViewController *)[self popReuseObjectForClass:[MobileCertificateViewController class]];
    if (!vc)
    {
        vc = [[MobileCertificateViewController alloc]init];
    }
    return vc;
}


//我的投资 MyInvestViewController
-(BaseViewController *)myInvestViewController
{
    MyInvestViewController *vc = (MyInvestViewController *)[self popReuseObjectForClass:[MyInvestViewController class]];
    if (!vc)
    {
        vc = [[MyInvestViewController alloc]init];
    }
    return vc;
}

//我的投资详细界面  MyInvestDetailesViewController
-(BaseViewController *)myInvestDetailesViewController
{
    MyInvestDetailesViewController *vc = (MyInvestDetailesViewController *)[self popReuseObjectForClass:[MyInvestDetailesViewController class]];
    if (!vc)
    {
        vc = [[MyInvestDetailesViewController alloc]init];
    }
    return vc;
}

//还款计划
-(BaseViewController *)repaymentScheduleViewController
{
    RepaymentScheduleViewController *vc = (RepaymentScheduleViewController *)[self popReuseObjectForClass:[RepaymentScheduleViewController class]];
    if (!vc)
    {
        vc = [[RepaymentScheduleViewController alloc]init];
    }
    return vc;
}


//自动投标
-(BaseViewController *)autoTenderViewController
{
    AutoTenderViewController *vc = (AutoTenderViewController *)[self popReuseObjectForClass:[AutoTenderViewController class]];
    if (!vc)
    {
        vc = [[AutoTenderViewController alloc]init];
    }
    return vc;
}
//自动投标web
-(BaseViewController *)autoTenderWebViewController
{
    AutoTenderWebViewController *vc = (AutoTenderWebViewController *)[self popReuseObjectForClass:[AutoTenderWebViewController class]];
    if (!vc)
    {
        vc = [[AutoTenderWebViewController alloc]init];
    }
    return vc;
}

//充值web界面
-(BaseViewController *)topUpWebViewController
{
    TopUpWebViewController *vc = (TopUpWebViewController *)[self popReuseObjectForClass:[TopUpWebViewController class]];
    if (!vc)
    {
        vc = [[TopUpWebViewController alloc]init];
    }
    return vc;
}


//提现web界面

-(BaseViewController *)withDrawWebViewController
{
    WithDrawWebViewController *vc = (WithDrawWebViewController *)[self popReuseObjectForClass:[WithDrawWebViewController class]];
    if (!vc)
    {
        vc = [[WithDrawWebViewController alloc]init];
    }
    return vc;
}

//开户汇付天下
-(BaseViewController *)dredgeHuiFuWebViewController
{
    DredgeHuiFuWebViewController *vc = (DredgeHuiFuWebViewController *)[self popReuseObjectForClass:[DredgeHuiFuWebViewController class]];
    if (!vc)
    {
        vc = [[DredgeHuiFuWebViewController alloc]init];
    }
    return vc;
}

//web界面
-(BaseViewController *)baseWebViewViewController
{
    BaseWebViewViewController *vc = (BaseWebViewViewController *)[self popReuseObjectForClass:[BaseWebViewViewController class]];
    if (!vc)
    {
        vc = [[BaseWebViewViewController alloc]init];
    }
    return vc;
}

//资金记录

-(BaseViewController *)moneyRecordViewController
{
    MoneyRecordViewController *vc = (MoneyRecordViewController *)[self popReuseObjectForClass:[MoneyRecordViewController class]];
    if (!vc)
    {
        vc = [[MoneyRecordViewController alloc]init];
    }
    return vc;
}

//资金记录详情
-(BaseViewController *)moneyRecordDetailViewController
{
    MoneyRecordDetailViewController *vc = (MoneyRecordDetailViewController *)[self popReuseObjectForClass:[MoneyRecordDetailViewController class]];
    if (!vc)
    {
        vc = [[MoneyRecordDetailViewController alloc]init];
    }
    return vc;
}


-(BaseViewController *)companyDyamicViewController
{
    CompanyDyamicViewController *vc = (CompanyDyamicViewController *)[self popReuseObjectForClass:[CompanyDyamicViewController class]];
    if (!vc)
    {
        vc = [[CompanyDyamicViewController alloc]init];
    }
    return vc;
}

//代金券兑换
-(BaseViewController *)voucherexchangeViewController
{
    VoucherexchangeViewController *vc = (VoucherexchangeViewController *)[self popReuseObjectForClass:[VoucherexchangeViewController class]];
    if (!vc)
    {
        vc = [[VoucherexchangeViewController alloc]init];
    }
    return vc;
}
//选择银行
-(BaseViewController *)SelectBankViewController{
    SelectBankViewController *vc = (SelectBankViewController *)[self popReuseObjectForClass:[SelectBankViewController class]];
    if (!vc)
    {
        vc = [[SelectBankViewController alloc]init];
    }
    return vc;

}
//激活账户
-(BaseViewController *)ActiveAccountViewController{
    ActiveAcountViewController *vc = (ActiveAcountViewController *)[self popReuseObjectForClass:[ActiveAcountViewController class]];
    if (!vc)
    {
        vc = [[ActiveAcountViewController alloc]init];
    }
    return vc;
}
//充值
-(BaseViewController *)RechargeViewController{
    RechargeViewController *vc = (RechargeViewController *)[self popReuseObjectForClass:[RechargeViewController class]];
    if (!vc)
    {
        vc = [[RechargeViewController alloc]init];
    }
    return vc;

}
//新增webview
-(BaseViewController *)AddWebViewController{
    AddWebViewController *vc = (AddWebViewController *)[self popReuseObjectForClass:[AddWebViewController class]];
    if (!vc)
    {
        vc = [[AddWebViewController alloc]init];
    }
    return vc;
}
//testweb
-(BaseViewController *)testWebViewController{
    TestWebViewController *vc = (TestWebViewController *)[self popReuseObjectForClass:[TestWebViewController class]];
    if (!vc)
    {
        vc = [[TestWebViewController alloc]init];
    }
    return vc;

}
@end
