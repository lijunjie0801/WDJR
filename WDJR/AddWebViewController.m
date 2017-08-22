//
//  AddWebViewController.m
//  WDJR
//
//  Created by lijunjie on 2017/8/3.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import "AddWebViewController.h"
#import "WebViewJS.h"
@interface AddWebViewController ()<UIWebViewDelegate,WebViewJSDelegate>
@property(nonatomic, strong) MBProgressHUD *weakProgressHUD;
@property(nonatomic, strong) WebViewJS *WebviewJs;
@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) NSString *url;
@end

@implementation AddWebViewController
-(void)setIntentDic:(NSDictionary *)intentDic{
    self.url=intentDic[@"url"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _webView.scalesPageToFit = NO;
    _webView.dataDetectorTypes = UIDataDetectorTypeNone;
    [self.view addSubview:_webView];
  //  [self getdata];

    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    self.WebviewJs = [[WebViewJS alloc] init];
    self.WebviewJs.delegate = self;

}
-(void)redirectJS:(NSString *)type{
    NSLog(@"返回的内容是=%@",type);
    [_svc popViewController];
    [_svc showMessage:type];
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
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
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //调用js
    context[@"pnr"]=self.WebviewJs;
   
    
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_weakProgressHUD hide:YES];
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
