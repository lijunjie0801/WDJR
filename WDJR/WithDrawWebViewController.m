//
//  WithDrawWebViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/24.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "WithDrawWebViewController.h"
#import "WebViewJS.h"

@interface WithDrawWebViewController ()<WebViewJSDelegate>

@property(nonatomic, strong) MBProgressHUD *weakProgressHUD;

@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) NSURL *url;
@property(nonatomic, strong) WebViewJS *WebviewJs;

@property(nonatomic, strong) NSString *BgRetUrl;
@property(nonatomic, strong) NSString *CharSet;
@property(nonatomic, strong) NSString *ChkValue;
@property(nonatomic, strong) NSString *CmdId;
@property(nonatomic, strong) NSString *MerCustId;
@property(nonatomic, strong) NSString *MerPriv;
@property(nonatomic, strong) NSString *OpenAcctId;
@property(nonatomic, strong) NSString *OrdId;
@property(nonatomic, strong) NSString *PageType;
@property(nonatomic, strong) NSString *Remark;
@property(nonatomic, strong) NSString *ReqExt;
@property(nonatomic, strong) NSString *RetUrl;
@property(nonatomic, strong) NSString *ServFee;
@property(nonatomic, strong) NSString *ServFeeAcctId;
@property(nonatomic, strong) NSString *TransAmt;
@property(nonatomic, strong) NSString *UsrCustId;
@property(nonatomic, strong) NSString *Version,*body;
@end

@implementation WithDrawWebViewController

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
    
    NSString *body =_body; //[NSString stringWithFormat: @"BgRetUrl=%@&CharSet=%@&ChkValue=%@&CmdId=%@&MerCustId=%@&MerPriv=%@&OpenAcctId=%@&OrdId=%@&PageType=%@&Remark=%@&ReqExt=%@&RetUrl=%@&ServFee=%@&ServFeeAcctId=%@&TransAmt=%@&UsrCustId=%@&Version=%@",_BgRetUrl,_CharSet,_ChkValue,_CmdId,_MerCustId,_MerPriv,_OpenAcctId,_OrdId,_PageType,_Remark,_ReqExt,_RetUrl,_ServFee,_ServFeeAcctId,_TransAmt,_UsrCustId,_Version];
    
    
    
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
