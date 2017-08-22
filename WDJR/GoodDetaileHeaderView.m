//
//  GoodDetaileHeaderView.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/4.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "GoodDetaileHeaderView.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressLabel.h"
#import "HomeModel.h"


@interface GoodDetaileHeaderView()

@property(nonatomic, strong) UIView *topView;
@property(nonatomic, strong) UIView *bottomView;

@property(nonatomic ,strong) MDRadialProgressView *rateView; //比率
@property(nonatomic, strong) UILabel *amountMoneylbl;//项目金额
@property(nonatomic, strong) UIButton *goodtypeBtn;//项目类型


@property(nonatomic, strong) UILabel *yearRateNum; //产品年化收益率
@property(nonatomic, strong) UILabel *yearRatelbl;


@property(nonatomic, strong) UILabel *goodMoneyShengYuNum; //产品金额
@property(nonatomic, strong) UILabel *goodMoneyShengYulbl;

@property(nonatomic, strong) UILabel *goodCycleNum; //产品周期
@property(nonatomic, strong) UILabel *goodCyclelbl;

@property(nonatomic, strong) UILabel *aprAddLbl; //加息


@end


@implementation GoodDetaileHeaderView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createSubviews];
    }
    
    return self;
}


-(void)createSubviews
{
    _topView = [[UIView alloc] init];
    _topView.backgroundColor = [AppAppearance sharedAppearance].mainColor;
    [self addSubview:_topView];
    
    _rateView = [self createRaidProgressView];
    //_rateView.label.font = shibaFont;
    _rateView.label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    _rateView.label.textColor = [AppAppearance sharedAppearance].yellowColor;
    [_topView addSubview:_rateView];
    

    _amountMoneylbl = [self customLabel:@"项目金额：10万元"];
    _amountMoneylbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [_topView addSubview:_amountMoneylbl];
    
    _goodtypeBtn = [[UIButton alloc] init];
    _goodtypeBtn.backgroundColor = [AppAppearance sharedAppearance].mainColor;
    [_goodtypeBtn setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
    _goodtypeBtn.titleLabel.font = shierFont;
    [_topView addSubview:_goodtypeBtn];
    
    
    _aprAddLbl = [self customLabel:@""];
    _aprAddLbl.textColor = [AppAppearance sharedAppearance].whiteColor;
    _aprAddLbl.textAlignment = NSTextAlignmentLeft;
    _aprAddLbl.font = shierFont;
    [_topView addSubview:_aprAddLbl];
    
    
    
    
    [_goodtypeBtn setTitle:@"每月付息" forState:UIControlStateNormal];
    
    
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
    [self addSubview:_bottomView];
    
    _yearRateNum = [self customLabel:@"13.80%"];
    _yearRateNum.textColor = [AppAppearance sharedAppearance].yellowColor;
    _yearRateNum.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    [_bottomView addSubview:_yearRateNum];
    
    _yearRatelbl = [self customLabel:@"预期年化收益"];
    _yearRatelbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
    [_bottomView addSubview:_yearRatelbl];
    
    
    
    _goodMoneyShengYuNum = [self customLabel:@"6.2万元"];
    _goodMoneyShengYuNum.textColor = [AppAppearance sharedAppearance].blackColor;
    _goodMoneyShengYuNum.font = shiliuFont;
    [_bottomView addSubview:_goodMoneyShengYuNum];
    
    _goodMoneyShengYulbl = [self customLabel:@"剩余金额"];
    _goodMoneyShengYulbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
    [_bottomView addSubview:_goodMoneyShengYulbl];
    
    
    _goodCycleNum = [self customLabel:@"134天"];
    _goodCycleNum.textColor = [AppAppearance sharedAppearance].blackColor;
    _goodCycleNum.font = shiliuFont;
    [_bottomView addSubview:_goodCycleNum];
    
    _goodCyclelbl = [self customLabel:@"项目周期"];
    _goodCyclelbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
    [_bottomView addSubview:_goodCyclelbl];
    

    
    
    _rateView.progressCounter = 38;
    _rateView.label.text = @"38%";
    
}


-(void)setHomeModel:(HomeModel *)homeModel
{
    _homeModel =  homeModel;
    [_goodtypeBtn setTitle:homeModel.repayment forState:UIControlStateNormal];
    
    _amountMoneylbl.text = [NSString stringWithFormat:@"项目金额：%.f万元",[homeModel.amount floatValue]/10000];
    _goodMoneyShengYuNum.text = [NSString stringWithFormat:@"%ld元",([homeModel.amount integerValue]-[homeModel.amount_has integerValue])];
    
    _yearRateNum.text = [NSString stringWithFormat:@"%@%@",homeModel.apr,@"%"];
    
    CGFloat progerssNum = [homeModel.amount_has floatValue]/[homeModel.amount floatValue]*100;
    
    _rateView.progressCounter = progerssNum ;
    _rateView.label.text = [NSString stringWithFormat:@"%@%@",homeModel.progress,@"%"];
    _rateView.label.numberOfLines = 1;
    
    if ([homeModel.is_day integerValue]==0 ) {
        
        _goodCycleNum.text = [NSString stringWithFormat:@"%@月",homeModel.deadline];
    }else {
        
        _goodCycleNum.text = [NSString stringWithFormat:@"%@天",homeModel.deadline];
    }
    
//    CGFloat viewH = self.frame.size.height/3;
//    CGFloat topVH = viewH*2/3;
//    
//    if ([homeModel.apr_add integerValue] ==0) {
//        
//        self.aprAddLbl.hidden = YES;
//        
//        //给button加上边框
//        _goodtypeBtn.layer.borderColor = [[AppAppearance sharedAppearance].whiteColor CGColor];
//        _goodtypeBtn.layer.borderWidth = 1.0f;
//        //给button四边加上弧度
//        _goodtypeBtn.layer.cornerRadius  = 6;
//        _goodtypeBtn.layer.masksToBounds = YES;
//        _goodtypeBtn.frame    = CGRectMake((WIDTH-70)/2, topVH*2+topVH/2, 70, topVH/2);
//        
//    }else{
//    
//        self.aprAddLbl.hidden = NO;
//        self.aprAddLbl.text = [NSString stringWithFormat:@"加息：%@%%",homeModel.apr_add];
//        _goodtypeBtn.frame    = CGRectMake(WIDTH/2-80, topVH*2+topVH/2, 70, topVH/2);
//        _aprAddLbl.frame      = CGRectMake(WIDTH/2+10, topVH*2+topVH/2, 70, topVH/2);
//    }
    
}




-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewH = self.frame.size.height/3;
    CGFloat topVH = viewH*2/3;
    
    
    _topView.frame = CGRectMake(0, 0, WIDTH, viewH*2+5);
    _bottomView.frame = CGRectMake(0, viewH*2+5, WIDTH, viewH-5);
    
    _rateView.frame = CGRectMake((WIDTH-topVH*2+10)/2, 10, topVH*2-10, topVH*2-10);
    
    _amountMoneylbl.frame = CGRectMake(0, topVH*2, WIDTH, topVH/2);
//    _goodtypeBtn.frame    = CGRectMake((WIDTH-70)/2, topVH*2+topVH/2, 70, topVH/2);
//    _aprAddLbl.frame      = CGRectMake(WIDTH/2+10, topVH*2+topVH/2, 70, topVH/2);
    
    if ([_homeModel.apr_add integerValue] ==0) {
        
        self.aprAddLbl.hidden = YES;
        
        //给button加上边框
        _goodtypeBtn.layer.borderColor = [[AppAppearance sharedAppearance].whiteColor CGColor];
        _goodtypeBtn.layer.borderWidth = 1.0f;
        //给button四边加上弧度
        _goodtypeBtn.layer.cornerRadius  = 6;
        _goodtypeBtn.layer.masksToBounds = YES;
        _goodtypeBtn.frame    = CGRectMake((WIDTH-70)/2, topVH*2+topVH/2, 70, topVH/2);
        
    }else{
        
        self.aprAddLbl.hidden = NO;
        self.aprAddLbl.text = [NSString stringWithFormat:@"加息：%@%%",_homeModel.apr_add];
        _goodtypeBtn.frame    = CGRectMake(WIDTH/2-80, topVH*2+topVH/2, 70, topVH/2);
        _aprAddLbl.frame      = CGRectMake(WIDTH/2+10, topVH*2+topVH/2, WIDTH/2-10, topVH/2);
    }
    
    
    
    
    CGFloat lblWidth = 120;
    CGFloat w        =(WIDTH)/3;
    CGFloat h        =(viewH-5)/3;
    
    _yearRateNum.frame = CGRectMake(0, 10, lblWidth, h);
    _yearRatelbl.frame = CGRectMake(0, viewH/2, lblWidth, h);
    
    _goodMoneyShengYuNum.frame = CGRectMake(w, 10, lblWidth, h);
    _goodMoneyShengYulbl.frame = CGRectMake(w, viewH/2, lblWidth, h);
    
    _goodCycleNum.frame = CGRectMake(w*2, 10, lblWidth, h);
    _goodCyclelbl.frame = CGRectMake(w*2, viewH/2, lblWidth, h);
    
    
}



-(MDRadialProgressView *)createRaidProgressView
{
    MDRadialProgressTheme *theme = [[MDRadialProgressTheme alloc] init];
    theme.completedColor = [AppAppearance sharedAppearance].yellowColor;
    theme.incompletedColor =[AppAppearance sharedAppearance].pageBackgroundColor;
    theme.centerColor = [AppAppearance sharedAppearance].whiteColor;
    theme.sliceDividerHidden = YES;
    theme.thickness = 15.0;
    
    CGFloat viewH = self.frame.size.height/3;
    CGFloat topVH = viewH*2/3;
    
    MDRadialProgressView *view = [[MDRadialProgressView alloc] initWithFrame:CGRectMake(0, 0, topVH*2-10, topVH*2-10) andTheme:theme];
    view.progressTotal = 100;
  //  view.label.textColor = [UIColor lightTextColor];
  
    view.wanChen = @"完成进度";
    
    return view;
}


//对UILabel的字体属性的设置方法
-(UILabel *)customLabel:(NSString *)title
{
    UILabel *label         = [[UILabel alloc] init];
    //label.backgroundColor  = [UIColor clearColor];
    label.textColor        = [AppAppearance sharedAppearance].whiteColor;
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    /*label.font = [UIFont fontWithName:@"Helvetica" size:15.f];
     @"Helvetica"是字体的样式，也就是字体的风格，相当于宋体、楷体等。
     常用的字体有Arial,Helvetica等,要加粗就在其后加"-Bold"，如，@"Helvetica-Bold"。
     */
    //label.font             = [UIFont fontWithName:@"Helvetica-Bold" size:15.f];
    label.font             = shierFont;
    label.text             = title;
    label.textAlignment =  NSTextAlignmentCenter;
    
    return label;
}





@end
