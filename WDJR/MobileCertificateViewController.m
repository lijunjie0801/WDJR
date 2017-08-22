//
//  MobileCertificateViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "MobileCertificateViewController.h"
#import "UserBehaviorCell.h"

@interface MobileCertificateViewController ()

@property(nonatomic, strong) UITextField *phone;  //电话号码
@property(nonatomic, strong) UITextField *verify; //验证码
@property(nonatomic, strong) UIButton    *authBtn;   //发送验证码

@end

@implementation MobileCertificateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"手机认证";
    
    _tableView.tableFooterView = [self footView];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.bounds), 20)];
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    
}

-(UIView *)footView

{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
    
    UIButton *submitBtn                    = [self buttonWithFrame:CGRectMake(10, 20, CGRectGetWidth(self.view.bounds)-20, 50) title:@"立即认证" image:nil backImage:nil target:nil action:nil];
    submitBtn.backgroundColor    = [AppAppearance sharedAppearance].mainColor;
    submitBtn.layer.cornerRadius = 10;
    submitBtn.layer.masksToBounds      = YES;
    [submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:submitBtn];
    
    
  
    
    
    return footView;
}

//手机认证
-(void)submitClick
{
    
    if ([self checkInputs]) {
        
        [_svc showLoadingWithMessage:@"认证中..." inView:self.view];
        
        
        [RequestManager postRequestWithURLPath:KURLPhoneRenZheng withParamer:@{@"mobile":_phone.text,@"verify_code":_verify.text} completionHandler:^(id responseObject) {
            
            
            NSLog(@"返回的结果是:%@",responseObject);
            
            NSDictionary *dic = (NSDictionary *)responseObject[@"data"];
            if ([responseObject[@"result"] integerValue] ==1) {
   
                
            }
                
            [_svc showMessage:dic[@"message"]];
           
            
            [_svc hideLoadingView];
            
            
        } failureHandler:^(NSError *error, NSUInteger statusCode) {
            
            [_svc hideLoadingView];
            
            [_svc showMessage:error.domain];
            
        }];
        
        
        
        
    }
}


//检验输入的正确性
-(BOOL)checkInputs
{
    if (!_phone.text.length) {
        [MessageTool showMessage:@"手机号不能为空" isError:YES];
        return NO;
    }
    if (!_verify.text.length) {
        
        [MessageTool showMessage:@"验证码不能为空" isError:YES];
        return NO;
    }
    if(![Utility checkPhone:_phone.text])
    {
        [_svc showMessage:@"请输入正确的手机号"];
        return NO;
    }
 
    return YES;
}

//发送验证码按钮
-(UIButton *)verifyButton
{
    if (!_authBtn) {
        
        _authBtn    = [UIButton buttonWithType:UIButtonTypeCustom];
        _authBtn.frame = CGRectMake(CGRectGetWidth(self.view.bounds) - 100, 5, 86, 30);
        _authBtn.layer.cornerRadius = 3.f;
        _authBtn.clipsToBounds = YES;
        _authBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_authBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_authBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_authBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_authBtn setBackgroundImage:[UIImage buildImageWithColor:[AppAppearance sharedAppearance].mainColor] forState:UIControlStateNormal];
        [_authBtn addTarget:self action:@selector(authBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _authBtn;
}


//发送验证按钮的点击事件
-(void)authBtnClick:(UIButton *)button
{
    if (_phone.text.length == 0) {
        
        [MessageTool showMessage:@"手机号不能为空" isError:YES];
        return;
    }
    [_svc showLoadingWithMessage:@"发送中..." inView:[UIApplication sharedApplication].keyWindow];
    
    
    [RequestManager postRequestWithURLPath:KURLStringSendSma withParamer:@{@"mobile":_phone.text,@"mobile_rule":@"check_mobile_unique",@"image_captcha_rule":@"captcha_null"} completionHandler:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic[@"success"] integerValue]==1) {
            
            
            [self countDownTime:@(60)];
            
        }
        
        [_svc showMessage:dic[@"message"]];
        [_svc hideLoadingView];
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        [_svc hideLoadingView];
        [self countDownTime:@(0)];
        [_svc showMessage:error.domain];
        
    }];
    
    
}

//倒计时函数
-(void)countDownTime:(NSNumber *)sourceDate
{
    __block int timeout = sourceDate.intValue;  //倒计时间
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatchQueue);
    dispatch_source_set_timer(_time, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_time, ^{
        
        if (timeout <= 1) {
            dispatch_source_cancel(_time);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_authBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                _authBtn.enabled = YES;
            });
        }else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *numStr = [NSString stringWithFormat:@"%d",timeout];
                NSString *strTime = [NSString stringWithFormat:@"%@秒",numStr];
                _authBtn.enabled = NO;
                _authBtn.titleLabel.text = strTime;
            });
            
            timeout--;
        }
        
    });
    dispatch_resume(_time);
}



#pragma mark  ---UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellId";
    UserBehaviorCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[UserBehaviorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
       // cell.textField.delegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
            cell.imageView.image        = [UIImage imageNamed:@"phone"];
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            cell.textField.placeholder  = @"手机号";
            _phone = cell.textField;
            break;
        case 1:
            cell.imageView.image           = [UIImage imageNamed:@"code"];
            cell.textField.keyboardType    = UIKeyboardTypeNumberPad;
            cell.textField.secureTextEntry = NO;
            cell.textField.placeholder     = @"短信验证码";
            cell.textField.clearButtonMode = UITextFieldViewModeNever;
            _verify                        = cell.textField;
            [cell addSubview:[self verifyButton]];
            break;
        default:
            break;
    }
    cell.textField.font         = shiliuFont;
    return cell;
}

//UIButton的通用方法
-(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image backImage:(UIImage *)backImage target:(id)target action:(SEL)action
{
    UIButton *button       =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame           = frame;
    
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:backImage forState:UIControlStateNormal];
    [button setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 5;
    button.clipsToBounds =YES;
    
    
    return  button;
}


-(BOOL)shouldShowGetMore
{
    return NO;
}

-(BOOL)shouldShowRefresh
{
    return NO;
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
