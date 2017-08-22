//
//  MyInvesterModel.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/9.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "MyInvesterModel.h"

@implementation MyInvesterModel

+(NSDictionary *)JSONDictionary
{
    return @{
             @"title":@"title",
             @"status_display":@"status_display",
             @"amount":@"amount",
             @"reward_tender":@"reward_tender",
             @"reward_keep":@"reward_keep",
             @"interest":@"interest",
             @"collect":@"collect",
             @"way_display":@"way_display",
             @"created_at":@"created_at"
             };
}

+(void)requestMyInvesterModelStartDate:(NSString *)startDate andEndData:(NSString *)endDate andPage:(NSInteger)page SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler
{
    
    
    NSString *url = [NSString stringWithFormat:@"%@start=%@&end=%@&page=%ld",KULMyInvests,startDate,endDate,(long)page];
    [RequestManager getRequestWithURLPath:url  withParamer:nil completionHandler:^(id responseObject) {
        
        
        if ([responseObject[@"result"] integerValue] ==1) {
            
            responseObject =responseObject[@"data"];
            
            NSArray *arrayDic = (NSArray *)responseObject[@"list"];
            
            NSArray *array =[MTLJSONAdapter modelsOfClass:[MyInvesterModel class] fromJSONArray:arrayDic error:nil];
            
            //[[AppDataManager defaultManager] setHomeData:array];
            successHandle(array);
            
        }
        
   
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        failHandler(error,statusCode);
    }];
}




@end
