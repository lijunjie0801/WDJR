

#import <Security/Security.h>
#import <CoreFoundation/CoreFoundation.h>
#import "GesturePasswordController.h"
#import "Utility.h"
#import "AppNavigationController.h"
#import "HomeViewController.h"

@interface GesturePasswordController ()<UIAlertViewDelegate>

@property (nonatomic,strong) GesturePasswordView * gesturePasswordView;

@property (nonatomic,strong) NSString * stateTitle;
@property (nonatomic,strong) NSString * GPW;
@property (nonatomic,strong) NSString * PW;
@property (nonatomic,assign) GestureType type;
@property (nonatomic,assign) BOOL isShowBackItem;
@property (nonatomic,assign) NSInteger isON;
@property (nonatomic,strong) NSString * flag;
@property (nonatomic,assign) NSInteger times;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) NSString *userName;

//提示是否实名认证
@property (nonatomic,strong) UIAlertView *alertView;

@end

@implementation GesturePasswordController {
    NSString * previousString;
    NSString * password;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setIntentDic:(NSDictionary *)intentDic
{
    _type = [intentDic[@"type"] integerValue];
    _isShowBackItem = [intentDic[@"isShowBackItem"] boolValue];
    if([[intentDic allKeys] containsObject:@"isON"])
    {
        _isON = [intentDic[@"isON"] integerValue];
        _flag = intentDic[@"flag"];
        
        
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [AppAppearance sharedAppearance].blueColor;
    _titleLabel = [self titleLabel];
    
//    if ([UserModel sharedModel].username.length)
//    {
//        _titleLabel.text = [NSString stringWithFormat:@"Hi,%@",[Utility encryptShow:[UserModel sharedModel].username startingPosition:3 endPosition:4]];
//        
//    }else {
//        
//        _titleLabel.text = [NSString stringWithFormat:@"Hi, %@",[Utility encryptShow:[AppDataManager defaultManager].userMobile startingPosition:3 endPosition:4]];
//    }
    
    if ([AppDataManager defaultManager].hasLogin) {
        
        _titleLabel.text = [NSString stringWithFormat:@"Hi,%@",[AppDataManager defaultManager].PhoneAccount];
    }
    
    switch (_type) {
            //设定
        case GestureTypeSetting:
            [self reset];
            break;
            //重置
        case GestureTypeRest:
            //校验
        case GestureTypeVerific:
            //关闭
        case GestureTypeOff:
            [self exist];
            break;
        default:
            break;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   // self.navigationController.navigationBar.barTintColor= [UIColor colorWithRed:24/255.0 green:149/255.0 blue:212/255.0 alpha:1];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage buildImageWithColor:[AppAppearance sharedAppearance].blueColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                                                      NSForegroundColorAttributeName:[AppAppearance sharedAppearance].blackColor}];
    
    
    [AppDataManager defaultManager].isShowGestures = YES;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [AppDataManager defaultManager].isShowGestures = NO;
}

-(UILabel *)titleLabel
{
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 40)];
        _titleLabel.textColor = [AppAppearance sharedAppearance].whiteColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:24];
        [self.view addSubview:_titleLabel];
    }
    
    return _titleLabel;
}


-(BOOL)shouldHideNavigationBar
{
    return NO;
}

-(GesturePasswordView *)gesturePasswordView
{
    if(!_gesturePasswordView){
        _gesturePasswordView = [[GesturePasswordView alloc]initWithFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(10, 0, 0, 0))];
        _gesturePasswordView.backgroundColor = [UIColor clearColor];
        [_gesturePasswordView.tentacleView setRerificationDelegate:self];
        [_gesturePasswordView.tentacleView setResetDelegate:self];
        [_gesturePasswordView.tentacleView setStyle:1];
        [_gesturePasswordView.state setTextColor:[UIColor whiteColor]];
        [_gesturePasswordView.state setText:_stateTitle];
        [self.view addSubview:_gesturePasswordView];
    }
    
    return _gesturePasswordView;
}

-(void)clear
{
    [_gesturePasswordView.tentacleView enterArgin];
    [_gesturePasswordView.state setTextColor:[UIColor whiteColor]];
    [_gesturePasswordView.state setText:@"请输入您的手势密码"];
}

#pragma mark - 验证手势密码
- (void)verify{
    [_gesturePasswordView.tentacleView enterArgin];
    _stateTitle = @"请输入您的手势密码";
    [self.gesturePasswordView.tentacleView setStyle:1];
    [_gesturePasswordView setGesturePasswordDelegate:self];
}

#pragma mark - 设置手势密码
- (void)reset{
    [_gesturePasswordView.tentacleView enterArgin];
    _stateTitle = @"请设置您的手势密码";
    [self.gesturePasswordView.tentacleView setStyle:2];
    [_gesturePasswordView.forgetButton setHidden:YES];
    [_gesturePasswordView.changeButton setHidden:YES];
}

#pragma mark - 判断是否已存在手势密码
-(void)exist{
    previousString = [AppDataManager defaultManager].GPW;
    if(previousString.length >0){
        password = previousString;
        [self verify];
    } else{
        [self reset];
    }
}
#pragma mark - 用其他账号登陆
- (void)change{
    [self showAlertView:@"更换账户，是否重新登录?"];
}

#pragma mark - 忘记手势密码
- (void)forget{
    
    [self showAlertView:@"忘记密码，是否重新登录?"];
    
}

-(void)showAlertView:(NSString *)title
{
    
    UIAlertView *alretView = [[UIAlertView alloc]initWithTitle:title message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重新登录", nil];
    [alretView show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView != _alertView) {
        if (buttonIndex == 1) {
            [[AppDataManager defaultManager] logout];

            //手势界面重新登录返回问题。。。。。。。
            [_svc dismissTopViewControllerCompletion:^{
                [_svc presentViewController:_svc.loginViewController];
            }];
            
        }else{
            return;
        }
    }else if (alertView == _alertView) {
        if (buttonIndex == 1) {
            [_svc dismissTopViewControllerCompletion:nil];
          
        }else if (buttonIndex == 0) {
            [_svc dismissTopViewControllerCompletion:nil];
            
        }
    }
}

- (BOOL)verification:(NSString *)result{
    if ([result isEqualToString:password]) {
        [_gesturePasswordView.state setTextColor:[UIColor whiteColor]];
        [_gesturePasswordView.state setText:@"输入正确"];
        [self finishGesture];
        
        return YES;
    }
    _times ++;
    [_gesturePasswordView.state setTextColor:[UIColor redColor]];
    [_gesturePasswordView.state setText:[NSString stringWithFormat:@"密码错误,还可以尝试%@次",@(5-_times)]];
    [self performSelector:@selector(clearError) withObject:nil afterDelay:1];
    if (_times == 5) {
        _times =0;
        [[AppDataManager defaultManager] logout];
        [_svc pushViewController:_svc.loginViewController withObjects:@{@"isShowBackItem":@(NO)}];
    }
    
    return NO;
}

-(void)clearError
{
    [self clear];
}

- (BOOL)resetPassword:(NSString *)result{
    if (previousString.length == 0) {
        if (result.length <4) {
            [_gesturePasswordView.state setTextColor:[UIColor whiteColor]];
            [_gesturePasswordView.state setText:@"手势密码至少4个点"];
            [self performSelector:@selector(clearError) withObject:nil afterDelay:1];
            return NO;
        }
        previousString = result;
        [_gesturePasswordView.tentacleView enterArgin];
        [_gesturePasswordView.state setTextColor:[UIColor whiteColor]];
        [_gesturePasswordView.state setText:@"请验证您的手势密码"];
        return YES;
    }
    else {
        if ([result isEqualToString:previousString]) {
            //            KeychainItemWrapper * keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"Gesture" accessGroup:nil];
            //            [keychin setObject:@"<帐号>" forKey:(__bridge id)kSecAttrAccount];
            //            [keychin setObject:result forKey:(__bridge id)kSecValueData];
            //            //[self presentViewController:(UIViewController) animated:YES completion:nil];
            
            
            [[AppDataManager defaultManager] setGPW:result];
            [_gesturePasswordView.state setTextColor:[UIColor whiteColor]];
            [_gesturePasswordView.state setText:@"已保存手势密码"];
            [self finishGesture];
            return YES;
        }
        else{
            previousString = @"";
            [_gesturePasswordView.state setTextColor:[UIColor redColor]];
            [_gesturePasswordView.state setText:@"两次密码不一致，请重新输入"];
            [self performSelector:@selector(clearError) withObject:nil afterDelay:1];
            return NO;
        }
    }
}

-(void)finishGesture
{
    switch (_type) {
        case GestureTypeSetting:
        {
  
            [_svc dismissTopViewControllerCompletion:nil];
           
            
           
        }
            break;
        case GestureTypeVerific:
        {
            [_svc dismissTopViewControllerCompletion:nil];
            
           
        }
            break;
        case GestureTypeRest:
        {
            [_svc pushViewController:_svc.gesturePasswordController withObjects:@{@"type":@(GestureTypeSetting),@"isShowBackItem":@(YES)}];
        }
            break;
        case GestureTypeOff:
            [[AppDataManager defaultManager] setIsOff:NO];
            [_svc dismissTopViewControllerCompletion:nil];
            break;
        default:
            break;
    }
}



- (BOOL)shouldShowBackItem{
    
    return _isShowBackItem;
}


@end
