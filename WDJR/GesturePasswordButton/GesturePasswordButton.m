//
//  GesturePasswordButton.m
//  GZB
//
//  Created by fyaex001 on 16/3/11.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "GesturePasswordButton.h"

#define bounds self.bounds

@implementation GesturePasswordButton
@synthesize selected;
@synthesize success;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        success = YES;
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

//重写画一个图
-(void)drawRect:(CGRect)rect
{
    //画图，设置上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (selected) {
        if (success) {
            CGContextSetRGBStrokeColor(context, 0/255.f, 246/255.f, 255/255.f, 1);//线条颜色
            CGContextSetRGBFillColor(context, 0/255.f, 246/255.f, 255/255.f, 1);
        }else {
        
            CGContextSetRGBStrokeColor(context, 208/255.f, 36/255.f, 36/255.f,1);//线条颜色
            CGContextSetRGBFillColor(context,208/255.f, 36/255.f, 36/255.f,1);
        }
        CGRect frame = CGRectMake(bounds.size.width/2 - bounds.size.width/8+1, bounds.size.height/2 - bounds.size.height/8, bounds.size.width/4, bounds.size.height/4);
        
        CGContextAddEllipseInRect(context, frame);
        CGContextFillPath(context);
    }
    else {
        CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);//线条颜色
    }
    
    CGContextSetLineWidth(context, 2);
    CGRect frame = CGRectMake(2, 2, bounds.size.width-3, bounds.size.height-3);
    CGContextAddEllipseInRect(context, frame);
    CGContextStrokePath(context);
    
    if (success) {
        CGContextSetRGBFillColor(context, 0/255.f, 246/255.f, 255/255.f, 0.3);
    }
    else {
        CGContextSetRGBFillColor(context,208/255.f, 36/255.f, 36/255.f,0.3);
    }
    CGContextAddEllipseInRect(context, frame);
    
    if (selected) {
        CGContextFillPath(context);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
