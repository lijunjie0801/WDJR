

#import "CommonCell.h"


@interface CommonCell()



@end

@implementation CommonCell




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createSubView];
        
    }
    return self;
}


-(void)createSubView
{
    
    _titlelbl      = [[UILabel alloc] init];
    _titlelbl.font = shiliuFont;
    [self.contentView addSubview:_titlelbl];
    
    _iconImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconImg];
    
    _detaillbl               = [[UILabel alloc] init];
    _detaillbl.textColor     = [AppAppearance sharedAppearance].titleTextColor;
    _detaillbl.font          = shisiFont;
    _detaillbl.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_detaillbl];
    
    _line                               = [[UIView alloc]initWithFrame:CGRectZero];
    _line.backgroundColor               = [AppAppearance sharedAppearance].cellLineColor;
    [self.contentView addSubview:_line];
}





-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewH= self.bounds.size.height;
    
    _iconImg.frame = CGRectMake(10, (viewH-23)/2, 23, 23);
    _titlelbl.frame = CGRectMake(CGRectGetMaxX(_iconImg.frame)+10, (viewH-23)/2, 100, 23);
    
    _detaillbl.frame = CGRectMake(self.bounds.size.width-170, (viewH-23)/2, 140, 23);
    
    _line.frame = CGRectMake(0, CGRectGetHeight(self.contentView.bounds) - 0.6f, CGRectGetWidth(self.contentView.bounds), 0.6);
}



+(instancetype)commonCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"cell";
    
    CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[CommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
