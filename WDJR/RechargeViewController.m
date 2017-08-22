//
//  RechargeViewController.m
//  WDJR
//
//  Created by lijunjie on 2017/8/4.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import "RechargeViewController.h"

@interface RechargeViewController ()
@property(nonatomic,strong)NSString *bankicon,*bankName,*cardId,*realName,*customId,*mobile,*sms_seq;
@property(nonatomic,strong)UITextField *moneytf,*vertf,*mobiletf;
@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title=@"充值";
    [self getData];
}
-(void)getData{
    [RequestManager getRequestWithURLPath:KURLUserPnr withParamer:nil completionHandler:^(id responseObject) {
        
        NSLog(@"resp:%@",responseObject);
        NSDictionary *bankdic=(NSDictionary *)responseObject;
        NSDictionary *dic=bankdic[@"data"][@"info"];
        _bankicon=dic[@"bank_account"][@"bank_ico"];
        _bankName=dic[@"bank_account"][@"bank_name"];
        _cardId=dic[@"bank_account"][@"card_id"];
        _realName=dic[@"bank_account"][@"real_name"];
        _mobile=dic[@"mobile"];
        [self setUI];

    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        
    }];

}
-(void)setUI{
    self.view.backgroundColor=[UIColor whiteColor];
    UIView *topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH/1.8)];
    topview.backgroundColor=[AppAppearance sharedAppearance].mainColor;
    [self.view addSubview:topview];



    
    UIImageView *imagewhit=[[UIImageView alloc]init];
    imagewhit.center=CGPointMake(WIDTH/2, WIDTH/1.8/2+30);
    imagewhit.bounds=(CGRect){
        CGPointZero,CGSizeMake(WIDTH-40, WIDTH/1.8-30)
    };
    imagewhit.backgroundColor=[UIColor whiteColor];
    imagewhit.clipsToBounds=YES;
    imagewhit.layer.cornerRadius=10;
    [topview addSubview:imagewhit];
    
    UIImageView *bankIconview=[[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 115, 35)];
    [bankIconview sd_setImageWithURL:[NSURL URLWithString:_bankicon]];
    [imagewhit addSubview:bankIconview];
    

    
    UILabel *cardLab=[[UILabel alloc]initWithFrame:CGRectMake(30, 90, WIDTH-100, 50)];
    cardLab.textAlignment=NSTextAlignmentCenter;
    cardLab.font=[UIFont boldSystemFontOfSize:30];
    cardLab.text=_cardId;
    [imagewhit addSubview:cardLab];
 
    
    
    UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, WIDTH/1.8, WIDTH, HEIGHT-WIDTH/1.8)];
    bottomView.backgroundColor=[AppAppearance sharedAppearance].pageBackgroundColor;
    [self.view addSubview:bottomView];
    
    UIView *boardView=[[UIView alloc]initWithFrame:CGRectMake(10, 20, WIDTH-20, 180)];
    boardView.backgroundColor=[UIColor whiteColor];
    [bottomView addSubview:boardView];
    
    NSArray *iconNames=@[@"coin",@"mobile_ph",@"email"];
    for (int i=0; i<3; i++) {
         UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake(20, 20+60*i, 20, 20)];
        icon.image=[UIImage imageNamed:iconNames[i]];
        [boardView addSubview:icon];
        
        UITextField *tf=[[UITextField alloc]initWithFrame:CGRectMake(55, 60*i, WIDTH-75, 60)];
        [boardView addSubview:tf];
        if (i==0) {
            tf.placeholder=@"请输入充值金额";
            _moneytf=tf;
            tf.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
        }else if (i==1){
            _mobiletf=tf;
            tf.text=_mobile;
            tf.userInteractionEnabled=NO;
        }else if (i==2){
            _vertf=tf;
            tf.placeholder=@"请输入验证码";
            tf.keyboardType=UIKeyboardTypeNumbersAndPunctuation;

        }
        if (i!=0) {
            UIView *sepview=[[UIView alloc]initWithFrame:CGRectMake(20, 59*i, WIDTH-40, 1)];
            sepview.backgroundColor=[AppAppearance sharedAppearance].pageBackgroundColor;
            [boardView addSubview:sepview];
        }
    }
    UIButton *sendVerBtn=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-20-150+20, 120, 120, 60)];
    [sendVerBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    sendVerBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [sendVerBtn addTarget:self action:@selector(sendeVer:) forControlEvents:UIControlEventTouchUpInside];
    [sendVerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [boardView addSubview:sendVerBtn];

    UIButton *rechargeBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 230, WIDTH-20, 40)];
    rechargeBtn.clipsToBounds=YES;
    rechargeBtn.layer.cornerRadius=7;
    [rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
     [rechargeBtn addTarget:self action:@selector(recharge) forControlEvents:UIControlEventTouchUpInside];
    [rechargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rechargeBtn.backgroundColor=[AppAppearance sharedAppearance].mainColor;
    [bottomView addSubview:rechargeBtn];

}
-(void)recharge{
    if (_moneytf.text.length == 0) {
        [MessageTool showMessage:@"充值金额不能为空" isError:YES];
        return;
    }else if (_vertf.text.length==0){
        [MessageTool showMessage:@"验证码不能为空" isError:YES];
        return;
    }else if ([_moneytf.text integerValue]<10||[_moneytf.text integerValue]>1000000){
        [MessageTool showMessage:@"充值金额10到100万" isError:YES];
        return;
    }
    
    [RequestManager postRequestWithURLPath:KURLRecharge withParamer:@{@"amount":_moneytf.text,@"mobile_sms":_vertf.text,@"sms_seq":_sms_seq} completionHandler:^(id responseObject) {
        
        
       NSDictionary *rep=(NSDictionary *)responseObject;
       NSLog(@"%@",rep);
        
        if ([rep[@"result"] integerValue]==1) {
           
//            NSDictionary *dic=rep[@"data"][@"form"][@"request_arr"];
//            NSLog(@"resp:%@",responseObject);
//            NSString *url=[NSString stringWithFormat:@"%@?BankId=%@&BgRetUrl=%@&ChkValue=%@&CmdId=%@&GateBusiId=%@&MerCustId=%@&OrdDate=%@&OrdId=%@&RetUrl=%@&SignId=%@&SmsCode=%@&SmsSeq=%@&TransAmt=%@&UsrCustId=%@&Version=%@",rep[@"data"][@"form"][@"request_url"],dic[@"BankId"],dic[@"BgRetUrl"],dic[@"ChkValue"],dic[@"CmdId"],dic[@"GateBusiId"],dic[@"MerCustId"],dic[@"OrdDate"],dic[@"OrdId"],dic[@"RetUrl"],dic[@"SignId"],dic[@"SmsCode"],dic[@"SmsSeq"],dic[@"TransAmt"],dic[@"UsrCustId"],dic[@"Version"]];
//            [_svc pushViewController:_svc.AddWebViewController withObjects:@{@"url":url}];
            NSDictionary *firstdic = (NSDictionary *)responseObject[@"data"];
            NSDictionary *response = firstdic[@"form"];
            NSDictionary *dic      = response[@"request_arr"];
            NSString *body =@"";
            for (NSString *key in dic) {
                NSLog(@"key: %@ value: %@", key, dic[key]);
                body=[body stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,dic[key]]];
            }
            NSString *url=[NSString stringWithFormat:@"%@?%@",response[@"request_url"],[body substringFromIndex:1]];
            [_svc pushViewController:_svc.AddWebViewController withObjects:@{@"url":url}];
        }
        
        [_svc showMessage:rep[@"data"][@"message"]];
        [_svc hideLoadingView];
        
        
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
        
    }];

 
}
-(void)sendeVer:(UIButton *)sender{
       [_svc showLoadingWithMessage:@"发送中..." inView:[UIApplication sharedApplication].keyWindow];
    
    [RequestManager postRequestWithURLPath:KURLStringSendsms withParamer:@{@"mobile":@"",@"type":@"recharge",@"bank_account":@"",@"mobile_type":@""} completionHandler:^(id responseObject) {
        
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSLog(@"%@",dic);
        if ([dic[@"result"] integerValue]==1) {
            _sms_seq=dic[@"data"][@"sms_seq"];
        }
        
        [_svc showMessage:dic[@"data"][@"message"]];
        [_svc hideLoadingView];
        
        
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
        
    }];
//
    
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:@"发送验证码" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
        }else{
            //int seconds = timeout % 60;
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [sender setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                
                //  sender.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
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
