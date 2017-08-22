//
//  MyselfHeaderView.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/2.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "MyselfHeaderView.h"
#import "MyBalanceModel.h"

@interface MyselfHeaderView()

//总资产
@property(nonatomic, strong) UILabel *totalAssets;
@property(nonatomic, strong) UILabel *totalAssetsNum;

//我的账号
@property(nonatomic, strong) UILabel *myAccount;

//冻结金额
@property(nonatomic, strong) UILabel *freezeMoney;



//可用余额
@property(nonatomic, strong) UILabel *avaliableBalance;
@property(nonatomic, strong) UILabel *avaliableBalanceNum;

//充值
@property(nonatomic, strong) UIButton *TopUp;
//提现
@property(nonatomic, strong) UIButton *WithDraw;


@property(nonatomic, strong) UIView *topView;
@property(nonatomic, strong) UIView *bottomView;


@end


@implementation MyselfHeaderView



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [AppAppearance sharedAppearance].mainColor;
        [self addSubview:_topView];
        
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
        [self addSubview:_bottomView];
        
        _totalAssets = [self customLabel:@"总资产(元)"];
        _totalAssets.textAlignment = NSTextAlignmentCenter;
        _totalAssets.font = shisiFont;
        [_topView addSubview:_totalAssets];
        
        
        _totalAssetsNum = [self customLabel:@"___"];
        //_totalAssetsNum.font = shibaFont;
        _totalAssetsNum.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
        _totalAssetsNum.textAlignment = NSTextAlignmentCenter;
        [_topView addSubview:_totalAssetsNum];
        
        
        _myAccount = [self customLabel:@"我的账户:"];
        _myAccount.font = shisiFont;
        [_topView addSubview:_myAccount];

        
        _freezeMoney = [self customLabel:@"冻结金额(元):"];
        _freezeMoney.font = shisiFont;
        _freezeMoney.textAlignment = NSTextAlignmentRight;
        [_topView addSubview:_freezeMoney];
//
//        
//        
//        _iconImg = [[UIImageView alloc] init];
//        _iconImg.image = [UIImage imageNamed:@"bai"];
//        [_topView addSubview:_iconImg];
//        
//        _zichanLbl = [self customLabel:@"交易记录"];
//        [_topView addSubview:_zichanLbl];
        
        _avaliableBalance = [self customLabel:@"可用余额(元)"];
        _avaliableBalance.textColor = [UIColor blackColor];
        _avaliableBalance.font = shiliuFont;
        [_bottomView addSubview:_avaliableBalance];
        
        
        _avaliableBalanceNum = [self customLabel:@"___"];
        _avaliableBalanceNum.font = shibaFont;
        _avaliableBalanceNum.textColor = [UIColor redColor];
        [_bottomView addSubview:_avaliableBalanceNum];
        
        
        _TopUp = [[UIButton alloc] init];
        _TopUp.backgroundColor = [UIColor colorWithRed:230/255.0 green:80/255.0 blue:11/255.0 alpha:1];
        [_TopUp setTitle:@"充值" forState:UIControlStateNormal];
        [_TopUp setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
        _TopUp.titleLabel.font = shisiFont;
        [_TopUp addTarget:self action:@selector(chongzhiClick) forControlEvents:UIControlEventTouchUpInside];
        _TopUp.layer.cornerRadius  = 6;
        _TopUp.layer.masksToBounds = YES;
        _TopUp.tag = 100;
        [_bottomView addSubview:_TopUp];
        
        _WithDraw = [[UIButton alloc] init];
        _WithDraw.backgroundColor = [UIColor colorWithRed:75/255.0 green:178/255.0 blue:214/255.0 alpha:1];
        [_WithDraw setTitle:@"提现" forState:UIControlStateNormal];
        [_WithDraw setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
        _WithDraw.titleLabel.font = shisiFont;
       // [_WithDraw addTarget:self action:@selector(withDrawClick:) forControlEvents:UIControlEventTouchUpInside];
        //给button加上边框
//        _WithDraw.layer.borderColor = [[AppAppearance sharedAppearance].mainColor CGColor];
//        _WithDraw.layer.borderWidth = 1.0f;
        //给button四边加上弧度
        _WithDraw.layer.cornerRadius  = 6;
        _WithDraw.layer.masksToBounds = YES;
        _WithDraw.tag = 101;
        [_bottomView addSubview:_WithDraw];
        
        [_WithDraw addTarget:self action:@selector(tixianClick) forControlEvents:UIControlEventTouchUpInside];
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
//        [_topView addGestureRecognizer:tap];
        
        
        
        
        _totalAssetsNum.text = @"1024.00";
        _avaliableBalanceNum.text = @"1232.23";
        _myAccount.text = @"我的账号:18705608300";
        _freezeMoney.text = @"冻结金额(元):1231.00";
        
    }
    return self;
}


-(void)tixianClick
{
    if ([self.delegate respondsToSelector:@selector(withDrawClick)]) {
        
        [self.delegate withDrawClick];
    }
}

-(void)chongzhiClick
{
    if ([self.delegate respondsToSelector:@selector(topUpClick)]) {
        
        [self.delegate topUpClick];
    }
}


-(void)setMyBankModel:(MyBalanceModel *)myBankModel
{
    _myBankModel = myBankModel;
    
    _totalAssetsNum.text = [NSString stringWithFormat:@"%.2f",[myBankModel.total floatValue]];
    _avaliableBalanceNum.text = [NSString stringWithFormat:@"%.2f",[myBankModel.usable floatValue]];
    _myAccount.text = [NSString stringWithFormat:@"我的账户:%@",[AppDataManager defaultManager].PhoneAccount];
    _freezeMoney.text = [NSString stringWithFormat:@"冻结金额(元):%.2f",[myBankModel.frozen floatValue]];

    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    
    CGFloat viewW = self.bounds.size.width;
    CGFloat viewH = self.bounds.size.height;
    
    _topView.frame    = CGRectMake(0, 0, viewW, viewH/3*2);
    _bottomView.frame = CGRectMake(0, viewH/3*2, viewW, viewH/3);
    
    
    
    
    CGFloat w = (viewW-20)/2;
    CGFloat th = (_topView.frame.size.height-10)/3;
    
    CGFloat bh = (_bottomView.frame.size.height-10)/2;
    
    
    
    
    //总资产
    _totalAssets.frame =CGRectMake((viewW-150)/2, 5, 150 , th*2/2);
    _totalAssetsNum.frame = CGRectMake((viewW-150)/2, th, 150,th*2/2);
    
    //我的账户
    _myAccount.frame =CGRectMake(10, th*2, 160 , th);
  
    //冻结金额
    _freezeMoney.frame   = CGRectMake(viewW-160, th*2, 150, th);
   
   
    //可用余额
    _avaliableBalanceNum.frame = CGRectMake(10, 5, w, bh);
    _avaliableBalance.frame =CGRectMake(10, CGRectGetMaxY(_avaliableBalanceNum.frame), w, bh);
    
    
    
    _WithDraw.frame = CGRectMake(viewW-10-70, (_bottomView.frame.size.height-35)/2, 70, 35);
    _TopUp.frame = CGRectMake(CGRectGetMinX(_WithDraw.frame)-10-70, (_bottomView.frame.size.height-35)/2, 70, 35);
    
    
    
    
    
    
}






//对UILabel的字体属性的设置方法
-(UILabel *)customLabel:(NSString *)title
{
    UILabel *label         = [[UILabel alloc] init];
    label.backgroundColor  = [UIColor clearColor];
    label.textColor        = [AppAppearance sharedAppearance].whiteColor;
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    /*label.font = [UIFont fontWithName:@"Helvetica" size:15.f];
     @"Helvetica"是字体的样式，也就是字体的风格，相当于宋体、楷体等。
     常用的字体有Arial,Helvetica等,要加粗就在其后加"-Bold"，如，@"Helvetica-Bold"。
     */
    //label.font             = [UIFont fontWithName:@"Helvetica-Bold" size:15.f];
    label.font             = shisiFont;
    label.text             = title;
    
    return label;
}





@end
