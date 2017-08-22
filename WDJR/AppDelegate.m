//
//  AppDelegate.m
//  WDJR
//
//  Created by fyaex001 on 2016/10/25.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "AppDelegate.h"
#import "SwitchViewController.h"
#import "RootViewController.h"
#import "AppNavigationController.h"
#import "LeftViewController.h"
#import "IQKeyboardManager.h"

@implementation NSURLRequest(DataController)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}
@end

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
     [NSThread sleepForTimeInterval:2.0];
    
    //把状态栏的中的颜色改为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    self.window = _window;
    
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    
    self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:[[SwitchViewController sharedSVC] rootNaviController]];
    _window.rootViewController = self.LeftSlideVC;
    
    
    // 初始化键盘管理控制器
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES; //控制整个功能是否启动
    manager.shouldResignOnTouchOutside = YES;//控制点击背景是否收起键盘
    manager.shouldToolbarUsesTextFieldTintColor = YES;//控制键盘上的工具条文字颜色是否用户自定义。
    manager.enableAutoToolbar = YES;//控制是否显示键盘上的工具条。
    
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginAction:) name:@"NeedsLogin" object:nil];

    return YES;
}


- (void)loginAction:(NSNotification *)notification
{
    SwitchViewController *svc = [SwitchViewController sharedSVC];
    [svc performSelector:@selector(presentViewController:) withObject:svc.loginViewController afterDelay:0.25];
   
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}



//当程序从后台重新回到前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    
    if ([AppDataManager defaultManager].hasLogin) {
        
        if ([AppDataManager defaultManager].isOff && ![AppDataManager defaultManager].isShowGestures) {
            SwitchViewController *_svc = [SwitchViewController sharedSVC];
            [_svc presentViewController:_svc.gesturePasswordController withObjects:@{@"type":@(1)}];
            
        }
    }
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


@end
