//
//  SwitchViewController.h
//
//
//  Created by fyaex001 on 16/5/4.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseViewController;
@class AppNavigationController;

@interface SwitchViewController : NSObject

+(instancetype)sharedSVC;

@property(nonatomic ,readonly)AppNavigationController *rootNaviController;

-(UINavigationController *)topNavigationController;


/**
 *  展示信息到window
 */
-(void)showMessage:(NSString *)message;
-(void)showMessage:(NSString *)message duration:(NSTimeInterval)time;
-(void)setHudMessage:(NSString*)message;

-(void)showLoadingWithMessage:(NSString*)message;
-(void)hideHud;
-(void)hideHudAfterDelay:(NSTimeInterval)delay;

-(void)showLoadingWithMessage:(NSString *)message inView:(UIView *)view;
-(void)hideLoadingView;

-(void)pushViewController:(BaseViewController*)vc;
-(void)pushViewController:(BaseViewController*)vc withObjects:(NSDictionary*)intentDic;
-(BaseViewController*)popViewController;
-(void)popToViewController:(UIViewController *)vc;

-(void)presentViewController:(BaseViewController*)vc;

//跳转页面
-(void)presentViewController:(BaseViewController*)vc withObjects:(NSDictionary*)intentDic;

-(void)dismissTopViewControllerCompletion:(void (^)(void))completion;




-(BaseViewController *)findPassViewController;
-(BaseViewController *)loginViewController;
-(BaseViewController *)registerViewController;

-(BaseViewController *)gesturePasswordController;

-(BaseViewController *)goodDetaileViewController;
//房贷详情界面
-(BaseViewController *)houseGoodsDetailViewController;
//资质认证
-(BaseViewController *)qualificationViewController;

//投资记录
-(BaseViewController *)investRecodersViewController;

//我的投资
-(BaseViewController *)myInvestViewController;

//投资详情界面
-(BaseViewController *)myInvestDetailesViewController;

//还款计划
-(BaseViewController *)repaymentScheduleViewController;

//去投资的web界面
-(BaseViewController *)goodDeatileWebViewController;


//安全中心
-(BaseViewController *)safeManagerViewController;

//修改密码
-(BaseViewController *)accountSafeViewController;

//绑定银行卡
-(BaseViewController *)bankCardViewController;

//发送验证码
-(BaseViewController *)mobileCertificateViewController;

//充值web界面
-(BaseViewController *)topUpWebViewController;

//提现wev界面
-(BaseViewController *)withDrawWebViewController;

//自动投标
-(BaseViewController *)autoTenderViewController;
//自动投标web
-(BaseViewController *)autoTenderWebViewController;

//资金记录
-(BaseViewController *)moneyRecordViewController;

//资金记录详细情况
-(BaseViewController *)moneyRecordDetailViewController;

//开户
-(BaseViewController *)dredgeHuiFuWebViewController;

//银行卡列表
-(BaseViewController *)bankListViewController;


-(BaseViewController *)baseWebViewViewController;


//-(BaseViewController *)homeViewController;
//
//-(BaseViewController *)baseWebViewViewController;
//
//
//
//-(BaseViewController *)shareViewController;
-(BaseViewController *)companyDyamicViewController;


//代金券兑换
-(BaseViewController *)voucherexchangeViewController;

//开通账户
-(BaseViewController *)OpenAccountViewController;

//激活账户
-(BaseViewController *)ActiveAccountViewController;

//选择银行
-(BaseViewController *)SelectBankViewController;

//充值
-(BaseViewController *)RechargeViewController;

//新增webview
-(BaseViewController *)AddWebViewController;
////加密
//-(NSString *)createWebViewSign;
//testweb
-(BaseViewController *)testWebViewController;


@end
