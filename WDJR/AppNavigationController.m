

#import "AppNavigationController.h"
#import "AppNavigationBar.h"

@interface AppNavigationController ()

@end

@implementation AppNavigationController


/*
 使用这个初始化使导航控制器使用您的自定义栏类。通过nil navigationBarClass会你UINavigationBar,
 toolbarClass得到UIToolbar nil。的参数,否则必须各自UIKit类的子类。
 */
//使用自定义的导航栏
-(instancetype)init
{
    self = [super initWithNavigationBarClass:[AppNavigationBar class] toolbarClass:nil];
    
    //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeftforView:self.view cache:NO];
    
    if (self) {
        
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = YES;
        }
    }
    
    
    return self;
}




-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}



@end
