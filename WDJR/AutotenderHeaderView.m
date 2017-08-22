//
//  AutotenderHeaderView.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/10.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "AutotenderHeaderView.h"
#import "AutoTenderModel.h"

@interface AutotenderHeaderView()

@property(nonatomic, strong) UIView *topView;
@property(nonatomic, strong) UIView *bottomView;
@property(nonatomic, strong) UIView *lineView1;
@property(nonatomic, strong) UIView *lineView2;
@property(nonatomic, strong) UIView *lineView3;
@property(nonatomic, strong) UILabel *TdparMinglbl;//当前排名
@property(nonatomic, strong) UILabel *TdparMingNumlbl;

@property(nonatomic, strong) UILabel *YdayPaiMinglbl;//昨日排名
@property(nonatomic, strong) UILabel *YdayPaiMingNumlbl;

@property(nonatomic, strong) UILabel *parDuiMoneylbl;//排队资金
@property(nonatomic, strong) UILabel *parDuiMoneyNumlbl;


@property(nonatomic, strong) UILabel *yuelbl;//可用余额
@property(nonatomic, strong) UILabel *yueNumlbl;


@end

@implementation AutotenderHeaderView


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
    _topView.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:236/255.0 alpha:1.0];
    [self addSubview:_topView];
    
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [UIColor colorWithRed:247/255.0 green:248/255.0 blue:249/255.0 alpha:1.0];
    [self addSubview:_bottomView];
    
    _lineView1 = [[UIView alloc] init];
    _lineView1.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
    [_topView addSubview:_lineView1];
    _lineView2 = [[UIView alloc] init];
    _lineView2.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
    [_topView addSubview:_lineView2];
    _lineView3 = [[UIView alloc] init];
    _lineView3.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
    [_topView addSubview:_lineView3];
    
    _TdparMinglbl = [self customLabel:@"当前排名"];
    [_topView addSubview:_TdparMinglbl];
    _TdparMingNumlbl = [self customLabel:@"0/0"];
    _TdparMingNumlbl.font = shiliuFont;
    _TdparMingNumlbl.textColor = [AppAppearance sharedAppearance].blackColor;
    [_bottomView addSubview:_TdparMingNumlbl];
    
    _YdayPaiMinglbl = [self customLabel:@"昨日排名"];
    [_topView addSubview:_YdayPaiMinglbl];
    _YdayPaiMingNumlbl = [self customLabel:@"0"];
    _YdayPaiMingNumlbl.font = shiliuFont;
    _YdayPaiMingNumlbl.textColor = [AppAppearance sharedAppearance].blackColor;
    [_bottomView addSubview:_YdayPaiMingNumlbl];
    
    _parDuiMoneylbl = [self customLabel:@"排队资金"];
    [_topView addSubview:_parDuiMoneylbl];
    _parDuiMoneyNumlbl = [self customLabel:@"0元"];
    _parDuiMoneyNumlbl.font = shiliuFont;
    _parDuiMoneyNumlbl.textColor = [AppAppearance sharedAppearance].blackColor;
    [_bottomView addSubview:_parDuiMoneyNumlbl];
    
    _yuelbl = [self customLabel:@"可用余额"];
    [_topView addSubview:_yuelbl];
    _yueNumlbl = [self customLabel:@"0元"];
    _yueNumlbl.font = shiliuFont;
    _yueNumlbl.textColor = [AppAppearance sharedAppearance].blackColor;
    [_bottomView addSubview:_yueNumlbl];
    
    
    
}

-(void)setAutoTenderModel:(AutoTenderModel *)autoTenderModel
{
    _autoTenderModel = autoTenderModel;
    _TdparMingNumlbl.text = [NSString stringWithFormat:@"%@/%@",autoTenderModel.place,autoTenderModel.place_max];
    _YdayPaiMingNumlbl.text = [NSString stringWithFormat:@"%@",autoTenderModel.place_old];
    _parDuiMoneyNumlbl.text = [NSString stringWithFormat:@"%@元",autoTenderModel.amount_wait];
    _yueNumlbl.text = [NSString stringWithFormat:@"%@元",autoTenderModel.usable];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w =self.frame.size.width-20;
    CGFloat h = (self.frame.size.height-20)/2;
    
    _topView.frame = CGRectMake(10, 10, w, h);
    _bottomView.frame = CGRectMake(10, 10+h, w, h);
    
    CGFloat topW = w/4;
    
    _TdparMinglbl.frame = CGRectMake(0, 0, topW, h);
    _TdparMingNumlbl.frame = CGRectMake(0, 0, topW, h);
    
    _lineView1.frame = CGRectMake(topW-1, 0, 2, h);
    
    _YdayPaiMinglbl.frame = CGRectMake(topW, 0, topW, h);
    _YdayPaiMingNumlbl.frame = CGRectMake(topW, 0, topW, h);
    
    _lineView2.frame = CGRectMake(topW*2-1, 0, 2, h);
    
    _parDuiMoneylbl.frame = CGRectMake(topW*2, 0, topW, h);
    _parDuiMoneyNumlbl.frame = CGRectMake(topW*2, 0, topW, h);
    
    _lineView3.frame = CGRectMake(topW*3-1, 0, 2, h);
    
    _yuelbl.frame = CGRectMake(topW*3, 0, topW, h);
    _yueNumlbl.frame = CGRectMake(topW*3, 0, topW, h);
    
    
    
    
    
    
    
    
    
    
}



//对UILabel的字体属性的设置方法
-(UILabel *)customLabel:(NSString *)title
{
    UILabel *label         = [[UILabel alloc] init];
    label.backgroundColor  = [UIColor clearColor];
    label.textColor        = [AppAppearance sharedAppearance].title2TextColor;
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    /*label.font = [UIFont fontWithName:@"Helvetica" size:15.f];
     @"Helvetica"是字体的样式，也就是字体的风格，相当于宋体、楷体等。
     常用的字体有Arial,Helvetica等,要加粗就在其后加"-Bold"，如，@"Helvetica-Bold"。
     */
    //label.font             = [UIFont fontWithName:@"Helvetica-Bold" size:15.f];
    label.textAlignment = NSTextAlignmentCenter;
    label.font             = shisiFont;
    label.text             = title;
    
    return label;
}



@end
