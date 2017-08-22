//
//  BankListCell.m
//  WDJR
//
//  Created by fyaex001 on 2016/12/27.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BankListCell.h"
#import "BankListModel.h"

@interface BankListCell()

@property(nonatomic, strong) UILabel     *titlelbl;
@property(nonatomic, strong) UILabel     *moRenlbl;
@property(nonatomic, strong) UIImageView *iconImg;
@property(nonatomic, strong) UILabel     *detaillbl;
@property(nonatomic, strong) UIView     *backview;

@end

@implementation BankListCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createSubView];
        
    }
    return self;
}


-(void)createSubView
{
    _backview=[[UIView alloc]init];
    _backview.backgroundColor=RGB(203, 85, 115);
    [self.contentView addSubview:_backview];
    
    _titlelbl      = [[UILabel alloc] init];
    _titlelbl.font = [UIFont systemFontOfSize:20];
    _titlelbl.textColor     = [UIColor whiteColor];
    [self.contentView addSubview:_titlelbl];
    
    _moRenlbl      = [[UILabel alloc] init];
    _moRenlbl.font = [UIFont systemFontOfSize:16];
    _moRenlbl.textColor     = [UIColor whiteColor];
    [self.contentView addSubview:_moRenlbl];
    
//    _iconImg = [[UIImageView alloc] init];
//    [self.contentView addSubview:_iconImg];
    
    _detaillbl               = [[UILabel alloc] init];
    _detaillbl.textColor     = [UIColor whiteColor];
    _detaillbl.font          = [UIFont systemFontOfSize:30];
    _detaillbl.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_detaillbl];
    
}

-(void)setBankModel:(BankListModel *)bankModel
{
    _bankModel = bankModel;
    
    [_iconImg setImageWithURL:[NSURL URLWithString:bankModel.bank_ico]];
    _titlelbl.text = bankModel.bank_name;
    _detaillbl.text = bankModel.account;
    _moRenlbl.text =[NSString stringWithFormat:@"持卡人:%@", bankModel.real_name];

}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewH= self.bounds.size.height;
    _backview.frame=CGRectMake(15, 20, WIDTH-30, (WIDTH-30)/1.8);
    _backview.layer.cornerRadius=10;
    //_iconImg.frame = CGRectMake(20, (viewH-24)/2, 80, 24);
    _titlelbl.frame = CGRectMake(25, 30, 100, 23);
    _moRenlbl.frame = CGRectMake(25,20+(WIDTH-30)/1.8-30, 200, 21);
    
    
    _detaillbl.frame = CGRectMake(15, 20+((WIDTH-30)/1.8-60)/2, WIDTH-30, 60);
    
    
}


+(instancetype)BankListModelWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"cell";
    
    BankListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[BankListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
