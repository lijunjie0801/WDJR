//
//  MyInvesRecoderCell.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/8.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "MyInvesRecoderCell.h"
#import "MyInvesterModel.h"

@interface MyInvesRecoderCell()



@end

@implementation MyInvesRecoderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createSubViews];
        
    }
    return self;
}


-(void)createSubViews
{
    _titlelbl = [self customLabel:@"借款标题:xxxxxUsr"];
    [self addSubview:_titlelbl];
    
    
    _moneylbl = [self customLabel:@"投标金额:1000000万元"];
    [self addSubview:_moneylbl];
    
    _stateslbl = [self customLabel:@"状态:回款处理中"];
    [self addSubview:_stateslbl];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _titlelbl.frame = CGRectMake(10, 10, WIDTH-20, 21);
    _moneylbl.frame = CGRectMake(10, CGRectGetMaxY(_titlelbl.frame)+5, (WIDTH-20)/2, 21);
    _stateslbl.frame = CGRectMake(WIDTH-125, CGRectGetMaxY(_titlelbl.frame)+5, 115, 21);
    
    
}

+(instancetype)myInvesRecoderCellTableView:(UITableView *)tableView
{
    static NSString *identifier = @"MyInvesRecoderCell";
    
    MyInvesRecoderCell * cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[MyInvesRecoderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
