//
//  AccountSafeViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "AccountSafeViewController.h"
#import "UserBehaviorCell.h"

@interface AccountSafeViewController ()

@property(nonatomic, strong) UITextField *oldPass; //原始密码
@property(nonatomic, strong) UITextField *newsPass;  //确认密码
@property(nonatomic, strong) UITextField *confirmPass;  //确认密码

@property(nonatomic, strong) UIButton    *submitBtn;  //提交

@end

@implementation AccountSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.title =@"修改密码";
    
    _tableView.tableFooterView = [self footView];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.bounds), 20)];
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    
    
}


-(UIView *)footView

{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
    
    _submitBtn                    = [self buttonWithFrame:CGRectMake(10, 20, CGRectGetWidth(self.view.bounds)-20, 50) title:@"修改密码" image:nil backImage:nil target:nil action:nil];
    _submitBtn.backgroundColor    = [AppAppearance sharedAppearance].mainColor;
    _submitBtn.layer.cornerRadius = 10;
    _submitBtn.layer.masksToBounds      = YES;
    [_submitBtn addTarget:self action:@selector(changePassword) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:_submitBtn];

    return footView;
}


-(void)changePassword
{
    if ([self checkInput]) {
        
        [RequestManager postRequestWithURLPath:KULChangePwd withParamer:@{@"password_old":_oldPass.text,@"password":_newsPass.text} completionHandler:^(id responseObject) {
            
            
            NSLog(@"%@",responseObject);
            
            NSDictionary *dic = (NSDictionary *)responseObject[@"data"];
            if ([responseObject[@"result"] integerValue] ==1)
            {
                
                _oldPass.text = @"";
                _newsPass.text = @"";
                _confirmPass.text = @"";
                 [_svc showMessage:dic[@"message"]];
             
                
            }else{
            
            
                [_svc showMessage:dic[@"message"]];
            }
            
            [self finishRequest];
            [_svc hideLoadingView];
          
            
        } failureHandler:^(NSError *error, NSUInteger statusCode) {
            
            [self finishRequest];
            [_svc hideLoadingView];
            [_svc showMessage:error.domain];
            
        }];
    }
}



//检验输入的正确性
-(BOOL)checkInput
{
  
  
    if (!_oldPass.text.length) {
        [MessageTool showMessage:@"原始密码不能为空" isError:YES];
        return NO;
    }
    if (!_newsPass.text.length) {
        [MessageTool showMessage:@"新密码不能为空" isError:YES];
        return NO;
    }
    
    if (!_confirmPass.text.length) {
        [MessageTool showMessage:@"确认密码不能为空" isError:YES];
        return NO;
    }
    if (![_newsPass.text isEqualToString:_confirmPass.text]) {
        [MessageTool showMessage:@"新密码输入的不一致" isError:YES];
        return NO;
    }
  
    if (_oldPass.text.length < 6) {
        [MessageTool showMessage:@"原密码长度至少6位" isError:YES];
        return NO;
    }
    
    if (_newsPass.text.length < 6) {
        [MessageTool showMessage:@"新密码长度至少6位" isError:YES];
        return NO;
    }
    return YES;
}





#pragma mark -----UITableViewDelegate----

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellId";
    UserBehaviorCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[UserBehaviorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        //cell.textField.delegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
            cell.imageView.image        = [UIImage imageNamed:@"lock"];
            cell.textField.keyboardType = UIKeyboardTypeDefault;
            cell.textField.secureTextEntry = YES;
            cell.textField.placeholder  = @"原始密码";
            _oldPass = cell.textField;
            break;
        case 1:
            cell.imageView.image           = [UIImage imageNamed:@"lock"];
            cell.textField.keyboardType    = UIKeyboardTypeDefault;
            cell.textField.secureTextEntry = YES;
            cell.textField.placeholder     = @"新密码";
            _newsPass                       = cell.textField;
            
            break;
        case 2:
            cell.imageView.image           = [UIImage imageNamed:@"lock"];
            cell.textField.keyboardType    = UIKeyboardTypeDefault;
            cell.textField.secureTextEntry = YES;
            cell.textField.placeholder     = @"再次输入密码";
            cell.isHide                    = YES;
            _confirmPass                      = cell.textField;
            break;
        default:
            break;
    }
    cell.textField.font         = shiliuFont;
    return cell;
}







-(BOOL)shouldShowGetMore
{
    return NO;
}

-(BOOL)shouldShowRefresh
{
    return NO;
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
