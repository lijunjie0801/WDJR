//
//  HomeCell.m
//  WDJR
//
//  Created by fyaex001 on 2016/10/26.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "HomeCell.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressLabel.h"
#import "HomeModel.h"

@interface HomeCell()

//加息
@property(nonatomic, strong) UIButton *increaseBtn,*increaseRateBtn;

@property(nonatomic, strong) UIButton *titleImgBtn; //标题图片
@property(nonatomic, strong) UILabel *titlelbl;//标题
@property(nonatomic, strong) UILabel *goodTypelbl; //产品类型
@property(nonatomic, strong) UILabel *yearRateNum; //产品年化收益率
@property(nonatomic, strong) UILabel *yearRatelbl;

@property(nonatomic, strong) UILabel *goodCycleNum; //产品周期
@property(nonatomic, strong) UILabel *goodCyclelbl;

@property(nonatomic, strong) UILabel *goodMoneyNum; //产品金额
@property(nonatomic, strong) UILabel *goodMoneylbl;

@property(nonatomic, strong) UIButton *investBtn;//立即投资

@property (nonatomic ,strong) MDRadialProgressView *rateView;


@end


@implementation HomeCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createSubView];
        
    }
    return self;
}


-(void)createSubView
{
    
    _titleImgBtn = [[UIButton alloc] init];
    [_titleImgBtn setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
    _titleImgBtn.titleLabel.font = shierFont;
    [_titleImgBtn setBackgroundImage:[UIImage imageNamed:@"yi"] forState:UIControlStateNormal];
    [self addSubview:_titleImgBtn];
    
    
    
    _titlelbl = [[UILabel alloc] init];
    _titlelbl.font = shisiFont;
    _titlelbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    [self addSubview:_titlelbl];
    
    _goodTypelbl = [[UILabel alloc] init];
    _goodTypelbl.font = shisiFont;
    _goodTypelbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    [self addSubview:_goodTypelbl];
    
    
    //加息
    _increaseBtn = [[UIButton alloc] init];
    [_increaseBtn setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
    _increaseBtn.titleLabel.font = shierFont;
    _increaseBtn.backgroundColor = [AppAppearance sharedAppearance].yellowColor;
    [_increaseBtn setTitle:@"加息" forState:UIControlStateNormal];
    [self addSubview:_increaseBtn];
    
    //加息值
    _increaseRateBtn = [[UIButton alloc] init];
    [_increaseRateBtn setTitleColor:[AppAppearance sharedAppearance].yellowColor forState:UIControlStateNormal];
    _increaseRateBtn.titleLabel.font = shierFont;
    _increaseRateBtn.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
    [self addSubview:_increaseRateBtn];
    
    
    
    _yearRateNum = [[UILabel alloc] init];
    _yearRateNum.font = shiliuFont;
    _yearRateNum.textColor = [AppAppearance sharedAppearance].yellowColor;
    [self addSubview:_yearRateNum];
    
    _yearRatelbl = [[UILabel alloc] init];
    _yearRatelbl.font = shierFont;
    _yearRatelbl.text = @"预期年化收益";
    _yearRatelbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
    [self addSubview:_yearRatelbl];
    
    _goodCycleNum = [[UILabel alloc] init];
    _goodCycleNum.font = shiliuFont;
    _goodCycleNum.textAlignment = NSTextAlignmentCenter;
    _goodCycleNum.textColor = [AppAppearance sharedAppearance].titleTextColor;
    [self addSubview:_goodCycleNum];
    
    _goodCyclelbl = [[UILabel alloc] init];
    _goodCyclelbl.font = shierFont;
    _goodCyclelbl.text = @"项目周期";
    _goodCyclelbl.textAlignment = NSTextAlignmentCenter;
    _goodCyclelbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
    [self addSubview:_goodCyclelbl];
    
    _goodMoneylbl = [[UILabel alloc] init];
    _goodMoneylbl.font = shierFont;
    _goodMoneylbl.text = @"项目金额";
    _goodMoneylbl.textAlignment = NSTextAlignmentCenter;
    _goodMoneylbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
    [self addSubview:_goodMoneylbl];
    
    _goodMoneyNum = [[UILabel alloc] init];
    _goodMoneyNum.font = shiliuFont;
    _goodMoneyNum.textAlignment = NSTextAlignmentCenter;
    _goodMoneyNum.textColor = [AppAppearance sharedAppearance].titleTextColor;
    [self addSubview:_goodMoneyNum];
    
    
     _rateView = [self createRaidProgressView];
    _rateView.label.font = shisiFont;
    _rateView.label.textColor = [AppAppearance sharedAppearance].yellowColor;
    [self addSubview:_rateView];
    
    _investBtn = [[UIButton alloc] init];
   
    [_investBtn setBackgroundImage:[UIImage imageNamed:@"12"] forState:UIControlStateNormal];
    [_investBtn setTitle:@"立即投标" forState:UIControlStateNormal];
    _investBtn.titleLabel.font = shisiFont;
    _investBtn.layer.masksToBounds = YES;
    _investBtn.layer.cornerRadius = 7.0;
    [_investBtn addTarget:self action:@selector(touBiaoBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_investBtn];
    
    
    _titlelbl.text = @"银企P2B融资项目(75-3)LZ2016102401";
    _goodTypelbl.text = @"按天计息 每月付息";
    _yearRateNum.text = @"13.80%";
    _goodCycleNum.text = @"134天";
    _goodMoneyNum.text = @"10万元";
    _rateView.progressCounter = 66;
    _rateView.label.text = @"66%";
    [_titleImgBtn setTitle:@"银" forState:UIControlStateNormal];
}


-(void)touBiaoBtn
{
    if ([self.delegate respondsToSelector:@selector(touBiaoClick:andisSecret:)]) {
        
        [self.delegate touBiaoClick:_homeModel.salt andisSecret:[NSString stringWithFormat:@"%@",_homeModel.is_secret]];
    }
}

-(void)setHomeModel:(HomeModel *)homeModel
{
    _homeModel = homeModel;
    _titlelbl.text = homeModel.title;
    _goodTypelbl.text = homeModel.repayment;
    _yearRateNum.text = [NSString stringWithFormat:@"%@%@",homeModel.apr,@"%"];
    if ([homeModel.is_day integerValue]==0 ) {
        
         _goodCycleNum.text = [NSString stringWithFormat:@"%@月",homeModel.deadline];
    }else {
    
        _goodCycleNum.text = [NSString stringWithFormat:@"%@天",homeModel.deadline];
    }
   
    _goodMoneyNum.text = [NSString stringWithFormat:@"%.f万元",[homeModel.amount floatValue]/10000];
    
    CGFloat progerssNum = [homeModel.amount_has floatValue]/[homeModel.amount floatValue]*100;
    
    if (progerssNum == 0) {
        
        progerssNum = 0.01;
    }
    
    _rateView.progressCounter = progerssNum ;
    _rateView.label.text = [NSString stringWithFormat:@"%@%@",homeModel.progress,@"%"];
    _rateView.label.numberOfLines = 1;
    
    if ([homeModel.status isEqualToString:@"借款中"]) {
        
        [_investBtn setTitle:@"立即投标" forState:UIControlStateNormal];
        
    }else{
    
        [_investBtn setTitle:homeModel.status forState:UIControlStateNormal];
    }
    
    [_titleImgBtn setTitle:homeModel.type_label forState:UIControlStateNormal];
    
    if ([homeModel.apr_add intValue] ==0) {
        
        _increaseBtn.hidden = YES;
        _increaseRateBtn.hidden = YES;
    }else{
    
        _increaseBtn.hidden = NO;
        _increaseRateBtn.hidden = NO;
        NSString *aprAdd = [NSString stringWithFormat:@"%@%%",homeModel.apr_add];
        [_increaseRateBtn setTitle:aprAdd forState:UIControlStateNormal];
        
    }
 
    
}




-(MDRadialProgressView *)createRaidProgressView
{
    MDRadialProgressTheme *theme = [[MDRadialProgressTheme alloc] init];
    theme.completedColor = [AppAppearance sharedAppearance].yellowColor;
    theme.incompletedColor =[UIColor colorWithRed:220/255.0 green:221/255.0 blue:223/255.0 alpha:1];
    theme.centerColor = [UIColor clearColor];
    theme.sliceDividerHidden = YES;
    theme.thickness = 10.0;
    
    MDRadialProgressView *view = [[MDRadialProgressView alloc] initWithFrame:CGRectMake(0, 0, 48, 48) andTheme:theme];
    view.progressTotal = 100;
    view.label.textColor = [UIColor lightTextColor];
    
    return view;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _titleImgBtn.frame = CGRectMake(10, 10, 20, 20);
    
    _titlelbl.frame = CGRectMake(35, 10, WIDTH-110, 22);
    _goodTypelbl.frame = CGRectMake(10, CGRectGetMaxY(_titlelbl.frame)+5, 200, 22);
    
    _increaseRateBtn.frame = CGRectMake( WIDTH-130, CGRectGetMaxY(_titlelbl.frame)+5, 43, 22);
    _increaseRateBtn.layer.cornerRadius = 5;
    _increaseRateBtn.layer.masksToBounds =YES;
    _increaseRateBtn.layer.borderWidth = 1;
    _increaseRateBtn.layer.borderColor = [[AppAppearance sharedAppearance].yellowColor CGColor];
    
    _increaseBtn.frame     = CGRectMake(CGRectGetMinX(_increaseRateBtn.frame)-40, CGRectGetMaxY(_titlelbl.frame)+5, 45, 22);
    _increaseBtn.layer.cornerRadius = 5;
    _increaseBtn.layer.masksToBounds = YES;
    
    
    _rateView.frame = CGRectMake(WIDTH -60,  15, 50, 50);
    
    _investBtn.frame = CGRectMake(WIDTH-80, CGRectGetMaxY(_rateView.frame)+10, 70, 30);
    
    CGFloat w = (WIDTH-90)/3;
    
    _yearRateNum.frame = CGRectMake(10, CGRectGetMaxY(_goodTypelbl.frame)+5, 80, 22);
    _yearRatelbl.frame  = CGRectMake(10, CGRectGetMaxY(_yearRateNum.frame), 85, 22);
    
    _goodCycleNum.frame = CGRectMake(w+10+10, CGRectGetMaxY(_goodTypelbl.frame)+5, 60, 22);
    _goodCyclelbl.frame = CGRectMake(w+10+10, CGRectGetMaxY(_goodCycleNum.frame), 60, 22);
    
    _goodMoneyNum.frame = CGRectMake(w*2+10+10, CGRectGetMaxY(_goodTypelbl.frame)+5, 60, 22);
    _goodMoneylbl.frame = CGRectMake(w*2+10+10, CGRectGetMaxY(_goodMoneyNum.frame), 60, 22);
    
}




+(instancetype)HomeCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"homeCell";
    
    HomeCell * cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
