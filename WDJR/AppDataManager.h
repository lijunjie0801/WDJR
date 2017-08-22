
#import <Foundation/Foundation.h>

@interface AppDataManager : NSObject


+(instancetype)defaultManager;


@property (readwrite, nonatomic,strong) NSString            * passWord;//登录密码

@property (readwrite, nonatomic,strong) NSString            *PhoneAccount;//登录账号

@property (readwrite, nonatomic,strong) NSString            *token;//登录账号


@property(nonatomic, strong, readwrite) NSString *GPW;//手势密码

@property(nonatomic, strong, readwrite) NSString *payPassWord;//手势开启

@property(nonatomic, assign, readwrite) BOOL      isOff;//手势开启

@property(nonatomic, assign, readwrite) BOOL      isShowGestures;//是否显示手势页面




@property(readwrite,nonatomic, strong) NSString             *Location;//自己的经纬度

@property(readwrite,nonatomic, strong) NSMutableArray       *friendArray;//好友列表

@property(nonatomic, strong, readwrite) NSArray *BannerModelArray; //广告栏的信息

@property(nonatomic, strong, readwrite) NSArray *homeData;//首页品牌车源

@property (readwrite,nonatomic,strong ) NSString            *messageCount;//未读消息数目



-(BOOL)hasLogin;

-(void)logout;

-(BOOL)isChangeUser;

-(void)loginWithIdentifier:(NSString *)identifier;


@end
