//
//  SecondInvesterModel.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/9.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "SecondInvesterModel.h"

@implementation SecondInvesterModel


+(NSDictionary *)JSONDictionary
{
    return @{
             @"title":@"title",
             @"amount":@"amount",
             @"status":@"status",
             @"created_at":@"created_at",
             @"amount_yes":@"amount_yes",
             @"interest_yes":@"interest_yes",
             @"interest":@"interest",
             @"repay_day":@"repay_day",
             @"start_date":@"start_date",
             @"end_date":@"end_date"
             };
}

+(void)requestSecondInvesterModelStartDate:(NSString *)startDate andEndData:(NSString *)endDate andPage:(NSInteger)page SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler
{
    NSString *url = [NSString stringWithFormat:@"%@start=%@&end=%@&page=%d",KULSecondInvests,startDate,endDate,page];
    [RequestManager getRequestWithURLPath:url  withParamer:nil completionHandler:^(id responseObject) {
        
        
        if ([responseObject[@"result"] integerValue]==1) {
            
            responseObject =responseObject[@"data"];
            
            NSArray *dicArray = (NSArray *)responseObject[@"list"];
            
            NSArray *array =[MTLJSONAdapter modelsOfClass:[SecondInvesterModel class] fromJSONArray:dicArray error:nil];
            
            //[[AppDataManager defaultManager] setHomeData:array];
            successHandle(array);
            
        }else{
        
            
        }
        

        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        failHandler(error,statusCode);
    }];
}


@end
