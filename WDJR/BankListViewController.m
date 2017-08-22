//
//  BankListViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/12/27.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BankListViewController.h"
#import "BankListModel.h"
#import "BankListCell.h"
#import "AddWebViewController.h"
@interface BankListViewController ()


@property(nonatomic, strong) NSArray *bankList;
@property(nonatomic, strong)UIButton *bigBtn;
@property(nonatomic, strong) NSString *phoneStr,*userStatu;
@end

@implementation BankListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的银行卡";
    
    [self showRightItem];
    self.tableView.tableFooterView=[self setfooterView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self requestRefresh];
}
-(UIView *)setfooterView{
    
    UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 330)];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(15, 30, 100, 20)];
    lab.text=@"温馨提示";
    lab.textColor=[UIColor lightGrayColor];
    [footer addSubview:lab];
    
    UILabel *seclab=[[UILabel alloc]initWithFrame:CGRectMake(20, 55, 250, 20)];
    seclab.text=@"如需换绑卡，请到PC端进行操作";
    seclab.font=[UIFont systemFontOfSize:15];
    seclab.textColor=[UIColor lightGrayColor];
    [footer addSubview:seclab];
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 310, WIDTH, 20)];
    [btn setTitle:@"查询贵州银行电子账户>" forState:UIControlStateNormal];
    [btn setTitleColor:RGB(106, 165, 211) forState:UIControlStateNormal];
    [footer addSubview:btn];
    [btn addTarget:self action:@selector(openBank) forControlEvents:UIControlEventTouchUpInside];
    return footer;
}
-(void)openBank{
    [RequestManager getRequestWithURLPath:KURLSecurity withParamer:nil completionHandler:^(id responseObject) {
//        NSDictionary *rep=(NSDictionary *)responseObject;
//        NSDictionary *dic=rep[@"data"][@"form"][@"request_arr"];
//        NSLog(@"resp:%@",responseObject);
//        NSString *url=[NSString stringWithFormat:@"%@?Version=%@&CmdId=%@&MerCustId=%@&UsrCustId=%@&SubAcctId=%@&PageType=%@&ChkValue=%@",rep[@"data"][@"form"][@"request_url"],dic[@"Version"],dic[@"CmdId"],dic[@"MerCustId"],dic[@"UsrCustId"],dic[@"SubAcctId"],dic[@"PageType"],dic[@"ChkValue"]];
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
        //[_svc pushViewController:_svc.testWebViewController withObjects:@{@"url":url}];

        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        
    }];

//    AddWebViewController *webvc=[[AddWebViewController alloc]init];
//    [self.navigationController pushViewController:webvc animated:NO];
}
-(void)requestRefresh
{
    
//    [_svc  showLoadingWithMessage:@"加载中..." inView:[UIApplication sharedApplication].keyWindow ];
    [BankListModel requestBankListModelCompletionHandler:^(id object) {
        
        NSArray *array = (NSArray *)object;
        _bankList = array;
        
        [self finishRequest];
        [_svc hideLoadingView];
        
        [self.tableView reloadData];
        
    } failHandler:^(NSError *error, NSUInteger statusCode) {
        
        [self finishRequest];
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
    }];
}



#pragma mark ---UITableViewDelegate-------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _bankList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankListCell *cell = [BankListCell BankListModelWithTableView:tableView];
    
    BankListModel *model = (BankListModel *)_bankList[indexPath.row];
    
    cell.bankModel = model;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (WIDTH-30)/1.8+40;
}

//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        BankListModel *model = _bankList[indexPath.row];
//        NSLog(@"%@",model);
////        [WithdrawModel requestDelWithdrawid:model.recordId successHandle:^(id object) {
////            [self.rows removeObjectAtIndex: indexPath.row ];
////            [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
////        } failuerHandle:^(NSError *error, NSUInteger statusCode) {
////            [_svc showMessage:error.domain];
////            
////        }];
//    }
//}




-(void)showRightItem
{
    UIButton *btn = [self.class buttonWithImage:nil title:@"添加" target:self action:@selector(addBank)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self addItemForLeft:NO withItem:item spaceWidth:0];
}


-(void)addBank
{
    
    [RequestManager getRequestWithURLPath:KURLUserStatus withParamer:nil completionHandler:^(id responseObject) {
        
        
        NSLog(@"hhhh%@",responseObject);
        
        if ([responseObject[@"result"] integerValue]==1){
            NSDictionary *dic=responseObject[@"data"][@"info"];
            _userStatu=dic[@"status"];
            if ([dic[@"status"] integerValue]!=2) {
                [self showbigbtn];
                return;
            }
        }
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        [self finishRequest];
        [_svc hideLoadingView];
        if (statusCode == 401) {
            
            [_svc presentViewController:_svc.loginViewController];
        }
        
    }];
    

    [RequestManager postRequestWithURLPath:KURLbankCard withParamer:nil completionHandler:^(id responseObject) {
        
        
        NSLog(@"%@",responseObject);
        
        
        
        if ([responseObject[@"result"] integerValue] ==1) {
            
            NSDictionary *firstDic = responseObject[@"data"];
            NSDictionary *response = firstDic[@"form"];
            NSDictionary *dic      = response[@"request_arr"];
            
            NSString *body =@"";
            for (NSString *key in dic) {
                NSLog(@"key: %@ value: %@", key, dic[key]);
                body=[body stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,dic[key]]];
            }
            [_svc pushViewController:_svc.bankCardViewController withObjects:@{@"url":response[@"request_url"],@"body":body}];
            
            //[_svc pushViewController:_svc.bankCardViewController withObjects:@{@"url":response[@"request_url"],@"BgRetUrl":dic[@"BgRetUrl"],@"ChkValue":dic[@"ChkValue"],@"CmdId":dic[@"CmdId"],@"MerCustId":dic[@"MerCustId"],@"MerPriv":dic[@"MerPriv"],@"PageType":dic[@"PageType"],@"UsrCustId":dic[@"UsrCustId"],@"Version":dic[@"Version"]}];
        }else{
            
            NSDictionary *firstdic = (NSDictionary *)responseObject[@"data"];
            
            if ([firstdic[@"message"] isEqualToString:@"token_expired"]) {
                
                [_svc showMessage:@"权限过期，请重新登录"];
                [_svc presentViewController:_svc.loginViewController];
                
            }else{
                
                    [_svc showMessage:firstdic[@"message"]];
                
            }
        }
        
        
        
        
        [self finishRequest];
        [_svc hideLoadingView];
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        [self finishRequest];
        [_svc hideLoadingView];
        if (statusCode == 401) {
            
            [_svc presentViewController:_svc.loginViewController];
        }
        
    }];

}


-(BOOL)shouldShowGetMore
{
    return NO;
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
