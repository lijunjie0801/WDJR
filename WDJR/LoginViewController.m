//
//  LoginViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/10/27.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "LoginViewController.h"
#import "UserBehaviorCell.h"
#import "LeftViewController.h"

@interface LoginViewController ()<UserBehaviorCellDelegate>

@property(nonatomic, strong) UITextField *phone;
@property(nonatomic, strong) UITextField *passWord;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    [self showRightItem];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    _tableView.tableHeaderView = [self headerView];
    _tableView.tableFooterView = [self footerView];
    
    [_tableView reloadData];

}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
    

    //把状态栏的中的颜色改为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage buildImageWithColor:[AppAppearance sharedAppearance].mainColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                                                      NSForegroundColorAttributeName:[AppAppearance sharedAppearance].whiteColor}];
    
}

//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//
//    
//}



//头部视图
-(UIView *)headerView
{
    UIView *headerView         = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    headerView.frame           = CGRectMake(0, 0, _tableView.bounds.size.width, 20);
    
    return headerView;
}



//尾部视图
-(UIView *)footerView
{
    UIView *footerView         = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    footerView.frame           = CGRectMake(0, 0, _tableView.bounds.size.width, 150);
    
    //登录按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[AppAppearance sharedAppearance].mainColor];
    [button setTitle:@"立即登录" forState:UIControlStateNormal];
    [button setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
    button.frame     = CGRectMake(20, 20, _tableView.bounds.size.width-40, 50);
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    
    UIView *registerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame)+5, WIDTH, 30)];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake((WIDTH - 190)/2, 0, 180, 30)];
    lbl.text = @"还未注册过账号 免费注册";
    lbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
    lbl.font = shisiFont;
    [registerView addSubview:lbl];
    [footerView addSubview:registerView];
    
    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerClick)];
    [registerView addGestureRecognizer:tag];
    

    return footerView;
}


//登录的点击事件
-(void)loginAction:(UIButton *)button
{
    
    
    if([self loginCheck]){
        
        [_svc  showLoadingWithMessage:@"登录中..." inView:[UIApplication sharedApplication].keyWindow ];
        NSDictionary *param =@{@"username":_phone.text,@"password":_passWord.text};
        
        [RequestManager postRequestWithURLPath:KURLStringLogin withParamer:param completionHandler:^(id responseObject) {
            
            [_svc hideLoadingView];
            
            NSLog(@"登录成功，返回的结果是:%@",responseObject);
            
            NSDictionary *dic = (NSDictionary *)responseObject[@"data"];
            if ([responseObject[@"result"] integerValue] ==1) {
                
                //把用户信息存储在AppDataManager
                [[AppDataManager defaultManager] setPhoneAccount:_phone.text];
                [[AppDataManager defaultManager] setPassWord:_passWord.text];
                [[AppDataManager defaultManager] setToken:dic[@"token"]];
//                [[AppDataManager defaultManager] setIsOff:YES];
//                [[AppDataManager defaultManager] setIsShowGestures:YES];
                
                [_svc pushViewController:_svc.gesturePasswordController withObjects:@{@"type":@(GestureTypeSetting)}];
                
//                [_svc dismissTopViewControllerCompletion:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TabBarControllerSelectedIndex" object:nil userInfo:@{@"index":@"0"}];
        
                
                
                

//                [_svc showMessage:@"登录成功"];
                
            }else{
            
                
                [_svc showMessage:dic[@"message"]];
            }
            
        
            
        } failureHandler:^(NSError *error, NSUInteger statusCode) {
            
            [_svc hideLoadingView];
           // [_svc showMessage:error.domain];
            _passWord.text = @"";
            
            NSLog(@"登录失败，返回的结果是:%@",error.domain);
        }];
        
    }
}







//手机号码的验证
//-(BOOL)phoneCheck:(NSString *)content
//{
//    
//    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
//    return [phoneTest evaluateWithObject:phoneRegex];
//    
//}

//用户名和密码的验证
-(BOOL)loginCheck{
    
    [self.view endEditing:YES];
    if(_phone.text.length == 0){
        [_svc showMessage:@"请输入您的账号"];
        return NO;
    }
    if(_passWord.text.length == 0){
        [_svc showMessage:@"请输入您的密码"];
        return NO;
    }
    
    if (_passWord.text.length < 6) {
        [MessageTool showMessage:@"密码长度至少6位" isError:YES];
        return NO;
    }
//    if(![Utility checkPhone:_phone.text])
//    {
//        [_svc showMessage:@"请输入正确的手机号"];
//        return NO;
//    }
    

    
    return YES;
}

#pragma mark - UItableViewControllerDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"loginCell";
    UserBehaviorCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UserBehaviorCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
            cell.imageView.image        = [UIImage imageNamed:@"user"];
            cell.textField.keyboardType = UIKeyboardTypeDefault;
            cell.textField.placeholder  = @"请输入手机号或者用户名";
            cell.forgetPass.hidden = YES;
//            if ([AppDataManager defaultManager].PhoneAccount) {
//                
//                cell.textField.text = [AppDataManager defaultManager].PhoneAccount;
//            }
            _phone                      = cell.textField;
            break;
        case 1:
            cell.imageView.image           = [UIImage imageNamed:@"lock"];
            cell.textField.keyboardType    = UIKeyboardTypeDefault;
            cell.textField.secureTextEntry = YES;
            cell.textField.placeholder     = @"请输入密码";
            cell.isHide                    = YES;
//            if ([AppDataManager defaultManager].passWord) {
//                
//                cell.textField.text = [AppDataManager defaultManager].passWord;
//            }
 
            _passWord                      = cell.textField;
            
            cell.accessoryView = cell.forgetPass;
            break;
            
        default:
            break;
    }
    return cell;
}

//输入框选中，键盘出现
-(void)didSelectTextField:(id)object
{
    if (CGRectGetHeight([UIScreen mainScreen].bounds) == 480) {
        [UIView animateWithDuration:0.23 animations:^{
            _tableView.contentOffset = CGPointMake(0, 80);
        } completion:^(BOOL finished) {
            
        }];
    }
}




//输入完毕，键盘复位（消失）
- (void)didEndEditing
{
    [self.view endEditing:YES];
    if (CGRectGetHeight([UIScreen mainScreen].bounds) == 480) {
        [UIView animateWithDuration:0.23 animations:^{
            _tableView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            
        }];
    }
}


-(void)showRightItem
{
    UIButton *btn = [self.class buttonWithImage:nil title:@"忘记密码" target:self action:@selector(forgetClick)];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self addItemForLeft:NO withItem:item spaceWidth:0 ];
    
}

-(void)forgetClick
{
    [_svc pushViewController:_svc.findPassViewController];
}


-(void)registerClick
{
    [_svc pushViewController:_svc.registerViewController];
}


-(BOOL)shouldShowRefresh
{
    return NO;
}

-(BOOL)shouldShowGetMore
{
    return NO;
}

-(BOOL)shouldShowBackItem
{
    return NO;
}

-(BOOL)shouldHideNavigationBar
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
