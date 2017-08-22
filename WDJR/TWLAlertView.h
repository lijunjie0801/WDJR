

#import <UIKit/UIKit.h>
@protocol TWlALertviewDelegate<NSObject>
@optional
-(void)didClickButtonAtIndex:(NSUInteger)index password:(NSString *)password userMoney:(NSString *)money;
- (void)successPassword;
@end
@interface TWLAlertView : UIView<UITextFieldDelegate>
{
    BOOL isShow;
}
@property (nonatomic,strong)UIView *blackView;
@property (strong,nonatomic)UIView * alertview;
@property (strong,nonatomic)NSString * title;
@property (nonatomic,copy)NSString *contentStr;
@property (nonatomic,strong)UILabel *tipLable;
@property (weak,nonatomic) id<TWlALertviewDelegate> delegate;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,assign)NSInteger numBtn;
@property (nonatomic,copy)NSString *password;
@property (nonatomic,retain)NSArray *btnTitleArr;
@property (nonatomic,retain)UITextField *textF;
@property (nonatomic,retain)UITextField *moneyF;
-(void)initWithTitle:(NSString *) title contentStr:(NSString *)content type:(NSInteger)type btnNum:(NSInteger)btnNum btntitleArr:(NSArray *)btnTitleArr;
@end
