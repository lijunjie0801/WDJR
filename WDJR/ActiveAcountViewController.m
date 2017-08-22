//
//  ActiveAcountViewController.m
//  WDJR
//
//  Created by lijunjie on 2017/8/3.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import "ActiveAcountViewController.h"
#import "SelectBankViewController.h"
#import "AddressModel.h"
@interface ActiveAcountViewController ()<selectBankDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *labelArray;
@property(nonatomic,strong)UITextField *banktf,*citytf,*persontf,*bankCardtf,*perCardtf,*phoneNumtf,*vertf;
@property(nonatomic,strong)NSArray *tfArray;
//@property(nonatomic,strong)UITextField *banktf,*citytf;
@property (nonatomic, strong) NSString *sms_seq;
@property (nonatomic, strong) NSMutableArray *provinceArray;
@property (nonatomic, strong) UIPickerView *myPickerView;
@property (nonatomic, assign) NSInteger provinceIndex;
@property (nonatomic, assign) NSString*addressStr,*areaId;
@property(nonatomic, strong)UIButton *bigBtn;

@property(nonatomic, strong)NSString *bankId;
@end

@implementation ActiveAcountViewController
-(NSMutableArray *)provinceArray{
    if (!_provinceArray) {
        _provinceArray=[NSMutableArray array];
    }
    return _provinceArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getprovinceData];
    _labelArray=@[@"银行选择",@"开户城市",@"银行卡号",@"绑定手机"];
    _tfArray=@[@"请选择银行",@"请选择开户城市",@"请输入银行卡号",@"请输入银行预留手机号"];
    self.title=@"激活贵州银行存管账户";
    _tableview=[[UITableView alloc]initWithFrame:self.view.bounds];
    _tableview.tableHeaderView=[self setUIView];
    [self.view addSubview:_tableview];

}

-(void)getprovinceData{
    [RequestManager getRequestWithURLPath:KURLAreaList withParamer:nil completionHandler:^(id responseObject) {
        
        NSLog(@"resp:%@",responseObject);
        NSArray *array=responseObject[@"data"][@"list"];
        NSMutableArray *homeModelArray=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            AddressModel *model = [[AddressModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [homeModelArray addObject:model];
        }
        _provinceArray=[homeModelArray mutableCopy];
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        
    }];
    
}
-(UIView *)setUIView{
    UIView *thisView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    thisView.backgroundColor=[UIColor colorWithRed:243.0/255 green:243.0/255 blue:243.0/255 alpha:1.0];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, WIDTH-10, 20)];
    lab.text=@"请绑定持卡人本人的银行卡";
    [thisView addSubview:lab];
    
    UIView *botview=[[UIView alloc]initWithFrame:CGRectMake(10, 40, WIDTH-20, 300)];
    botview.clipsToBounds=YES;
    botview.layer.cornerRadius=10;
    botview.backgroundColor=[UIColor whiteColor];
    [thisView addSubview:botview];
    
    UIButton *submitBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,390 , WIDTH-20, 40)];
     [submitBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[UIColor redColor]];
    submitBtn.layer.cornerRadius=7;
    [thisView addSubview:submitBtn];
    
    
    for (int i=0; i<5; i++) {
        UIImageView *leftIcon=[[UIImageView alloc]init];
     
        leftIcon.frame=CGRectMake(30, 55+60*i, 30, 30);
        
        leftIcon.image=[UIImage imageNamed:[NSString stringWithFormat:@"open%d",i+2]];
        // leftIcon.backgroundColor=[UIColor redColor];
        [thisView addSubview:leftIcon];
    }
    
    for (int i=0; i<4; i++) {
        UIView *sepview=[[UIView alloc]init];
        sepview.backgroundColor=RGB(246, 246, 246);
   
    sepview.frame=CGRectMake(30, 40+60*(i+1), WIDTH-20-40, 1);
        
        [thisView addSubview:sepview];
    }
    
    for (int i=0; i<_labelArray.count; i++) {
        UILabel *lab=[[UILabel alloc]init];
        lab.text=_labelArray[i];
      
        lab.frame=CGRectMake(75, 40+60*i, 100, 60);
        
        [thisView addSubview:lab];
        
        
        UITextField *tf=[[UITextField alloc]init];
        tf.placeholder=_tfArray[i];
     
        tf.frame=CGRectMake(175, 40+60*i, WIDTH-185, 60);
        
        if (i==0||i==1) {
            tf.userInteractionEnabled=NO;
        }
        switch (i) {
            case 0:
                _banktf=tf;
                break;
            case 1:
                _citytf=tf;
                break;
            case 2:
                _bankCardtf=tf;
                break;
            case 3:
                _phoneNumtf=tf;
                break;
            default:
                break;
        }
        [thisView addSubview:tf];
        
    }
    UITextField *vertf=[[UITextField alloc]initWithFrame:CGRectMake(75, 280, 120, 60)];
    vertf.placeholder=@"短信验证码";
    _vertf=vertf;
    vertf.keyboardType=UIKeyboardTypeNumberPad;
    [thisView addSubview:vertf];
    
    UIView *sepview=[[UIView alloc]init];
    sepview.backgroundColor=RGB(246, 246, 246);
    sepview.frame=CGRectMake(WIDTH-20-150, 290, 1, 40);
    [thisView addSubview:sepview];
    
    UIButton *sendVerBtn=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-20-150+20, 280, 120, 60)];
    [sendVerBtn addTarget:self action:@selector(sendeVer:) forControlEvents:UIControlEventTouchUpInside];
    [sendVerBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [sendVerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [thisView addSubview:sendVerBtn];
    
    for (int i=0; i<2; i++) {
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-20-50+10, 60+60*i, 20, 20)];
        img.image=[UIImage imageNamed:@"xia"];
        [thisView addSubview:img];
        
        UIButton *selectBtn=[[UIButton alloc]initWithFrame:CGRectMake(175, 40+60*i, WIDTH-20-175, 60)];
        selectBtn.tag=i;
        [selectBtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        [thisView addSubview:selectBtn];
    }
    return thisView;
    
}
-(void)selectBank:(NSString *)bankName :(NSString *)bankId{
    NSLog(@"%@",bankName);
    _banktf.text=bankName;
    _bankId=bankId;
}
-(void)select:(UIButton *)sender{
    NSLog(@"%ld",sender.tag);
    if (sender.tag==0) {
        SelectBankViewController *sv=[[SelectBankViewController alloc]init];
        sv.delegate=self;
        [self.navigationController pushViewController:sv animated:NO];
        // [_svc pushViewController:_svc.SelectBankViewController];
        
    }else{
        _bigBtn=[[UIButton alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _bigBtn.backgroundColor=[UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:0.3];
        [_bigBtn addTarget:self action:@selector(empty) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.view addSubview:_bigBtn];
        
        _myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,HEIGHT-300,WIDTH,300)];
        _myPickerView.backgroundColor=[UIColor whiteColor];
        [_bigBtn addSubview:_myPickerView];
        _myPickerView.dataSource = self;
        _myPickerView.delegate = self;
        _myPickerView.userInteractionEnabled=YES;
        
        UIButton *cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,HEIGHT-290, 60, 25)];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.userInteractionEnabled=YES;
        [cancelBtn addTarget:self action:@selector(empty) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_bigBtn addSubview:cancelBtn];
        
        UIButton *sureBtn=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-70, HEIGHT-290, 60, 25)];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(comfirmPicker) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_bigBtn addSubview:sureBtn];
    }
}
-(void)empty{
    [_bigBtn removeFromSuperview];
}
//-(void)comfirmPicker{
//    [_bigBtn removeFromSuperview];
//    AddressModel *model = self.provinceArray[self.provinceIndex];
//    NSInteger index = [self.myPickerView selectedRowInComponent:1];
//    NSString *string = [model.name stringByAppendingString:[model.cities[index] objectForKey:@"name"]];
//    NSLog(@"城市：%@",string);
//    _citytf.text=string;
//}
// UIPickerViewDataSource中定义的方法，该方法返回值决定该控件包含多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;// 返回2表明该控件只包含2列
}

//该方法的返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinceArray.count;//第一列显示各个省份
    }else {
        AddressModel *model = self.provinceArray[self.provinceIndex];
        return model.cities.count;//第二列根据第一列选中的省份，显示该省的城市，
    }
}

//UIPickerView中指定列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    if (component==0) {
        // 如果是第一列，宽度为50
        return 150;
    }else
        // 如果是其他列（只有第二列），宽度为80
        return 150;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 40;
}

//当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        //记录当前选中的省份
        self.provinceIndex = [self.myPickerView selectedRowInComponent:0];
        [self.myPickerView reloadComponent:1];
    }
    AddressModel *model = self.provinceArray[self.provinceIndex];
    NSInteger index = [self.myPickerView selectedRowInComponent:1];
    NSString *string = [model.name stringByAppendingString:[model.cities[index] objectForKey:@"name"]];
    self.addressStr=string;
    NSLog(@"%@",self.addressStr);
}

//UIPickerView中指定列和列表项上显示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        AddressModel *model = self.provinceArray[row];
        return model.name;
    }else {
        
        AddressModel *model = self.provinceArray[self.provinceIndex];
        return [model.cities[row] objectForKey:@"name"];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sendeVer:(UIButton *)sender{
    if (_phoneNumtf.text.length == 0) {
        
        [MessageTool showMessage:@"手机号不能为空" isError:YES];
        return;
    }
    if (_bankCardtf.text.length == 0) {
        
        [MessageTool showMessage:@"银行卡号不能为空" isError:YES];
        return;
    }
    [_svc showLoadingWithMessage:@"发送中..." inView:[UIApplication sharedApplication].keyWindow];
    
    [RequestManager postRequestWithURLPath:KURLStringSendsms withParamer:@{@"mobile":_phoneNumtf.text,@"type":@"activation",@"bank_account":_bankCardtf.text,@"mobile_type":@""} completionHandler:^(id responseObject) {
        
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSLog(@"%@",dic);
        if ([dic[@"result"] integerValue]==1) {
            _sms_seq=dic[@"data"][@"sms_seq"];
        }else{
        
            [_svc showMessage:dic[@"data"][@"message"]];
        
            return ;
        }
        [_svc hideLoadingView];
        
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
        
    }];
    
    
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
                [sender setTitle:[NSString stringWithFormat:@"%@秒重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                
                //  sender.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}
-(void)comfirmPicker{
    [_bigBtn removeFromSuperview];
    AddressModel *model = self.provinceArray[self.provinceIndex];
    NSInteger index = [self.myPickerView selectedRowInComponent:1];
    NSString *string = [model.name stringByAppendingString:[model.cities[index] objectForKey:@"name"]];
    NSLog(@"城市：%@",string);
    _citytf.text=string;
    _areaId=[model.cities[index] objectForKey:@"id"];
}
-(void)confirm{
    NSString *bankId=[NSString stringWithFormat:@"%@",_bankId];
    NSString *areaId=[NSString stringWithFormat:@"%@",_areaId];
    NSString *bankNum=_bankCardtf.text;
    NSString *phoneNum=_phoneNumtf.text;
    NSString *verNum=_vertf.text;
    NSString *sms_seq=self.sms_seq;

   if (bankId.length == 0){
        [MessageTool showMessage:@"请选择银行" isError:YES];
        return;
    }else if (areaId.length == 0){
        [MessageTool showMessage:@"请选择开户城市" isError:YES];
        return;
    }else if (bankNum.length == 0){
        [MessageTool showMessage:@"银行卡号不能为空" isError:YES];
        return;
    }else if (phoneNum.length == 0){
        [MessageTool showMessage:@"手机号不能为空" isError:YES];
        return;
    }else if (verNum.length == 0){
        [MessageTool showMessage:@"请填写验证码" isError:YES];
        return;
    }
    
    [RequestManager postRequestWithURLPath:KURLActivate withParamer:@{@"bank_account":bankNum,@"bank_id":bankId,@"address":areaId,@"mobile":phoneNum,@"mobile_sms":verNum,@"sms_seq":sms_seq} completionHandler:^(id responseObject) {
        
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSLog(@"%@",dict);
        if ([dict[@"result"] integerValue]==1) {
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
        
        
        [_svc showMessage:dict[@"data"][@"message"]];
        [_svc hideLoadingView];
        
        
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
        
    }];
    
    
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
