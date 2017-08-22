//
//  GoodDetaileCell.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/4.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "GoodDetaileCell.h"

@implementation GoodDetaileCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createSubviews];
    }
    return self;
}


-(void)createSubviews
{
    int totalCol = 4;
    
    NSArray *titleArray= @[@"风控说明",@"保障",@"风险",@"P2B与P2P"];
    NSArray *iconArray= @[@"fk",@"bz",@"fx",@"p2p"];
    
    
    CGFloat marginTop = 10;
    CGFloat widthHeight = 40;
    
    for (int i = 0; i<titleArray.count; i++) {
        
        CGFloat marginX=((WIDTH -60- totalCol*widthHeight))/(totalCol-1);
        // CGFloat marginY=widthHeight-15;
        CGFloat x=30+(widthHeight+marginX)*(i%totalCol);
        //CGFloat y=marginTop+marginY+(widthHeight+marginY)*(i/totalCol);
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, marginTop, widthHeight, widthHeight)];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -15, -60, -15);
        button.titleLabel.font = shierFont;
        [button setBackgroundImage:[UIImage imageNamed:iconArray[i]] forState:UIControlStateNormal];
        button.tag = 100+i;
        
        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
    }
    
}


-(void)buttonClick
{
    if ([self.delegate respondsToSelector:@selector(fengkongClick)]) {
        
        [self.delegate fengkongClick];
    }
}


+(instancetype)goodDetaileCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"GoodDetaileCell";
    
    GoodDetaileCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell=[[GoodDetaileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
