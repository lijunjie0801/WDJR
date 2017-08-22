//
//  AllRecordModel.m
//  WDJR
//
//  Created by fyaex001 on 2016/12/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "AllRecordModel.h"

@implementation AllRecordModel



+(NSDictionary *)JSONDictionary
{
    return @{
             @"amount":@"amount",
             @"usable":@"usable",
             @"created_at":@"created_at",
             @"total":@"total",
             @"type":@"type",
             @"frozen":@"frozen",
             @"collect":@"collect"
             };
}




+(void)requestAllRecordModelStartDate:(NSString *)startDate andEndData:(NSString *)endDate andPage:(NSInteger)page SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler
{
    
    NSString *url = [NSString stringWithFormat:@"%@start=%@&end=%@&page=%ld",KULAllRecord,startDate,endDate,(long)page];
    [RequestManager getRequestWithURLPath:url  withParamer:nil completionHandler:^(id responseObject) {
        
        
        if ([responseObject[@"result"] integerValue] ==1) {
            
            responseObject =responseObject[@"data"];
            
            NSArray *arrayDic = (NSArray *)responseObject[@"list"];
            
            NSArray *array =[MTLJSONAdapter modelsOfClass:[AllRecordModel class] fromJSONArray:arrayDic error:nil];
            
            //[[AppDataManager defaultManager] setHomeData:array];
            successHandle(array);
            
        }
        
        
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        failHandler(error,statusCode);
    }];
    
}

@end
