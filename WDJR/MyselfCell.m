//
//  MyselfCell.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/2.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "MyselfCell.h"
#import "MyBalanceModel.h"

@interface MyselfCell()

@property(nonatomic, strong) UILabel *daishouMoney;//待收金额
@property(nonatomic, strong) UILabel *daiJinQuan;//代金券
@property(nonatomic, strong) UILabel *zuiJinIncome;//最近待收

@property(nonatomic, strong) UILabel *zuiJinIncomeTime;//最近待收时间

//@property(nonatomic, strong) UIView *line1View;
//@property(nonatomic, strong) UIView *line2View;

@property(nonatomic, strong) UIButton *exchangeBtn;


@end

@implementation MyselfCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createSubviews];
    }
    return self;
}


-(void)createSubviews
{
    int totalCol = 3;
    NSArray *titleArray= @[@"待收金额",@"代金券",@"最近待收"];
    
    CGFloat marginTop = 10;
    CGFloat widthHeight = 100;
    
    for (int i = 0; i<titleArray.count; i++) {
        
        CGFloat marginX=((WIDTH -30- totalCol*widthHeight))/(totalCol-1);
        // CGFloat marginY=widthHeight-15;
        CGFloat x=15+(widthHeight+marginX)*(i%totalCol);
        //CGFloat y=marginTop+marginY+(widthHeight+marginY)*(i/totalCol);
        
        UILabel *titlelbl = [[UILabel alloc] initWithFrame:CGRectMake(x, marginTop, widthHeight, 22)];
        titlelbl.textAlignment = NSTextAlignmentCenter;
        titlelbl.font = shisiFont;
        titlelbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
        titlelbl.text = titleArray[i];
        [self addSubview:titlelbl];
        
        if (i==0) {
            
            _daishouMoney = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(titlelbl.frame), widthHeight, 21)];
            _daishouMoney.textAlignment = NSTextAlignmentCenter;
            _daishouMoney.font = shiliuFont;
            [self addSubview:_daishouMoney];
            
        }else if (i == 1){
            
            _daiJinQuan = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(titlelbl.frame), widthHeight, 21)];
            _daiJinQuan.textAlignment = NSTextAlignmentCenter;
            _daiJinQuan.font = shiliuFont;
            [self addSubview:_daiJinQuan];
            
            self.exchangeBtn = [[UIButton alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(_daiJinQuan.frame), widthHeight, 21)];
            self.exchangeBtn.titleLabel.font = shisiFont;
            [self.exchangeBtn setTitle:@"兑换" forState:UIControlStateNormal];
            [self.exchangeBtn setTitleColor:[AppAppearance sharedAppearance].yellowColor forState:UIControlStateNormal];
            [self addSubview:_exchangeBtn];
            [self.exchangeBtn addTarget:self action:@selector(exchangeClick) forControlEvents:UIControlEventTouchUpInside];
            
        
        }else{
        
            _zuiJinIncome = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(titlelbl.frame), widthHeight, 21)];
            _zuiJinIncome.textAlignment = NSTextAlignmentCenter;
            _zuiJinIncome.font = shiliuFont;
            [self addSubview:_zuiJinIncome];
            
            _zuiJinIncomeTime = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(_zuiJinIncome.frame), widthHeight, 21)];
            _zuiJinIncomeTime.textAlignment = NSTextAlignmentCenter;
            _zuiJinIncomeTime.font = shisiFont;
            [self addSubview:_zuiJinIncomeTime];
            
            
            
            
        }
        
    }
    
    
    
    _daishouMoney.text = @"￥0.00";
    _daiJinQuan.text = @"￥0.00";
    _zuiJinIncome.text = @"￥0.00";
    
}


-(void)setMyBalanceModel:(MyBalanceModel *)myBalanceModel
{
    _myBalanceModel = myBalanceModel;
    _daishouMoney.text = [NSString stringWithFormat:@"￥%@",myBalanceModel.collect];
    _daiJinQuan.text  =[NSString stringWithFormat:@"￥%.2f",[myBalanceModel.voucher floatValue]];
    _zuiJinIncome.text  =[NSString stringWithFormat:@"￥%.2f",[myBalanceModel.nearest_collect floatValue]];
    _zuiJinIncomeTime.text = myBalanceModel.nearest_collect_date;
    
}



-(void)exchangeClick
{
    
    [[SwitchViewController sharedSVC] pushViewController:[SwitchViewController sharedSVC].voucherexchangeViewController];
}




+(instancetype)myselfCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"myselfcell";
    
    MyselfCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell=[[MyselfCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
