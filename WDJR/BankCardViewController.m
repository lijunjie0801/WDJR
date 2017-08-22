//
//  BankCardViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BankCardViewController.h"
#import "WebViewJS.h"

@interface BankCardViewController ()<WebViewJSDelegate>

@property(nonatomic, strong) MBProgressHUD *weakProgressHUD;

@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) NSURL *url;

@property(nonatomic, strong) WebViewJS *WebviewJs;
@property(nonatomic, strong) NSString *BgRetUrl;
@property(nonatomic, strong) NSString *ChkValue;
@property(nonatomic, strong) NSString *CmdId;
@property(nonatomic, strong) NSString *MerCustId;
@property(nonatomic, strong) NSString *MerPriv;
@property(nonatomic, strong) NSString *PageType;
@property(nonatomic, strong) NSString *UsrCustId;
@property(nonatomic, strong) NSString *Version,*body;

@end

@implementation BankCardViewController

-(void)setIntentDic:(NSDictionary *)intentDic
{
    
    
    _intentDic     = intentDic;
    _url           = [NSURL URLWithString:_intentDic[@"url"]];
    
    _body=_intentDic[@"body"];
//    _BgRetUrl       = _intentDic[@"BgRetUrl"];
//    _ChkValue       = _intentDic[@"ChkValue"];
//    _CmdId       = _intentDic[@"CmdId"];
//    _MerCustId       = _intentDic[@"MerCustId"];
//    _MerPriv       = _intentDic[@"MerPriv"];
//    _PageType       = _intentDic[@"PageType"];
//    _UsrCustId       = _intentDic[@"UsrCustId"];
//    _Version       = _intentDic[@"Version"];
    
    
    
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
    
    _WebviewJs = [[WebViewJS alloc] init];
    _WebviewJs.delegate = self;
    
    
}

-(void)createRequest
{
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:_url cachePolicy:request.cachePolicy timeoutInterval:request.timeoutInterval];
    [req setHTTPMethod:@"POST"];
    
  
    NSString *body =_body; //[NSString stringWithFormat: @"BgRetUrl=%@&ChkValue=%@&CmdId=%@&MerCustId=%@&MerPriv=%@&PageType=%@&UsrCustId=%@&Version=%@",_BgRetUrl,_ChkValue,_CmdId,_MerCustId,_MerPriv,_PageType,_UsrCustId,_Version];
    
    
    
    [req setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    
    [self.webView loadRequest:req];
    
}


#pragma mark-----WebViewDelegate-----

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


#pragma mark  --------WebviewJSDelegate---------

-(void)redirectJS:(NSString *)type
{
    NSLog(@"返回的内容是=%@",type);
    [_svc popViewController];
    [_svc showMessage:type];
    
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
