

#import "LeftCell.h"


@interface LeftCell()



@end

@implementation LeftCell




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
    
}





-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewH= self.bounds.size.height;
    
    _iconImg.frame = CGRectMake(20, (viewH-23)/2, 23, 23);
    _titlelbl.frame = CGRectMake(CGRectGetMaxX(_iconImg.frame)+10, (viewH-23)/2, 100, 23);
    
    _detaillbl.frame = CGRectMake(self.bounds.size.width-150, (viewH-23)/2, 140, 23);
    
   
}



+(instancetype)leftCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"cell";
    
    LeftCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[LeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
