//
//  SpinView.m
//  SpinViewTest
//
//  Created by yanruichen on 14/10/27.
//  Copyright (c) 2014年 yanruichen. All rights reserved.
//

#import "SpinView.h"

@interface SpinView ()

@property(strong, nonatomic)UIImageView* imageView;

@property(strong, nonatomic)CADisplayLink* displayLink;

@property(nonatomic)CGFloat angle;

@end


@implementation SpinView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotate)];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        _imageView = [[UIImageView alloc] initWithImage:nil];
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _imageView.bounds.size.width, _imageView.bounds.size.height);
        [self addSubview:_imageView];
        [self stopAnimating];
        
    }
    return self;
}

-(void)didMoveToSuperview
{
//    [self startAnimating];
}

-(void)startAnimating {
    if (self.hidesWhenStopped) {
        self.hidden = NO;
    }
    [self.displayLink setPaused:NO];
    
    
}

-(void)stopAnimating {
    if (self.hidesWhenStopped) {
        self.hidden = YES;
    }
    [self.displayLink setPaused:YES];
    
}

- (void)dealloc
{
    [self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)rotate {
    _angle += .1;
    _imageView.layer.transform = CATransform3DMakeRotation(_angle, 0, 0, 1);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
