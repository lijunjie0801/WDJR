//
//  RepaymentScheduleModel.m
//  WDJR
//
//  Created by fyaex001 on 2016/12/12.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "RepaymentScheduleModel.h"

@implementation RepaymentScheduleModel
+(NSDictionary *)JSONDictionary
{
    return @{
             @"borrow_num":@"borrow_num",
             @"repay_date":@"repay_date",
             @"amount":@"amount",
             @"principle":@"principle",
             @"interest":@"interest",
             @"status_display":@"status_display"
    
             };
}

+(void)requestRepaymentScheduleModelSalt:(NSString *)salt SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler
{
 
    NSString *url = [NSString stringWithFormat:@"%@%@/repays",KULRepaymentSchdlue,salt];
    [RequestManager getRequestWithURLPath:url  withParamer:nil completionHandler:^(id responseObject) {
        
        
        if ([responseObject[@"result"] integerValue]==1) {
            
            responseObject =responseObject[@"data"];
            
            NSArray *dicArray = (NSArray *)responseObject[@"list"];
            
            NSArray *array =[MTLJSONAdapter modelsOfClass:[RepaymentScheduleModel class] fromJSONArray:dicArray error:nil];
            
            //[[AppDataManager defaultManager] setHomeData:array];
            successHandle(array);
            
        }else{
            
            
        }
        
        
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        failHandler(error,statusCode);
    }];
}



@end
