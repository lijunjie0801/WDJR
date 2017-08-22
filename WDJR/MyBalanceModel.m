//
//  MyBalanceModel.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "MyBalanceModel.h"

@implementation MyBalanceModel

+(NSDictionary *)JSONDictionary
{
    return @{
             @"usable":@"usable",
             @"frozen":@"frozen",
             @"collect":@"collect",
             @"nearest_collect":@"nearest_collect",
             @"nearest_collect_date":@"nearest_collect_date",
             @"invite_url":@"invite_url",
             @"total":@"total"
             };
}

+(void)requestMyBalanceModelSuccessHandle:(SuccessHandle)successHandle failureHandle:(FailedCompletionHander)failureHandle
{
    [RequestManager getRequestWithURLPath:KULMyBalance withParamer:nil completionHandler:^(id responseObject) {
        
        
        
        if ([responseObject[@"result"] integerValue] ==1) {
            
            responseObject = responseObject[@"data"];
            NSDictionary *dic = (NSDictionary *)responseObject[@"info"];
            
            MyBalanceModel *model = [MTLJSONAdapter modelOfClass:[MyBalanceModel class] fromJSONDictionary:dic error:nil];
            
            //把数据存储到缓存中
            //  NSArray *array = [[NSArray alloc] initWithObjects:model, nil];
            //[[AppDataManager defaultManager] setSummaryModelArray:array];
            
            successHandle(model);
            
        }else{
            
             [[NSNotificationCenter defaultCenter] postNotificationName:@"NeedsLogin" object:nil];
        }
        
    
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        failureHandle(error,statusCode);
    }];
}




@end
