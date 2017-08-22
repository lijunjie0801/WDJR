//
//  InviteRecordModel.m
//  WDJR
//
//  Created by fyaex001 on 2016/12/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "InviteRecordModel.h"

@implementation InviteRecordModel

/*
 @property(nonatomic, strong) NSString *created_at;//邀请时间
 @property(nonatomic, strong) NSString *username;//好友
 @property(nonatomic, strong) NSString *amount;//累积投资额
 @property(nonatomic, strong) NSString *reward;//奖励
 @property(nonatomic, strong) NSString *end_at;//到期时间
 @property(nonatomic, strong) NSString *status_display;//状态
 */
+(NSDictionary *)JSONDictionary
{
    return @{
             @"created_at":@"created_at",
             @"username":@"username",
             @"amount":@"amount",
             @"reward":@"reward",
             @"end_at":@"end_at",
             @"status_display":@"status_display"
             };
}


+(void)requestInviteRecordModelStartDate:(NSString *)startDate andEndData:(NSString *)endDate andPage:(NSInteger)page SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler
{
    NSString *url = [NSString stringWithFormat:@"%@start=%@&end=%@&page=%ld",KULInviteRecord,startDate,endDate,(long)page];
    [RequestManager getRequestWithURLPath:url  withParamer:nil completionHandler:^(id responseObject) {
        
        
        if ([responseObject[@"result"] integerValue] ==1) {
            
            responseObject =responseObject[@"data"];
            
            NSArray *arrayDic = (NSArray *)responseObject[@"list"];
            
            NSArray *array =[MTLJSONAdapter modelsOfClass:[InviteRecordModel class] fromJSONArray:arrayDic error:nil];
            
            //[[AppDataManager defaultManager] setHomeData:array];
            successHandle(array);
            
        }
        
        
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        failHandler(error,statusCode);
    }];
}

@end
