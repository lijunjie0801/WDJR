//
//  AboutUsViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/2.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@property(nonatomic, strong) UIView         *headerView;

@property(nonatomic, strong) MBProgressHUD *weakProgressHUD;

@property(nonatomic, strong) UIWebView *webView;

@end

@implementation AboutUsViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"woyun" image:[UIImage imageNamed:@"foot-icon4"] tag:1];
        //self.tabBarItem.selectedImage=[UIImage imageNamed:@"shouye_sel"];
        self.title = @"关于我们";
        self.tabBarItem.title = @"关于我们";
         self.tabBarItem.imageInsets = UIEdgeInsetsMake(-3,0, 3, 0);
        //调整tabbaritem中文字的位置
        self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _webView.scalesPageToFit = NO;
    _webView.dataDetectorTypes = UIDataDetectorTypeNone;
    
    
    
    [self.view addSubview:_webView];
    
    [self createRequest];
    
    
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

    
    
   
}



-(void)createRequest
{
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[URLManager requestURLGenetatedWithURL:KURLAboutUs]]];
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[URLManager requestURLGenetatedWithURL:KURLAboutUs]] cachePolicy:request.cachePolicy timeoutInterval:request.timeoutInterval];
    [req setHTTPMethod:@"GET"];
 
    
    [self.webView loadRequest:req];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}



#pragma mark-----WebViewDelegate-----

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = [request URL].absoluteString;
    
    //判断是否单击
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        NSLog(@"url=%@",urlString);
        [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":urlString}];
        
        
        return NO;
    }
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    _weakProgressHUD = [MessageTool showProcessMessage:@"加载中..." view:self.view];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_weakProgressHUD hide:YES];
    
    // 禁止了弹出复制、粘贴功能
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    
    //获取网页的标题
   // self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_weakProgressHUD hide:YES];
}





-(BOOL)shouldShowBackItem
{
    return NO;
}

-(BOOL)shouldShowRefresh
{
    return NO;
}

-(BOOL)shouldShowGetMore
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
