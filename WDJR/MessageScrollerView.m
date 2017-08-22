//
//  MessageScrollerView.m
//  GoodCard
//
//  Created by fyaex001 on 16/8/9.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "MessageScrollerView.h"
#import "MessageScrollerModel.h"
#import "SwitchViewController.h"

@interface MessageScrollerView()

@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,assign)int num;
@property (nonatomic,assign)int num1;

@end


@implementation MessageScrollerView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
    }
    return self;
}


-(void)initUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.num1 = 0;
    self.array = [[NSMutableArray alloc] init];
}


-(void)setDataMessageArray:(NSMutableArray *)dataMessageArray
{
    _array = dataMessageArray;
    
    _num = 0;
    
    CGFloat marginWH = 21;
    
    //移除所有的视图
    [_scrollView removeFromSuperview];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH-120, marginWH)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_scrollView];
    
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = NO;
    _scrollView.scrollEnabled = NO;
    _scrollView.contentSize = CGSizeMake(WIDTH-120, marginWH*(_array.count+1));
    
    
    if (self.array.count !=0) {
        
        for (int i = 0; i<self.array.count; i++) {
            
            MessageScrollerModel * model = (MessageScrollerModel *)self.array[i];
            
            UILabel * titlelbl = [[UILabel alloc]initWithFrame:CGRectMake(0, marginWH*i, WIDTH-120, marginWH)];
            titlelbl.font = shierFont;
            titlelbl.text = model.title;
            titlelbl.textAlignment = NSTextAlignmentLeft;
            titlelbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
            [_scrollView addSubview:titlelbl];
            
            titlelbl.userInteractionEnabled = YES;
            titlelbl.tag = i;
            
            UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(UesrClicked:)];
            [titlelbl addGestureRecognizer:tag];
            
            
        }
        
        
        MessageScrollerModel * model = (MessageScrollerModel *)self.array[0];
        
        UILabel * titlelbl = [[UILabel alloc]initWithFrame:CGRectMake(0, marginWH*_array.count, WIDTH-120, marginWH)];
        titlelbl.font = shierFont;
        titlelbl.text = model.title;
        titlelbl.textAlignment = NSTextAlignmentLeft;
         titlelbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
        [_scrollView addSubview:titlelbl];
        
        titlelbl.userInteractionEnabled = YES;
        titlelbl.tag = 0;
        
        UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(UesrClicked:)];
        [titlelbl addGestureRecognizer:tag];
        
        
        
    }
    
    
    if (_num1 == 0) {
        [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(time) userInfo:nil repeats:YES];
    }
    _num1++;
    
}

- (void)UesrClicked:(UITapGestureRecognizer *)recognizer
{
    MessageScrollerModel * model = (MessageScrollerModel *)self.array[recognizer.view.tag];
    
     [[SwitchViewController sharedSVC] pushViewController:[SwitchViewController sharedSVC].baseWebViewViewController withObjects:@{@"url":model.adurl}];
    
   
}





- (void)time
{
    _num++;
    if (_num == self.array.count+1) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        _num = 0;
    }else{
        [_scrollView setContentOffset:(CGPointMake(0, _num * 21)) animated:YES];
    }
}



@end
