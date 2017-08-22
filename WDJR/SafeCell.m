//
//  SafeCell.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/16.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "SafeCell.h"


@interface SafeCell()

@property(nonatomic, strong) UIView *line;


@end


@implementation SafeCell

- (id )initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_titleLabel];
        
        _line = [[UIView alloc]initWithFrame:CGRectZero];
        _line.backgroundColor = [AppAppearance sharedAppearance].cellLineColor;
        [self.contentView addSubview:_line];
        
        _mess = [[UILabel alloc]init];
        _mess.hidden = YES;
        [self.contentView addSubview:_mess];
        
    }
    return self;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat offset = 20;
    _titleLabel.frame = CGRectMake(20, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
    _titleLabel.font = shiliuFont;
    _line.frame = CGRectMake(offset, CGRectGetHeight(self.contentView.bounds) - 0.6f, CGRectGetWidth(self.bounds), 0.6);
    _line.hidden = _isHide;
    
    
    _mess.frame = CGRectMake(CGRectGetWidth(self.contentView.bounds) - 25, 15, 15,15);
    _mess.backgroundColor = UIColorFromRGB(0xff2136);
    _mess.clipsToBounds = YES;
    _mess.layer.cornerRadius = 7.5;
    _mess.textColor = [AppAppearance sharedAppearance].whiteColor;
    _mess.textAlignment = NSTextAlignmentCenter;
    _mess.font = shisiFont;
}

+(instancetype)safeCellTableView:(UITableView *)tableView
{
    static NSString *identifier = @"SafeCell";
    
    SafeCell * cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[SafeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
