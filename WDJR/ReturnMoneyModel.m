//
//  ReturnMoneyModel.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/11.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "ReturnMoneyModel.h"

@implementation ReturnMoneyModel

/*
 @property(nonatomic, strong) NSString *title;//标题
 @property(nonatomic, strong) NSString *amount;//金额
 @property(nonatomic, strong) NSString *periods;//期数
 @property(nonatomic, strong) NSString *created_at;//投标时间
 @property(nonatomic, strong) NSString *interest_days;//计息天数
 @property(nonatomic, strong) NSString *interest;//利息
 @property(nonatomic, strong) NSString *status;//状态
 @property(nonatomic, strong) NSString *rp_at;//还款时间
 */
+(NSDictionary *)JSONDictionary
{
    return @{
             @"title":@"title",
             @"amount":@"amount",
             @"principle":@"principle",
             @"periods":@"periods",
             @"borrow_num":@"borrow_num",
             @"created_at":@"created_at",
             @"interest_days":@"interest_days",
             @"interest":@"interest",
             @"status":@"status",
             @"end_date":@"end_date"
             };
}





//已经回款的
+(void)requestReturnMoneyModelandPage:(NSInteger)page andStatus:(NSString *)status SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler
{
    NSString *url = [NSString stringWithFormat:@"%@page=%d&status=%@",KULReturnMoney,page,status];
    
    [RequestManager getRequestWithURLPath:url  withParamer:nil completionHandler:^(id responseObject) {
        
        if ([responseObject[@"result"] integerValue]==1) {
            
            responseObject =responseObject[@"data"];
            
            NSArray *dicArray = (NSArray *)responseObject[@"list"];
            
            NSArray *array =[MTLJSONAdapter modelsOfClass:[ReturnMoneyModel class] fromJSONArray:dicArray error:nil];
            
            //[[AppDataManager defaultManager] setHomeData:array];
            successHandle(array);
            
        }else{
            
            
        }
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        failHandler(error,statusCode);
    }];
}


//待收明细
+(void)requestDaiReturnMoneyModelandPage:(NSInteger)page andStatus:(NSString *)status SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler
{
    NSString *url = [NSString stringWithFormat:@"%@page=%d&status=%@",KULReturnMoney,page,status];
    
    [RequestManager getRequestWithURLPath:url  withParamer:nil completionHandler:^(id responseObject) {
        
        
        
        if ([responseObject[@"result"] integerValue]==1) {
            
            responseObject =responseObject[@"data"];
            
            NSArray *dicArray = (NSArray *)responseObject[@"list"];
            
            NSArray *array =[MTLJSONAdapter modelsOfClass:[ReturnMoneyModel class] fromJSONArray:dicArray error:nil];
            
            //[[AppDataManager defaultManager] setHomeData:array];
            successHandle(array);
            
        }else{
            
            
        }
        
        
        
        

        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        failHandler(error,statusCode);
    }];
}


@end
