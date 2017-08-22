//
//  GoodDeatileWebViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/23.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "GoodDeatileWebViewController.h"
#import "WebViewJS.h"

@interface GoodDeatileWebViewController ()<WebViewJSDelegate,NSURLConnectionDelegate>{
    
}

@property(nonatomic, strong) MBProgressHUD *weakProgressHUD;

@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) NSURL *url;
@property(nonatomic, strong) WebViewJS *WebviewJs;
@property(nonatomic,assign,getter =isAuthed)BOOL authed;
@property(nonatomic, strong) NSString *Version;
@property(nonatomic, strong) NSString *UsrCustId;
@property(nonatomic, strong) NSString *TransAmt;
@property(nonatomic, strong) NSString *RetUrl;
@property(nonatomic, strong) NSString *ReqExt;
@property(nonatomic, strong) NSString *PageType;
@property(nonatomic, strong) NSString *OrdId;
@property(nonatomic, strong) NSString *OrdDate;
@property(nonatomic, strong) NSString *MerPriv;
@property(nonatomic, strong) NSString *MerCustId;
@property(nonatomic, strong) NSString *MaxTenderRate;
@property(nonatomic, strong) NSString *IsFreeze;
@property(nonatomic, strong) NSString *FreezeOrdId;
@property(nonatomic, strong) NSString *CmdId;
@property(nonatomic, strong) NSString *ChkValue;
@property(nonatomic, strong) NSString *BorrowerDetails;
@property(nonatomic, strong) NSString *BgRetUrl,*body;


@end

@implementation GoodDeatileWebViewController

-(void)setIntentDic:(NSDictionary *)intentDic
{
    _intentDic     = intentDic;
    _url           = [NSURL URLWithString:_intentDic[@"url"]];
    _body=_intentDic[@"body"];
    
  
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
    NSString *body = @"";
    body=_body;
    
  [req setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    
    [self.webView loadRequest:req];
    
}






#pragma mark-----WebViewDelegate-----

//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    return YES;
//}

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
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString* scheme = [[request URL] scheme];
    //判断是不是https
    if ([scheme isEqualToString:@"https"])
    {
        if (self.authed)
        {
            return YES;
        }
        NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:request.URL] delegate:self];
        [conn start];
        [webView stopLoading];
        return NO;
    }
    return YES;
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge previousFailureCount]== 0)
    {
        self.authed = YES;
        //NSURLCredential 这个类是表示身份验证凭据不可变对象。凭证的实际类型声明的类的构造函数来确定。回调中会收到一个challenge
        NSURLCredential* cre = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        [challenge.sender useCredential:cre forAuthenticationChallenge:challenge];
    }
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.authed = YES;
    //webview 重新加载请求。
    [self.webView loadRequest:[NSURLRequest requestWithURL:connection.currentRequest.URL]];
    [connection cancel];
}






@end
