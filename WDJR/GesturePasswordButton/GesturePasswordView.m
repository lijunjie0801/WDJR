

#import "GesturePasswordView.h"
#import "GesturePasswordButton.h"
#import "TentacleView.h"

@implementation GesturePasswordView {
    NSMutableArray * buttonArray;
    
    CGPoint lineStartPoint;
    CGPoint lineEndPoint;
    
}
//@synthesize titleLable;
@synthesize forgetButton;
@synthesize changeButton;

@synthesize tentacleView;
@synthesize state;
@synthesize gesturePasswordDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        buttonArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        //        titleLable = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/2-140, 0, 280, 40)];
        //        titleLable.text = [NSString stringWithFormat:@"hi %@",[AppDataManager defaultManager].identifier];
        //        titleLable.textColor = [AppAppearance sharedAppearance].whiteColor;
        //        [titleLable setTextAlignment:NSTextAlignmentCenter];
        //        [titleLable setFont:[UIFont systemFontOfSize:16.f]];
        //        [self.scrollView addSubview:titleLable];
        
        state = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, frame.size.width, 30)];
        //        state.backgroundColor = [UIColor yellowColor];
        [state setTextAlignment:NSTextAlignmentCenter];
        [state setTextColor:[UIColor redColor]];
        [state setFont:[UIFont systemFontOfSize:14.f]];
        [self addSubview:state];
        
        CGFloat height = self.bounds.size.height - 200;
        CGFloat width;
        if(self.bounds.size.width > height){
            width  = height;
        }else{
            width  = self.bounds.size.width;
            height = width;
        }
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake((frame.size.width - width)/2, state.frame.size.height + state.frame.origin.y +30, width, width)];
        for (int i=0; i<9; i++) {
            NSInteger row = i/3;
            NSInteger col = i%3;
            // Button Frame
            NSInteger distance = width/3;
            NSInteger size = distance/1.5;
            NSInteger margin = size/4;
            GesturePasswordButton * gesturePasswordButton = [[GesturePasswordButton alloc]initWithFrame:CGRectMake(col*distance+margin, row*distance, size, size)];
            [gesturePasswordButton setTag:i];
            [view addSubview:gesturePasswordButton];
            [buttonArray addObject:gesturePasswordButton];
        }
        frame.origin.y = 0;
        [self addSubview:view];
        tentacleView = [[TentacleView alloc]initWithFrame:view.frame];
        [tentacleView setButtonArray:buttonArray];
        [tentacleView setTouchBeginDelegate:self];
        [self addSubview:tentacleView];
        
        forgetButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width/2-150, view.frame.size.height + view.frame.origin.y, 120, 30)];
        [forgetButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [forgetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [forgetButton setTitle:@"忘记手势密码" forState:UIControlStateNormal];
        [forgetButton addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchDown];
        [self addSubview:forgetButton];
        
        
        //        self.scrollView.contentSize = CGSizeMake(self.bounds.size.width, 500);
        //        self.scrollView.scrollEnabled = NO;
        //        [self addSubview:self.scrollView];
        
        //CGRectMake(frame.size.width/2+30, frame.size.height/2+220, 120, 30)
        changeButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width/2+30, view.frame.size.height + view.frame.origin.y, 120, 30)];
        [changeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [changeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [changeButton setTitle:@"用其他账户登录" forState:UIControlStateNormal];
        [changeButton addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchDown];
        [self addSubview:changeButton];
    }
    
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
//    CGFloat colors[] =
//    {
//        134 / 255.0, 157 / 255.0, 147 / 255.0, 1.00,
//        3 / 255.0,  3 / 255.0, 37 / 255.0, 1.00,
//    };
//    CGGradientRef gradient = CGGradientCreateWithColorComponents
//    (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
//    CGColorSpaceRelease(rgb);
//    CGContextDrawLinearGradient(context, gradient,CGPointMake
//                                (0.0,0.0) ,CGPointMake(0.0,self.frame.size.height),
//                                kCGGradientDrawsBeforeStartLocation);
//}

- (void)gestureTouchBegin {
    [self.state setText:@""];
}

-(void)forget{
    [gesturePasswordDelegate forget];
}

-(void)change{
    [gesturePasswordDelegate change];
}


@end
