//
//  InvesterRecordersCell.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "InvesterRecordersCell.h"
#import "InvestRecoderModel.h"

@interface InvesterRecordersCell()

@property(nonatomic, strong) UILabel *titlelbl;
@property(nonatomic, strong) UILabel *timelbl;
@property(nonatomic, strong) UILabel *moneylbl;
@property(nonatomic, strong) UILabel *stateslbl;


@end

@implementation InvesterRecordersCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createSubViews];
        
    }
    return self;
}


-(void)createSubViews
{
    _titlelbl = [self customLabel:@"用户名:"];
    [self addSubview:_titlelbl];
    
    _timelbl = [self customLabel:@"投标时间:"];
    [self addSubview:_timelbl];
    
    _moneylbl = [self customLabel:@"投标金额:"];
    [self addSubview:_moneylbl];
    
    _stateslbl = [self customLabel:@"状态:"];
    [self addSubview:_stateslbl];
}

-(void)setInvestRecoderModel:(InvestRecoderModel *)investRecoderModel
{
    _investRecoderModel = investRecoderModel;
    
    _titlelbl.text = [NSString stringWithFormat:@"用户名:%@",investRecoderModel.username];
    _timelbl.text = [NSString stringWithFormat:@"投标时间:%@",[investRecoderModel.created_at substringToIndex:10]];
    _moneylbl.text = [NSString stringWithFormat:@"投标金额:%@元",investRecoderModel.amount];
    _stateslbl.text = [NSString stringWithFormat:@"状态:%@",investRecoderModel.status];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _titlelbl.frame = CGRectMake(10, 10, (WIDTH-20)/2, 21);
    _timelbl.frame = CGRectMake((WIDTH-20)/2+10, 10, (WIDTH-20)/2, 21);
    _moneylbl.frame = CGRectMake(10, CGRectGetMaxY(_titlelbl.frame)+5, (WIDTH-20)/2, 21);
    _stateslbl.frame = CGRectMake((WIDTH-20)/2+10, CGRectGetMaxY(_titlelbl.frame)+5, (WIDTH-20)/2, 21);
    
    
}




+(instancetype)InvesterRecordersCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"InvesterRecordersCell";
    
    InvesterRecordersCell * cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[InvesterRecordersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}




//对UILabel的字体属性的设置方法
-(UILabel *)customLabel:(NSString *)title
{
    UILabel *label         = [[UILabel alloc] init];
    label.backgroundColor  = [UIColor clearColor];
    label.textColor        = [AppAppearance sharedAppearance].titleTextColor;
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


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
