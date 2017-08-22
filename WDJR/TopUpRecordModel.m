//
//  TopUpRecordModel.m
//  WDJR
//
//  Created by fyaex001 on 2016/12/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "TopUpRecordModel.h"

@implementation TopUpRecordModel



+(NSDictionary *)JSONDictionary
{
    return @{
             @"ord_id":@"ord_id",
             @"account":@"amount",
             @"channel":@"channel",
             @"status_display":@"status_display",
             @"created_at":@"created_at",
             @"updated_at":@"updated_at"
             };
}


+(void)requestTopUpRecordModelStartDate:(NSString *)startDate andEndData:(NSString *)endDate andPage:(NSInteger)page SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler
{
    NSString *url = [NSString stringWithFormat:@"%@start=%@&end=%@&page=%ld",KULTopUpRecord,startDate,endDate,(long)page];
    [RequestManager getRequestWithURLPath:url  withParamer:nil completionHandler:^(id responseObject) {
        
        
        if ([responseObject[@"result"] integerValue] ==1) {
            
            responseObject =responseObject[@"data"];
            
            NSArray *arrayDic = (NSArray *)responseObject[@"list"];
            
            NSArray *array =[MTLJSONAdapter modelsOfClass:[TopUpRecordModel class] fromJSONArray:arrayDic error:nil];
            
            //[[AppDataManager defaultManager] setHomeData:array];
            successHandle(array);
            
        }
        
        
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        failHandler(error,statusCode);
    }];
}




@end
