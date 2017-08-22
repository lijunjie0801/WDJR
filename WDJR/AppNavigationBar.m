

#import "AppNavigationBar.h"
#import "UIImage+ImageFromColor.h"
#import "AppAppearance.h"

@interface AppNavigationBar()

@property(nonatomic ,strong)UIImage *storedBackgroundImage;

@end

@implementation AppNavigationBar


//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        _storedBackgroundImage = [UIImage buildImageWithColor:[AppAppearance sharedAppearance].whiteColor];
//        
//        [self setBackgroundImage:_storedBackgroundImage forBarMetrics:UIBarMetricsDefault];
//        
//        NSShadow *shadow = [[NSShadow alloc] init];
//        shadow.shadowColor = [UIColor clearColor];
//        self.titleTextAttributes =@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
//                                    NSForegroundColorAttributeName:[AppAppearance sharedAppearance].blackColor,
//                                    NSShadowAttributeName:shadow};
//        
//        self.shadowImage = [UIImage buildImageWithColor:[UIColor clearColor]];
//        
//     
//    
//    }
//    return self;
//}

-(void)setTransparent:(BOOL)transparent
{
    _transparent = transparent;
    if (transparent) {
        [self setBackgroundImage:[UIImage buildImageWithColor:[UIColor grayColor] ] forBarMetrics:UIBarMetricsDefault];
       
    }else {
        
        [self setBackgroundImage:_storedBackgroundImage forBarMetrics:UIBarMetricsDefault];
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
