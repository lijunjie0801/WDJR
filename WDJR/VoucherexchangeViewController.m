//
//  VoucherexchangeViewController.m
//  WDJR
//
//  Created by zlkj on 2017/3/7.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import "VoucherexchangeViewController.h"

@interface VoucherexchangeViewController ()

@property(nonatomic, strong) UILabel *voucherNum;//代金券余额
@property(nonatomic, strong) UILabel *ShowvoucherNum;//本次可兑换金额

@property(nonatomic, strong) UITextField *moneyField;

@end

@implementation VoucherexchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"代金券兑换";
    self.view.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
    
    [self createSubviews];
}

-(void)createSubviews
{

    UILabel *yuelbl = [[UILabel alloc] init];
    yuelbl.text = @"代金券余额";
    yuelbl.font = shisiFont;
    yuelbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
    yuelbl.textAlignment = NSTextAlignmentCenter;
    yuelbl.frame = CGRectMake(0, 10, WIDTH/2, 25);
    [self.view addSubview:yuelbl];
    
    UILabel *voucherlbl = [[UILabel alloc] init];
    voucherlbl.text = @"今日还可兑换";
    voucherlbl.font = shisiFont;
    voucherlbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
    voucherlbl.textAlignment = NSTextAlignmentCenter;
    voucherlbl.frame = CGRectMake(WIDTH/2, 10, WIDTH/2, 25);
    [self.view addSubview:voucherlbl];
    
    _voucherNum = [[UILabel alloc] init];
    _voucherNum.text = @"0.00元";
    _voucherNum.textAlignment = NSTextAlignmentCenter;
    _voucherNum.textColor = [AppAppearance sharedAppearance].titleTextColor;
    _voucherNum.font = shiliuFont;
    _voucherNum.frame = CGRectMake(0, CGRectGetMaxY(yuelbl.frame), WIDTH/2, 25);
    [self.view addSubview:_voucherNum];
    
    

    _ShowvoucherNum = [[UILabel alloc] init];
    _ShowvoucherNum.text = @"8次";
    _ShowvoucherNum.textAlignment = NSTextAlignmentCenter;
    _ShowvoucherNum.textColor = [AppAppearance sharedAppearance].titleTextColor;
    _ShowvoucherNum.font = shiliuFont;
    _ShowvoucherNum.frame = CGRectMake(WIDTH/2, CGRectGetMaxY(voucherlbl.frame), WIDTH/2, 25);
    [self.view addSubview:_ShowvoucherNum];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(WIDTH/2-0.5, 10, 1, 50)];
    line1.backgroundColor = [AppAppearance sharedAppearance].cellLineColor;
    [self.view addSubview:line1];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_ShowvoucherNum.frame)+5, WIDTH, 3)];
    line.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    [self.view addSubview:line];
    
    
    
    UILabel *exchangelbl = [[UILabel alloc] init];
    exchangelbl.text = @"兑换金额:";
    exchangelbl.font = shisiFont;
    exchangelbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
    exchangelbl.frame = CGRectMake(15, CGRectGetMaxY(line.frame)+10, WIDTH/2, 25);
    [self.view addSubview:exchangelbl];
    
    _moneyField = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(exchangelbl.frame)+10, WIDTH-30, 35)];
    _moneyField.font = shiliuFont;
    _moneyField.borderStyle = UITextBorderStyleRoundedRect;
    _moneyField.layer.borderColor = [[AppAppearance sharedAppearance].cellLineColor CGColor];
    _moneyField.layer.masksToBounds = YES;
    _moneyField.layer.cornerRadius = 5;
    _moneyField.placeholder = @"元";
    _moneyField.textAlignment = NSTextAlignmentCenter;
    _moneyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_moneyField];
    
    
    UIButton *submitBtn = [[UIButton alloc] init];
    
    [submitBtn setBackgroundColor:[AppAppearance sharedAppearance].yellowColor];
    [submitBtn setTitle:@"确认" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    submitBtn.layer.cornerRadius = 10;
    submitBtn.layer.masksToBounds = YES;
    
    submitBtn.frame = CGRectMake(15, CGRectGetMaxY(_moneyField.frame)+10, self.view.frame.size.width-30, 40);
    [submitBtn addTarget:self action:@selector(submitBtnButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
    
    
    
    UILabel *exchangeRulelbl = [[UILabel alloc] init];
    exchangeRulelbl.text = @"兑换规则:";
    exchangeRulelbl.font = shisiFont;
    exchangeRulelbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
    exchangeRulelbl.frame = CGRectMake(15, CGRectGetMaxY(submitBtn.frame)+20, WIDTH/2, 25);
    [self.view addSubview:exchangeRulelbl];
    
    UILabel *exchangeRulelbl1 = [[UILabel alloc] init];
    exchangeRulelbl1.text = @"1、代金券可兑换成可用余额,也可投资使用(优先);";
    exchangeRulelbl1.font = shierFont;
    exchangeRulelbl1.textColor = [AppAppearance sharedAppearance].title2TextColor;
    exchangeRulelbl1.frame = CGRectMake(15, CGRectGetMaxY(exchangeRulelbl.frame)+5, WIDTH-15, 25);
    [self.view addSubview:exchangeRulelbl1];
    
    UILabel *exchangeRulelbl2 = [[UILabel alloc] init];
    exchangeRulelbl2.text = @"2、单次最多可兑换200元,至少10元;";
    exchangeRulelbl2.font = shierFont;
    exchangeRulelbl2.textColor = [AppAppearance sharedAppearance].mainColor;
    exchangeRulelbl2.frame = CGRectMake(15, CGRectGetMaxY(exchangeRulelbl1.frame)+5, WIDTH-15, 25);
    [self.view addSubview:exchangeRulelbl2];
    
    UILabel *exchangeRulelbl3 = [[UILabel alloc] init];
    exchangeRulelbl3.text = @"3、每日最多可兑换3次;";
    exchangeRulelbl3.font = shierFont;
    exchangeRulelbl3.textColor = [AppAppearance sharedAppearance].mainColor;
    exchangeRulelbl3.frame = CGRectMake(15, CGRectGetMaxY(exchangeRulelbl2.frame)+5, WIDTH-15, 25);
    [self.view addSubview:exchangeRulelbl3];
    
    
    
    [self requestData];
    
}

-(void)requestData
{
    
    [_svc  showLoadingWithMessage:@"加载中..." inView:[UIApplication sharedApplication].keyWindow ];
    [RequestManager getRequestWithURLPath:KURLShowVoucher withParamer:nil completionHandler:^(id responseObject) {
        
        NSLog(@"=======%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject[@"data"];
        if ([responseObject[@"result"] intValue] ==1) {
            
            dic = dic[@"info"];
            _ShowvoucherNum.text = [NSString stringWithFormat:@"%@次",dic[@"voucher_can_exchange_times"]];
            
            _voucherNum.text = [NSString stringWithFormat:@"%@元",dic[@"voucher"]];
            
        }else{
        
            [_svc showMessage:dic[@"message"]];
        }
        
        [_svc hideLoadingView];
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
        
    }];
}


-(void)submitBtnButtonAction
{
    if (self.moneyField.text.length == 0) {
        
        [_svc showMessage:@"请输入兑换金额"];
        return;
    }
    
    [RequestManager postRequestWithURLPath:KURLVoucherExchange withParamer:@{@"amount":self.moneyField.text} completionHandler:^(id responseObject) {
        
        NSDictionary *dic = responseObject[@"data"];
        if ([responseObject[@"result"] intValue] ==1) {
            
            
            [self requestData];
            
        }
        
        [_svc showMessage:dic[@"message"]];
        
        self.moneyField.text= @"";
        [_svc hideLoadingView];
  
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
        
    }];
    
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
