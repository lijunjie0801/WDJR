//
//  HouseDetailHeaderView.m
//  WDJR
//
//  Created by zlkj on 2017/3/6.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import "HouseDetailHeaderView.h"
#import "HomeModel.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressLabel.h"


@interface HouseDetailHeaderView()

@property(nonatomic, strong) UIView *topView;
@property(nonatomic, strong) UIView *bottomView;




@property(nonatomic, strong) UIImageView *preogressView;
@property(nonatomic, strong) UIImageView *tuiyuanImg;


@property(nonatomic ,strong) MDRadialProgressView *rateView; //比率
@property(nonatomic, strong) UILabel *amountMoneylbl;//项目金额
@property(nonatomic, strong) UIButton *goodtypeBtn;//项目类型


@property(nonatomic, strong) UILabel *yearRateNum; //产品年化收益率
@property(nonatomic, strong) UILabel *yearRatelbl;


@property(nonatomic, strong) UILabel *goodMoneyShengYuNum; //产品金额
@property(nonatomic, strong) UILabel *goodMoneyShengYulbl;

@property(nonatomic, strong) UILabel *goodCycleNum; //产品周期
@property(nonatomic, strong) UILabel *goodCyclelbl;


@property(nonatomic, strong) UILabel *rateLbl;
@property(nonatomic, strong) UILabel *completRate;

@property(nonatomic, strong) UILabel *aprAddLbl; //加息



@end

@implementation HouseDetailHeaderView

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
    
    
    _preogressView = [[UIImageView alloc] init];
    [_topView addSubview:_preogressView];
    
    _tuiyuanImg = [[UIImageView alloc] init];
    _tuiyuanImg.image = [UIImage imageNamed:@"tuoyuan"];
    [_topView addSubview:_tuiyuanImg];
    
    
    
    
    _rateView = [self createRaidProgressView];
    //_rateView.label.font = shibaFont;
    _rateView.label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    _rateView.label.textColor = [AppAppearance sharedAppearance].yellowColor;
//    [_topView addSubview:_rateView];
    
    
    
    
    
    _rateLbl = [self customLabel:@""];
    _rateLbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    _rateLbl.textColor = [AppAppearance sharedAppearance].yellowColor;
    _rateLbl.textAlignment = NSTextAlignmentCenter;
    [_preogressView addSubview:_rateLbl];
    
    _completRate = [self customLabel:@"完成进度"];
    _completRate.font = shisiFont;
    _completRate.textColor = [AppAppearance sharedAppearance].whiteColor;
    _completRate.textAlignment = NSTextAlignmentCenter;
    [_preogressView addSubview:_completRate];
    
    
    _amountMoneylbl = [self customLabel:@"项目金额：10万元"];
    _amountMoneylbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [_topView addSubview:_amountMoneylbl];
    
    _goodtypeBtn = [[UIButton alloc] init];
    _goodtypeBtn.backgroundColor = [AppAppearance sharedAppearance].mainColor;
    [_goodtypeBtn setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
    _goodtypeBtn.titleLabel.font = shierFont;
    
    [_topView addSubview:_goodtypeBtn];
    
    [_goodtypeBtn setTitle:@"每月付息" forState:UIControlStateNormal];
    
    
    _aprAddLbl = [self customLabel:@""];
    _aprAddLbl.textColor = [AppAppearance sharedAppearance].whiteColor;
    _aprAddLbl.textAlignment = NSTextAlignmentLeft;
    _aprAddLbl.font = shierFont;
    [_topView addSubview:_aprAddLbl];
    
    
    
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
    

    
    
    
    CGFloat viewH = self.frame.size.height/3;
    CGFloat topVH = viewH*2/3;
    
    
    _topView.frame = CGRectMake(0, 0, WIDTH, viewH*2+5);
    _bottomView.frame = CGRectMake(0, viewH*2+5, WIDTH, viewH-5);
    
    _rateView.frame = CGRectMake((WIDTH-topVH*2+10)/2, 10, topVH*2-10, topVH*2-10);
    
    _preogressView.frame = CGRectMake((WIDTH-(topVH*2-10)*1.5)/2, 10, (topVH*2-10)*1.5, topVH*2-10);
    _tuiyuanImg.frame = CGRectMake((WIDTH-(topVH*2-10)*1.5)/2, 10, (topVH*2-10)*1.5, topVH*2-10);
    
    
    
    _amountMoneylbl.frame = CGRectMake(0, topVH*2, WIDTH, topVH/2);
    _goodtypeBtn.frame    = CGRectMake((WIDTH-70)/2, topVH*2+topVH/2, 70, topVH/2);
    

    
    
    
    CGFloat lblWidth = 120;
    CGFloat w        =(WIDTH)/3;
    CGFloat h        =(viewH-5)/3;
    
    _yearRateNum.frame = CGRectMake(0, 10, lblWidth, h);
    _yearRatelbl.frame = CGRectMake(0, viewH/2, lblWidth, h);
    
    _goodMoneyShengYuNum.frame = CGRectMake(w, 10, lblWidth, h);
    _goodMoneyShengYulbl.frame = CGRectMake(w, viewH/2, lblWidth, h);
    
    _goodCycleNum.frame = CGRectMake(w*2, 10, lblWidth, h);
    _goodCyclelbl.frame = CGRectMake(w*2, viewH/2, lblWidth, h);
    
    
    
    
//    _rateView.progressCounter = 38;
//    _rateView.label.text = @"38%";
    
}


-(void)setHomeModel:(HomeModel *)homeModel
{
    _homeModel =  homeModel;
    [_goodtypeBtn setTitle:homeModel.repayment forState:UIControlStateNormal];
    
    
    
    [_preogressView setImageWithURL:[NSURL URLWithString:homeModel.thumb] placeholderImage:[UIImage imageNamed:@"image.jpg"]];
    
    [self.tuiyuanImg bringSubviewToFront:self.preogressView];
 
    

    _amountMoneylbl.text = [NSString stringWithFormat:@"项目金额：%.f万元",[homeModel.amount floatValue]/10000];
    _goodMoneyShengYuNum.text = [NSString stringWithFormat:@"%ld元",([homeModel.amount integerValue]-[homeModel.amount_has integerValue])];
    
    _yearRateNum.text = [NSString stringWithFormat:@"%@%@",homeModel.apr,@"%"];
    
    CGFloat progerssNum = [homeModel.amount_has floatValue]/[homeModel.amount floatValue]*100;
    
//    _rateView.progressCounter = progerssNum ;
    if (progerssNum == 0) {
        
        progerssNum = 0.01;
    }
    
    [self.rateView setProgressCounter:progerssNum];
    _rateView.label.text = [NSString stringWithFormat:@"%@%@",homeModel.progress,@"%"];
    
    _rateLbl.text = [NSString stringWithFormat:@"%@%@",homeModel.progress,@"%"];
    
    _rateView.label.numberOfLines = 1;
    
    if ([homeModel.is_day integerValue]==0 ) {
        
        _goodCycleNum.text = [NSString stringWithFormat:@"%@月",homeModel.deadline];
    }else {
        
        _goodCycleNum.text = [NSString stringWithFormat:@"%@天",homeModel.deadline];
    }
    
    
    _rateLbl.frame = CGRectMake(0, _preogressView.frame.size.height/2-21, _preogressView.frame.size.width, 21);
    
    _completRate.frame = CGRectMake(0, CGRectGetMaxY(_rateLbl.frame), _preogressView.frame.size.width, 21);
    
    
    
    CGFloat viewH = self.frame.size.height/3;
    CGFloat topVH = viewH*2/3;
    
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
    
    
    
}




//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//    
////    CGFloat viewH = self.frame.size.height/3;
////    CGFloat topVH = viewH*2/3;
////    
////    
////    _topView.frame = CGRectMake(0, 0, WIDTH, viewH*2+5);
////    _bottomView.frame = CGRectMake(0, viewH*2+5, WIDTH, viewH-5);
////    
////    _rateView.frame = CGRectMake((WIDTH-topVH*2+10)/2, 10, topVH*2-10, topVH*2-10);
////    
////    _preogressView.frame = CGRectMake((WIDTH-(topVH*2-10)*1.5)/2, 10, (topVH*2-10)*1.5, topVH*2-10);
////
////    
////    UIImage * srcImg =_preogressView.image;
////    CGFloat width = srcImg.size.width;
////    CGFloat height = srcImg.size.height-10;
////    //开始绘制图片
////    UIGraphicsBeginImageContext(srcImg.size);
////    CGContextRef gc = UIGraphicsGetCurrentContext();
////    ////绘制Clip区域
////    //我的图片是120*160
////    CGContextAddEllipseInRect(gc, CGRectMake(0, 0,width, height)); //椭圆
////    CGContextClosePath(gc);
////    CGContextClip(gc);
////    //坐标系转换
////    //因为CGContextDrawImage会使用Quartz内的以左下角为(0,0)的坐标系
////    CGContextTranslateCTM(gc, 0, height);
////    CGContextScaleCTM(gc, 1, -1);
////    
////    CGContextDrawImage(gc, CGRectMake(0, 0, width, height), [srcImg CGImage]);
////    //结束绘画
////    UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
////    UIGraphicsEndImageContext();
////    
////    [_preogressView setImage:destImg];
////    
////    
////    
////
//////    _preogressView.layer.cornerRadius = _preogressView.frame.size.width/2.85;
//////    _preogressView.layer.masksToBounds = YES;
////// 
////    //可以根据需求设置边框宽度,颜色
//////    self.preogressView.layer.borderWidth = 2;
//////    self.preogressView.layer.borderColor = [[UIColor whiteColor] CGColor];
////    
////    
////    _amountMoneylbl.frame = CGRectMake(0, topVH*2, WIDTH, topVH/2);
////    _goodtypeBtn.frame    = CGRectMake((WIDTH-70)/2, topVH*2+topVH/2, 70, topVH/2);
////    
////    
////    CGFloat lblWidth = 120;
////    CGFloat w        =(WIDTH)/3;
////    CGFloat h        =(viewH-5)/3;
////    
////    _yearRateNum.frame = CGRectMake(0, 10, lblWidth, h);
////    _yearRatelbl.frame = CGRectMake(0, viewH/2, lblWidth, h);
////    
////    _goodMoneyShengYuNum.frame = CGRectMake(w, 10, lblWidth, h);
////    _goodMoneyShengYulbl.frame = CGRectMake(w, viewH/2, lblWidth, h);
////    
////    _goodCycleNum.frame = CGRectMake(w*2, 10, lblWidth, h);
////    _goodCyclelbl.frame = CGRectMake(w*2, viewH/2, lblWidth, h);
//    
//    
//}



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
