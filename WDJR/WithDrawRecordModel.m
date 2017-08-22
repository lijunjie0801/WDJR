//
//  WithDrawRecordModel.m
//  WDJR
//
//  Created by fyaex001 on 2016/12/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "WithDrawRecordModel.h"

@implementation WithDrawRecordModel

+(NSDictionary *)JSONDictionary
{
    return @{
             @"bank_name":@"bank_name",
             @"bank_acc":@"bank_acc",
             @"account":@"amount",
             @"account_actual":@"amount_actual",
             @"created_at":@"created_at",
             @"status_display":@"status_display",
             @"deal_at":@"deal_at"
             };
}


+(void)requestWithDrawRecordModelStartDate:(NSString *)startDate andEndData:(NSString *)endDate andPage:(NSInteger)page SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler
{
    NSString *url = [NSString stringWithFormat:@"%@start=%@&end=%@&page=%ld",KULWithdrawRecord,startDate,endDate,(long)page];
    [RequestManager getRequestWithURLPath:url  withParamer:nil completionHandler:^(id responseObject) {
        
        
        if ([responseObject[@"result"] integerValue] ==1) {
            
            responseObject =responseObject[@"data"];
            
            NSArray *arrayDic = (NSArray *)responseObject[@"list"];
            
            NSArray *array =[MTLJSONAdapter modelsOfClass:[WithDrawRecordModel class] fromJSONArray:arrayDic error:nil];
            
            //[[AppDataManager defaultManager] setHomeData:array];
            successHandle(array);
            
        }
        
        
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        failHandler(error,statusCode);
    }];
}

@end
