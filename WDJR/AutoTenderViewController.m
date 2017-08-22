//
//  AutoTenderViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/10.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "AutoTenderViewController.h"
#import "AutotenderHeaderView.h"
#import "AutoTenderModel.h"
#define TextFile   ([UIScreen mainScreen].bounds.size.width-145)/2


@interface AutoTenderViewController ()

@property(nonatomic, strong) AutotenderHeaderView *headerView;

@property(nonatomic, strong)UIButton *bigBtn;
@property(nonatomic, strong) UISwitch *switchs;

@property(nonatomic, strong) UITextField *yueFile; //账户保留金额
@property(nonatomic, strong) UITextField *nianLihuaFile;//年利率

@property(nonatomic, strong) UITextField *yueBiaoFistFile;//月标期限
@property(nonatomic, strong) UITextField *yueBiaoSecondFile;

@property(nonatomic, strong) UITextField *tianBiaoFistFile;//天标期限
@property(nonatomic, strong) UITextField *tianBiaoSecondFile;

@property(nonatomic, strong) UITextField *touBiaoFistFile;//投标金额
@property(nonatomic, strong) UITextField *touBiaoSecondFile;

@property(nonatomic, strong) UIButton *toubiaoBtn;
@property(nonatomic, strong) NSString *userStatu;

@property(nonatomic, strong) AutoTenderModel *autoTendetrModel;


@end

@implementation AutoTenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"自动投标";
    
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.tableHeaderView =[self headerView];
    _tableView.tableFooterView = [self footerView];
    
    //没有分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
  //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AutoTendMessage:) name:@"AutoTenderMessage" object:nil];
    
   
    
}

-(void)viewWillAppear:(BOOL)animated
{
     [self requestRefresh];
}




-(UIView *)headerView
{
    if (!_headerView) {
        
        _headerView = [[AutotenderHeaderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, _tableView.bounds.size.height/5)];
        _headerView.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
        
        //_headerView.delegate = self;
        
        
    }
    return _headerView;
}


-(UIView *)footerView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 350)];
    footView.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 2)];
    line.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    [footView addSubview:line];
    //第一行
    UILabel *isOksWitchlbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 60, 21)];
    isOksWitchlbl.text = @"是否开启";
    isOksWitchlbl.font = shisiFont;
    isOksWitchlbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    [footView addSubview:isOksWitchlbl];
    
    _switchs = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMaxX(isOksWitchlbl.frame)+30, 10, 60, 25)];
    _switchs.onTintColor = [AppAppearance sharedAppearance].yellowColor;
    [_switchs addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [footView addSubview:_switchs];
    
    //第二行
    UILabel *toubiao = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(isOksWitchlbl.frame)+20, 60, 21)];
    toubiao.text = @"投标金额";
    toubiao.font = shisiFont;
    toubiao.textColor = [AppAppearance sharedAppearance].titleTextColor;
    [footView addSubview:toubiao];
    
    
    _touBiaoFistFile =[self customTextFile:@""];
    _touBiaoFistFile.frame = CGRectMake(CGRectGetMaxX(toubiao.frame)+30, CGRectGetMaxY(isOksWitchlbl.frame)+18, TextFile, 25);
    UIView *touBiaoFistFileLeft = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_touBiaoFistFile.frame), CGRectGetMaxY(isOksWitchlbl.frame)+18, 5, 25)];
    _touBiaoFistFile.leftView = touBiaoFistFileLeft;
    [footView addSubview:_touBiaoFistFile];
    
    UILabel *secondlbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_touBiaoFistFile.frame), CGRectGetMaxY(isOksWitchlbl.frame)+20, 10, 21)];
    secondlbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    secondlbl.text = @"~";
    secondlbl.font = shisiFont;
    [footView addSubview:secondlbl];
    
    
    _touBiaoSecondFile =[self customTextFile:@""];
    _touBiaoSecondFile.frame = CGRectMake(CGRectGetMaxX(secondlbl.frame), CGRectGetMaxY(isOksWitchlbl.frame)+18, TextFile, 25);
    UIView *touBiaoSecondFileLeft = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_tianBiaoSecondFile.frame), CGRectGetMaxY(isOksWitchlbl.frame)+18, 5, 25)];
    _touBiaoSecondFile.leftView = touBiaoSecondFileLeft;
    [footView addSubview:_touBiaoSecondFile];
    
    UILabel *secondYuelbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_touBiaoSecondFile.frame)+5, CGRectGetMaxY(isOksWitchlbl.frame)+20, 15, 21)];
    secondYuelbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    secondYuelbl.text = @"元";
    secondYuelbl.font = shisiFont;
    [footView addSubview:secondYuelbl];
    
    
    
    
    
    //第三行
    UILabel *tianBiao = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(toubiao.frame)+20, 60, 21)];
    tianBiao.text = @"天标期限";
    tianBiao.font = shisiFont;
    tianBiao.textColor = [AppAppearance sharedAppearance].titleTextColor;
    [footView addSubview:tianBiao];
    
    
    _tianBiaoFistFile =[self customTextFile:@""];
    _tianBiaoFistFile.frame = CGRectMake(CGRectGetMaxX(tianBiao.frame)+30, CGRectGetMaxY(toubiao.frame)+18, TextFile, 25);
    UIView *tianBiaoFistFileLeft = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_yueBiaoFistFile.frame), CGRectGetMaxY(toubiao.frame)+18, 5, 25)];
    _tianBiaoFistFile.leftView = tianBiaoFistFileLeft;
    [footView addSubview:_tianBiaoFistFile];
    
    UILabel *thirdlbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_tianBiaoFistFile.frame), CGRectGetMaxY(toubiao.frame)+20, 10, 21)];
    thirdlbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    thirdlbl.text = @"~";
    thirdlbl.font = shisiFont;
    [footView addSubview:thirdlbl];
    
    
    _tianBiaoSecondFile =[self customTextFile:@""];
    _tianBiaoSecondFile.frame = CGRectMake(CGRectGetMaxX(thirdlbl.frame), CGRectGetMaxY(toubiao.frame)+18, TextFile, 25);
    UIView *tianBiaoSecondFileLeft = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_tianBiaoSecondFile.frame), CGRectGetMaxY(toubiao.frame)+18, 5, 25)];
    _tianBiaoSecondFile.leftView = tianBiaoSecondFileLeft;
    [footView addSubview:_tianBiaoSecondFile];
    
    UILabel *thirdYuelbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_tianBiaoSecondFile.frame)+5, CGRectGetMaxY(toubiao.frame)+20, 15, 21)];
    thirdYuelbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    thirdYuelbl.text = @"天";
    thirdYuelbl.font = shisiFont;
    [footView addSubview:thirdYuelbl];
    

    //第四行
    UILabel *yueBiao = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(tianBiao.frame)+20, 60, 21)];
    yueBiao.text = @"月标期限";
    yueBiao.font = shisiFont;
    yueBiao.textColor = [AppAppearance sharedAppearance].titleTextColor;
    [footView addSubview:yueBiao];
    
    _yueBiaoFistFile =[self customTextFile:@""];
    _yueBiaoFistFile.frame = CGRectMake(CGRectGetMaxX(tianBiao.frame)+30, CGRectGetMaxY(tianBiao.frame)+18, TextFile, 25);
    UIView *yueBiaoFistFileLeft = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_yueBiaoFistFile.frame), CGRectGetMaxY(tianBiao.frame)+18, 5, 25)];
    _yueBiaoFistFile.leftView = yueBiaoFistFileLeft;
    [footView addSubview:_yueBiaoFistFile];
    
    UILabel *fourlbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_yueBiaoFistFile.frame), CGRectGetMaxY(tianBiao.frame)+20, 10, 21)];
    fourlbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    fourlbl.text = @"~";
    fourlbl.font = shisiFont;
    [footView addSubview:fourlbl];
    
    
    _yueBiaoSecondFile =[self customTextFile:@""];
    _yueBiaoSecondFile.frame = CGRectMake(CGRectGetMaxX(fourlbl.frame), CGRectGetMaxY(tianBiao.frame)+18, TextFile, 25);
    UIView *yueBiaoSecondFileLeft = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_yueBiaoSecondFile.frame), CGRectGetMaxY(tianBiao.frame)+18, 5, 25)];
    _yueBiaoSecondFile.leftView = yueBiaoSecondFileLeft;
    [footView addSubview:_yueBiaoSecondFile];
    
    UILabel *fourYuelbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_yueBiaoSecondFile.frame)+5, CGRectGetMaxY(tianBiao.frame)+20, 30, 21)];
    fourYuelbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    fourYuelbl.text = @"个月";
    fourYuelbl.font = shisiFont;
    [footView addSubview:fourYuelbl];
    
    
    //第五行
    UILabel *nianlilv = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(yueBiao.frame)+20, 60, 21)];
    nianlilv.text = @"年利化率";
    nianlilv.font = shisiFont;
    nianlilv.textColor = [AppAppearance sharedAppearance].titleTextColor;
    [footView addSubview:nianlilv];
    
    UILabel *dayu = [[UILabel alloc] initWithFrame:CGRectMake(75, CGRectGetMaxY(yueBiao.frame)+20, 10, 21)];
    dayu.textColor = [AppAppearance sharedAppearance].mainColor;
    dayu.text = @"≥";
    dayu.font = shisiFont;
    [footView addSubview:dayu];
    
    _nianLihuaFile =[self customTextFile:@""];
    _nianLihuaFile.frame = CGRectMake(CGRectGetMaxX(dayu.frame)+15, CGRectGetMaxY(yueBiao.frame)+18, TextFile, 25);
    UIView *nianFileLeft = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dayu.frame), CGRectGetMaxY(nianlilv.frame)+18, 5, 25)];
    _nianLihuaFile.leftView = nianFileLeft;
    [footView addSubview:_nianLihuaFile];
    
    UILabel *fivelbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_nianLihuaFile.frame)+5, CGRectGetMaxY(yueBiao.frame)+20, 80, 21)];
    fivelbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    fivelbl.text = @"%(两位小数)";
    fivelbl.font = shisiFont;
    [footView addSubview:fivelbl];
    
    
    
    //第六行
    UILabel *yue = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(nianlilv.frame)+20, 90, 21)];
    yue.text = @"账户保留金额";
    yue.font = shisiFont;
    yue.textColor = [AppAppearance sharedAppearance].titleTextColor;
    [footView addSubview:yue];
    
    
    _yueFile =[self customTextFile:@""];
    _yueFile.frame = CGRectMake(CGRectGetMaxX(yue.frame), CGRectGetMaxY(nianlilv.frame)+18, TextFile, 25);
    UIView *yuFileLeft = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(yue.frame), CGRectGetMaxY(nianlilv.frame)+18, 5, 25)];
    _yueFile.leftView = yuFileLeft;
    [footView addSubview:_yueFile];
    
    UILabel *lastlbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_yueFile.frame)+5, CGRectGetMaxY(nianlilv.frame)+20, 15, 21)];
    lastlbl.text = @"元";
    lastlbl.font = shisiFont;
    lastlbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    [footView addSubview:lastlbl];
  
    
    
    _toubiaoBtn = [[UIButton alloc] init];
    
    [_toubiaoBtn setBackgroundColor:[AppAppearance sharedAppearance].yellowColor];
    [_toubiaoBtn setTitle:@"保存自动投标设置" forState:UIControlStateNormal];
    [_toubiaoBtn setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
    _toubiaoBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _toubiaoBtn.layer.cornerRadius = 10;
    _toubiaoBtn.layer.masksToBounds = YES;
    
    _toubiaoBtn.frame = CGRectMake(20, CGRectGetMaxY(yue.frame)+20, self.view.frame.size.width-40, 40);
    [_toubiaoBtn addTarget:self action:@selector(toubiaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:_toubiaoBtn];
    

    UILabel *xianzhilbl = [[UILabel alloc] init];
    xianzhilbl.frame = CGRectMake(0, CGRectGetMaxY(_toubiaoBtn.frame)+10, WIDTH, 21);
    xianzhilbl.text = @"投标金额填入0值代表不限制投标金额!";
    xianzhilbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
    xianzhilbl.font = shisiFont;
    xianzhilbl.textAlignment = NSTextAlignmentCenter;
    [footView addSubview:xianzhilbl];
    
    
    return footView;
}


-(void)requestRefresh
{
    
    [AutoTenderModel requestAutoTenderModelShowSuccessHandle:^(id object) {
        
        
        NSLog(@"%@",object);
        _autoTendetrModel = (AutoTenderModel *)object;
        
        [_headerView setAutoTenderModel:_autoTendetrModel];
        
        if ([_autoTendetrModel.status isEqualToString:@"Y"]) {
            
            [_switchs setOn:YES];
            [_toubiaoBtn setEnabled:YES];
            [_toubiaoBtn setBackgroundColor:[AppAppearance sharedAppearance].yellowColor];
        }else{
            
            [_switchs setOn:NO];
            [_toubiaoBtn setEnabled:NO];
            [_toubiaoBtn setBackgroundColor:[AppAppearance sharedAppearance].pageBackgroundColor];
            
        }
        
        
        _yueFile.text            = _autoTendetrModel.left;
        _nianLihuaFile.text      = _autoTendetrModel.apr;
        _touBiaoFistFile.text    = _autoTendetrModel.amount_from;
        _touBiaoSecondFile.text  = _autoTendetrModel.amount_to;
        _tianBiaoFistFile.text   =  [NSString stringWithFormat:@"%@",_autoTendetrModel.deadline_day_from];
        _tianBiaoSecondFile.text = [NSString stringWithFormat:@"%@",_autoTendetrModel.deadline_day_to];
        _yueBiaoFistFile.text    = [NSString stringWithFormat:@"%@",_autoTendetrModel.deadline_month_from];
        _yueBiaoSecondFile.text  = [NSString stringWithFormat:@"%@",_autoTendetrModel.deadline_month_to];
        
        [self finishRequest];
        [_svc hideLoadingView];
        [self.tableView reloadData];
        
    } failHandler:^(NSError *error, NSUInteger statusCode) {
        
        [self finishRequest];
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
    }];
    
}




//保存自动投标设置
-(void)toubiaoBtnClick
{
    [RequestManager getRequestWithURLPath:KURLUserStatus withParamer:nil completionHandler:^(id responseObject) {
        
        
        NSLog(@"hhhh%@",responseObject);
        
        if ([responseObject[@"result"] integerValue]==1){
            NSDictionary *dic=responseObject[@"data"][@"info"];
            _userStatu=dic[@"status"];
            if ([dic[@"status"] integerValue]!=2) {
                [self showbigbtn];
                return ;
            }
        }
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        [self finishRequest];
        [_svc hideLoadingView];
        if (statusCode == 401) {
            
            [_svc presentViewController:_svc.loginViewController];
        }
        
    }];

    
    [AutoTenderModel requestAutoTenderModelStatus:(_switchs.on ? @"Y":@"N") andAmount_from:_touBiaoFistFile.text andAmount_to:_touBiaoSecondFile.text andDeadline_day_from:_tianBiaoFistFile.text andDeadline_day_to:_tianBiaoSecondFile.text andDeadline_month_from:_yueBiaoFistFile.text andDeadline_month_to:_yueBiaoSecondFile.text andApr:_nianLihuaFile.text andLeft:_yueFile.text SuccessHandle:^(id object) {
        
        
        NSLog(@"%@",object);
        if ([object[@"result"] integerValue]==1) {
            
            NSDictionary *dict=object[@"data"];
            if ([[dict allKeys]containsObject:@"form"]==NO) {
                [_svc showMessage: object[@"data"][@"message"]];
                return;
            }
            NSDictionary *response = object[@"data"][@"form"];
            NSDictionary *dic      = response[@"request_arr"];
            
            NSString *body =@"";
            for (NSString *key in dic) {
                NSLog(@"key: %@ value: %@", key, dic[key]);
                body=[body stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,dic[key]]];
            }
            [_svc pushViewController:_svc.autoTenderWebViewController withObjects:@{@"url":response[@"request_url"],@"body":body}];
            
            NSLog(@"1===%@",response);
            NSLog(@"2====%@",dic);
            
//            if (dic.count>8) {
//                
//                NSLog(@"10个参数");
//                
//                [_svc pushViewController:_svc.autoTenderWebViewController withObjects:@{@"url":response[@"request_url"],@"Version":dic[@"Version"],@"UsrCustId":dic[@"UsrCustId"],@"RetUrl":dic[@"RetUrl"],@"PageType":dic[@"PageType"],@"MerPriv":dic[@"MerPriv"],@"MerCustId":dic[@"MerCustId"],@"CmdId":dic[@"CmdId"],@"ChkValue":dic[@"ChkValue"],@"TenderPlanType":dic[@"TenderPlanType"],@"TransAmt":dic[@"TransAmt"],@"type":@"10"}];
//                
//            }else{
//                
//                NSLog(@"8个参数");
//                
//                [_svc pushViewController:_svc.autoTenderWebViewController withObjects:@{@"url":response[@"request_url"],@"Version":dic[@"Version"],@"UsrCustId":dic[@"UsrCustId"],@"RetUrl":dic[@"RetUrl"],@"PageType":dic[@"PageType"],@"MerPriv":dic[@"MerPriv"],@"MerCustId":dic[@"MerCustId"],@"CmdId":dic[@"CmdId"],@"ChkValue":dic[@"ChkValue"],@"type":@"8"}];
//                
//            }
            
        }else{
        

            
        }
        

        
   
        
//        [_svc showMessage:@"保存数据成功"];
//
        [self finishRequest];
        [_svc hideLoadingView];
//
//        [self.tableView reloadData];
        
        
    } failHandler:^(NSError *error, NSUInteger statusCode) {
        
        [self finishRequest];
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
        
    }];
    
    
}
-(void)showbigbtn{
    _bigBtn=[[UIButton alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _bigBtn.backgroundColor=[UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:0.3];
    [_bigBtn addTarget:self action:@selector(empty) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:_bigBtn];
    
    UIImageView *alertview=[[UIImageView alloc]initWithFrame:CGRectMake(30, 104, WIDTH-60, (WIDTH-60)*1.32)];
    alertview.clipsToBounds=YES;
    alertview.layer.cornerRadius=10;
    alertview.userInteractionEnabled=YES;
    alertview.image=[UIImage imageNamed:@"wdjr_alert"];
    [_bigBtn addSubview:alertview];
    
    UIButton *closeBtn=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-100, 0, 40, 40)];
    [closeBtn addTarget:self action:@selector(empty) forControlEvents:UIControlEventTouchUpInside];
    [alertview addSubview:closeBtn];
    
    UIButton *toOpenBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, (WIDTH-60)*1.32*0.8, WIDTH-100, (WIDTH-60)*1.32*0.18)];
    [toOpenBtn addTarget:self action:@selector(toOpenClick) forControlEvents:UIControlEventTouchUpInside];
    [alertview addSubview:toOpenBtn];
    
}
-(void)toOpenClick{
    [_bigBtn removeFromSuperview];
    if ([_userStatu integerValue]==0) {
        [_svc pushViewController:_svc.OpenAccountViewController];
    }else{
        [_svc pushViewController:_svc.ActiveAccountViewController];
    }
}
-(void)empty{
    [_bigBtn removeFromSuperview];
}
-(void)switchAction:(UISwitch *)sw
{
    if (_switchs.on) {
      
        NSLog(@"打开");
 
        [_toubiaoBtn setEnabled:YES];
        [_toubiaoBtn setBackgroundColor:[AppAppearance sharedAppearance].yellowColor];
        
    }else {
        
       NSLog(@"关闭");
        
        if ([_autoTendetrModel.status isEqualToString:@"N"]) {
            
            
            [_switchs setOn:NO];
            [_toubiaoBtn setEnabled:NO];
            [_toubiaoBtn setBackgroundColor:[AppAppearance sharedAppearance].pageBackgroundColor];
         
        }
        
    }
    [self.tableView reloadData];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(BOOL)shouldShowRefresh
{
    return NO;
}


-(BOOL)shouldShowGetMore
{
    return NO;
}


//对UILabel的字体属性的设置方法
-(UITextField *)customTextFile:(NSString *)title
{
    UITextField *textFile         = [[UITextField alloc] init];
    textFile.backgroundColor  = [UIColor clearColor];
    textFile.textColor        = [AppAppearance sharedAppearance].titleTextColor;
    textFile.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    /*label.font = [UIFont fontWithName:@"Helvetica" size:15.f];
     @"Helvetica"是字体的样式，也就是字体的风格，相当于宋体、楷体等。
     常用的字体有Arial,Helvetica等,要加粗就在其后加"-Bold"，如，@"Helvetica-Bold"。
     */
    //label.font             = [UIFont fontWithName:@"Helvetica-Bold" size:15.f];
    //textFile.textAlignment = NSTextAlignmentCenter;
    textFile.font             = shisiFont;
    textFile.keyboardType = UIKeyboardTypeNumberPad;
    
    textFile.leftViewMode             = UITextFieldViewModeAlways;
    
    textFile.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textFile.layer.borderColor=[[UIColor colorWithRed:211/255.0 green:212/255.0 blue:213/255.0 alpha:1] CGColor];
    textFile.borderStyle = UITextBorderStyleNone;
    textFile.layer.borderWidth=1.0f;
    textFile.layer.cornerRadius = 5.0;
    textFile.layer.masksToBounds = YES;
    
    return textFile;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
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
