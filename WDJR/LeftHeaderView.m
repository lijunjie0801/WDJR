//
//  LeftHeaderView.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/2.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "LeftHeaderView.h"


@interface LeftHeaderView()


@property(nonatomic, strong) UIImageView *headImg;
@property(nonatomic, strong) UILabel     *titlelbl;


@end

@implementation LeftHeaderView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat imgWH = 60;
        _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, imgWH, imgWH)];
        [_headImg.layer setCornerRadius:CGRectGetHeight([_headImg bounds]) /2];
        _headImg.layer.masksToBounds = YES;
        [self addSubview:_headImg];
        
        _titlelbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImg.frame)+10, (imgWH-21)/2+20, self.frame.size.width-imgWH-20-10, 21)];
        _titlelbl.font = shiliuFont;
        _titlelbl.textColor = [AppAppearance sharedAppearance].whiteColor;
        [self addSubview:_titlelbl];
        
        
        
//        _titlelbl.text = [AppDataManager defaultManager].PhoneAccount;
        _headImg.image = [UIImage imageNamed:@"head"];
        
        
    }
    
    
    return self;
}


-(void)setPhoneStr:(NSString *)phoneStr
{
    _phoneStr = phoneStr;
     _titlelbl.text = phoneStr;
    
}


@end
