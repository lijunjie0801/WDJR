//
//  DredgeHuiFuWebViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/12/10.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "DredgeHuiFuWebViewController.h"
#import "WebViewJS.h"

@interface DredgeHuiFuWebViewController ()<WebViewJSDelegate>


@property(nonatomic, strong) MBProgressHUD *weakProgressHUD;

@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) NSURL *url;

@property(nonatomic, strong) WebViewJS *WebviewJs;

@property(nonatomic, strong) NSString *Version;
@property(nonatomic, strong) NSString *UsrName;
@property(nonatomic, strong) NSString *UsrMp;
@property(nonatomic, strong) NSString *UsrId;
@property(nonatomic, strong) NSString *UsrEmail;
@property(nonatomic, strong) NSString *RetUrl;
@property(nonatomic, strong) NSString *PageType;
@property(nonatomic, strong) NSString *MerPriv;
@property(nonatomic, strong) NSString *MerCustId;
@property(nonatomic, strong) NSString *IdType;
@property(nonatomic, strong) NSString *IdNo;
@property(nonatomic, strong) NSString *CmdId;
@property(nonatomic, strong) NSString *ChkValue;
@property(nonatomic, strong) NSString *CharSet;
@property(nonatomic, strong) NSString *BgRetUrl;

@property(nonatomic, strong) NSString *AreaId;
@property(nonatomic, strong) NSString *BankId;
@property(nonatomic, strong) NSString *CardId;
@property(nonatomic, strong) NSString *DepoAcctType;
@property(nonatomic, strong) NSString *ProvId;
@property(nonatomic, strong) NSString *SmsCode;
@property(nonatomic, strong) NSString *SmsSeq;

@end

@implementation DredgeHuiFuWebViewController

-(void)setIntentDic:(NSDictionary *)intentDic
{
    _intentDic     = intentDic;
    _url           = [NSURL URLWithString:_intentDic[@"url"]];
    _Version       = _intentDic[@"Version"];
    _MerPriv       = _intentDic[@"MerPriv"];
    _IdNo       = _intentDic[@"IdNo"];
    _IdType       = _intentDic[@"IdType"];
    _RetUrl       = _intentDic[@"RetUrl"];
    _CharSet       = _intentDic[@"CharSet"];
    _PageType       = _intentDic[@"PageType"];
    _UsrName       = _intentDic[@"UsrName"];
    _UsrMp       = _intentDic[@"UsrMp"];
    _MerCustId       = _intentDic[@"MerCustId"];
    _UsrId       = _intentDic[@"UsrId"];
    _UsrEmail       = _intentDic[@"UsrEmail"];
    _CmdId       = _intentDic[@"CmdId"];
    _ChkValue       = _intentDic[@"ChkValue"];
    _BgRetUrl       = _intentDic[@"BgRetUrl"];
    
    _AreaId=_intentDic[@"AreaId"];
     _BankId=_intentDic[@"BankId"];
     _CardId=_intentDic[@"CardId"];
     _DepoAcctType=_intentDic[@"DepoAcctType"];
     _ProvId=_intentDic[@"ProvId"];
     _SmsCode=_intentDic[@"SmsCode"];
     _SmsSeq=_intentDic[@"SmsSeq"];
    
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
   // body = [NSString stringWithFormat: @"BgRetUrl=%@&CharSet=%@&ChkValue=%@&CmdId=%@&IdNo=%@&IdType=%@&MerCustId=%@&MerPriv=%@&PageType=%@&RetUrl=%@&UsrEmail=%@&UsrId=%@&UsrMp=%@&UsrName=%@&Version=%@",_BgRetUrl,_CharSet,_ChkValue,_CmdId,_IdNo,_IdType,_MerCustId,@"",_PageType,_RetUrl,_UsrEmail,_UsrId,_UsrMp,_UsrName,_Version];
    body = [NSString stringWithFormat: @"BgRetUrl=%@&CharSet=%@&ChkValue=%@&CmdId=%@&IdNo=%@&IdType=%@&MerCustId=%@&PageType=%@&RetUrl=%@&UsrEmail=%@&UsrId=%@&UsrMp=%@&UsrName=%@&Version=%@&AreaId=%@&BankId=%@&CardId=%@&DepoAcctType=%@&ProvId=%@&SmsCode=%@&SmsSeq=%@",_BgRetUrl,_CharSet,_ChkValue,_CmdId,_IdNo,_IdType,_MerCustId,_PageType,_RetUrl,_UsrEmail,_UsrId,_UsrMp,_UsrName,_Version,_AreaId,_BankId,_CardId,_DepoAcctType,_ProvId,_SmsCode,_SmsSeq];
    NSString *s=@"http://mertest.chinapnr.com/muser/publicRequests?Version=40&CmdId=UserRegister&MerCustId=6000060007135219&UsrId=test_zl01&UsrName=%E6%9D%8E%E4%BF%8A&IdType=00&IdNo=340123199110130850&UsrMp=17602196563&UsrEmail=&DepoAcctType=01&CardId=6225801239854833&BankId=CMB&ProvId=0034&AreaId=3401&SmsCode=666666&SmsSeq=AAAAAAAA&PageType=1&CharSet=UTF-8&RetUrl=https%3A%2F%2Fdep.wdjr999.com%2Fpnr%2Fbank%2Fguizhou%2Fregister%2Fjump&BgRetUrl=https%3A%2F%2Fdep.wdjr999.com%2Fpnr%2Fbank%2Fguizhou%2Fregister%2Fnotify&ChkValue=88CCB6EFF5F528FA6E764A3D67506128AFBDC069809776136FB2323EB587D7F459F14B797CA99B4A0C694AE0D2FD3E81719681E9829DEA01CB3B9EB7382F72191715DBF6518CC17136B3487F6EF439394E98708753428FCC1431101A3F2B300EDB1D06AC390AF03B08B5DFE6FDA2711CB61CD51838A70C4E8997175F31CA34F4";
    NSURL *url=[NSURL URLWithString:s];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
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
