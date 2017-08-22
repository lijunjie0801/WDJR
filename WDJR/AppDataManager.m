//
//  AppDataManager.m
//  BenShiFu
//
//  Created by fyaex001 on 16/8/16.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "AppDataManager.h"


NSString * const appDidLogoutNotification = @"appDidLogoutNotification";
NSString * const appDidLoginNotification =  @"appDidLoginNotification";


static AppDataManager* instance;

@interface AppDataManager()

@property(readonly, nonatomic)NSUserDefaults* userDefaults;
@property(readonly, nonatomic)NSDictionary * userDictionary;

@end

@implementation AppDataManager

+(instancetype)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AppDataManager alloc] init];
    });
    
    return instance;
}

-(NSDictionary *)userDictionary
{
  
    return [self.userDefaults objectForKey:[self PhoneAccount]];
}

-(NSUserDefaults *)userDefaults {
    return [NSUserDefaults standardUserDefaults];
}




//登录账号
-(NSString *)PhoneAccount
{
    return [self.userDefaults objectForKey:@"phoneAccount"];
}

-(void)setPhoneAccount:(NSString *)PhoneAccount
{
  
    [self.userDefaults setObject:PhoneAccount forKey:@"phoneAccount"];
    
    NSDictionary *dic = [self.userDefaults objectForKey:PhoneAccount];
    
    if (!dic) {
        dic = @{@"isOff":@(1)};
        [self.userDefaults setObject:dic forKey:PhoneAccount];
    }
    
    [self.userDefaults synchronize];
}



//保存登录密码
-(void)setPassWord:(NSString *)passWord
{
  
    [self.userDefaults setObject:passWord forKey:@"passWord"];
    [self.userDefaults synchronize];
}

-(NSString *)passWord
{
    
    return [self.userDefaults objectForKey:@"passWord"];
}


//保存token值
-(void)setToken:(NSString *)token
{
    [self.userDefaults setObject:token forKey:@"token"];
    [self.userDefaults synchronize];
}

-(NSString *)token
{
    return [self.userDefaults objectForKey:@"token"];
}

-(void)setGPW:(NSString *)GPW
{
    if (![self userDictionary]) {
        return;
    }
    
    NSMutableDictionary *dic = [self.userDictionary mutableCopy];
    [dic setObject:GPW forKey:@"GPW"];
    
    [self.userDefaults setObject:dic forKey:[self PhoneAccount]];
    [self.userDefaults synchronize];
}


-(NSString *)GPW
{
    return [self.userDictionary objectForKey:@"GPW"];
}




-(void)setIsOff:(BOOL)isOff
{
    if (![self userDictionary]) {
        return;
    }
    NSMutableDictionary *dic= [self.userDictionary mutableCopy];
    [dic setObject:@(isOff) forKey:@"isOff"];
    
    [self.userDefaults setObject:dic forKey:[self PhoneAccount]];
    [self.userDefaults synchronize];
    
    
}

-(BOOL)isOff
{
    return [[self.userDictionary objectForKey:@"isOff"] boolValue];
}

-(BOOL)isIsOff
{
    return [[self.userDictionary objectForKey:@"isOff"] boolValue];
}



-(NSString *)payPassWord
{
    return [self.userDictionary objectForKey:@"payPassWord"];
}

-(void)setPayPassWord:(NSString *)payPassWord
{
    if (![self PhoneAccount ]) {
        return;
    }
    [self.userDefaults setObject:payPassWord forKey:@"payPassWord"];
    [self.userDefaults synchronize];
}









//储存广告栏的信息
-(void)setBannerModelArray:(NSArray *)BannerModelArray
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:BannerModelArray];
    
    [self.userDefaults setObject:data forKey:@"BannerModel"];
    [self.userDefaults synchronize];
    
}

-(NSArray *)BannerModelArray
{
    NSData *data = [self.userDefaults valueForKey:@"BannerModel"];
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return arr;
}


//首页车源
-(void)setHomeData:(NSArray *)homeData
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:homeData];
    [self.userDefaults setObject:data forKey:@"homeData"];
    [self.userDefaults synchronize];
}

-(NSArray *)homeData
{
    NSData *data = [self.userDefaults valueForKey:@"homeData"];
    NSArray *arr2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return arr2;
}


//保存登录密码
//-(void)setPassWord:(NSString *)passWord
//{
//    if (![self identifier]) {
//        return;
//    }
//    [self.userDefaults setObject:passWord forKey:@"passWord"];
//    [self.userDefaults synchronize];
//}
//
//-(NSString *)passWord
//{
//    
//    return [self.userDefaults objectForKey:@"passWord"];
//}

//未读消息数目
-(void)setMessageCount:(NSString *)messageCount
{
 
    [self.userDefaults setObject:messageCount forKey:@"messageCount"];
    [self.userDefaults synchronize];
}

-(NSString *)messageCount
{
    return [self.userDefaults objectForKey:@"messageCount"];
}


-(BOOL)hasLogin
{
    return [self token].length ? YES:NO;
}



-(void)logout {


//    [[AppDataManager defaultManager] setPhoneAccount:@""];
//    [[AppDataManager defaultManager] setPassWord:@""];
    [[AppDataManager defaultManager] setToken:@""];

    
   
}

-(BOOL)isChangeUser
{
    //    if([[UserModel sharedModel].userid isEqualToString:[self identifier]] )
    //    {
    //        return NO;
    //    }
    return YES;
    
}




@end
