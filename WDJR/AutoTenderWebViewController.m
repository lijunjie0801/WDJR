//
//  AutoTenderWebViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/23.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "AutoTenderWebViewController.h"
#import "WebViewJS.h"

@interface AutoTenderWebViewController ()<WebViewJSDelegate>


@property(nonatomic, strong) MBProgressHUD *weakProgressHUD;

@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) NSURL *url;

@property(nonatomic, strong) WebViewJS *WebviewJs;

@property(nonatomic, strong) NSString *Version;
@property(nonatomic, strong) NSString *UsrCustId;
@property(nonatomic, strong) NSString *RetUrl;
@property(nonatomic, strong) NSString *PageType;
@property(nonatomic, strong) NSString *MerPriv;
@property(nonatomic, strong) NSString *MerCustId;
@property(nonatomic, strong) NSString *CmdId;
@property(nonatomic, strong) NSString *ChkValue;
@property(nonatomic, strong) NSString *TenderPlanType;
@property(nonatomic, strong) NSString *TransAmt;

@property(nonatomic, strong) NSString *type,*body;

@end

@implementation AutoTenderWebViewController

-(void)setIntentDic:(NSDictionary *)intentDic
{
    _intentDic     = intentDic;
   // _url           = [NSURL URLWithString:_intentDic[@"url"]];
    _url           = [NSURL URLWithString:_intentDic[@"url"]];
    
    _body=_intentDic[@"body"];
//    _Version       = _intentDic[@"Version"];
//    _UsrCustId     = _intentDic[@"UsrCustId"];
//    _RetUrl        = _intentDic[@"RetUrl"];
//    _PageType = _intentDic[@"PageType"];
//    _MerPriv = _intentDic[@"MerPriv"];
//    _MerCustId = _intentDic[@"MerCustId"];
//    _CmdId = _intentDic[@"CmdId"];
//    _ChkValue = _intentDic[@"ChkValue"];
//    _TenderPlanType = _intentDic[@"TenderPlanType"];
//    _TransAmt = _intentDic[@"TransAmt"];
    
    _type = _intentDic[@"type"];
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
    NSString *body = _body;
//    if ([_type isEqualToString:@"10"]) {
//        
//        body= [NSString stringWithFormat: @"Version=%@&UsrCustId=%@&RetUrl=%@&PageType=%@&MerPriv=%@&MerCustId=%@&CmdId=%@&ChkValue=%@&TransAmt=%@&TenderPlanType=%@",_Version,_UsrCustId,_RetUrl,_PageType,_MerPriv,_MerCustId,_CmdId,_ChkValue,_TransAmt,_TenderPlanType];
//    }else if([_type isEqualToString:@"8"]){
//        
//        body= [NSString stringWithFormat: @"Version=%@&UsrCustId=%@&RetUrl=%@&PageType=%@&MerPriv=%@&MerCustId=%@&CmdId=%@&ChkValue=%@",_Version,_UsrCustId,_RetUrl,_PageType,_MerPriv,_MerCustId,_CmdId,_ChkValue];
//        
//    }
    
    
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
