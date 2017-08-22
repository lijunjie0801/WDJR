//
//  BankListModel.m
//  WDJR
//
//  Created by fyaex001 on 2016/12/27.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BankListModel.h"

@implementation BankListModel




+(NSDictionary *)JSONDictionary
{
    return @{
             @"bank_id":@"id",
             @"bank_name":@"bank_name",
             @"bank_ico":@"bank_ico",
             @"account":@"account_no",
             @"is_default":@"is_default",
             @"is_real":@"is_real",
             @"real_name":@"real_name",
             @"bank_code":@"bank_code",
       
             };
}



+(void)requestBankListModelCompletionHandler:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler
{
    [RequestManager getRequestWithURLPath:KURLbankListCard  withParamer:nil completionHandler:^(id responseObject) {
        
        
        
        if ([responseObject[@"result"] integerValue] ==1) {
            
            responseObject = responseObject[@"data"];
            NSArray *dataArray = responseObject[@"list"];
            
            NSArray *array =[MTLJSONAdapter modelsOfClass:[BankListModel class] fromJSONArray:dataArray error:nil];
            
            //[[AppDataManager defaultManager] setHomeData:array];
            successHandle(array);
            
        }else{
            
        }
        
        
        
        
        
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        failHandler(error,statusCode);
    }];
}


@end
