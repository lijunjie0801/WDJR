//
//  AutoTenderModel.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/16.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "AutoTenderModel.h"

@implementation AutoTenderModel


+(NSDictionary *)JSONDictionary
{
    return @{
             @"status":@"status",
             @"place":@"place",
             @"place_max":@"place_max",
             @"place_old":@"place_old",
             @"amount_wait":@"amount_wait",
             @"left":@"left",
             @"amount_from":@"amount_from",
             @"amount_to":@"amount_to",
             @"deadline_day_from":@"deadline_day_from",
             @"deadline_day_to":@"deadline_day_to",
             @"deadline_month_from":@"deadline_month_from",
             @"deadline_month_to":@"deadline_month_to",
             @"usable":@"usable",
             @"apr":@"apr"
             };
}



//自动投标展示
+(void)requestAutoTenderModelShowSuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler
{
    
    [RequestManager getRequestWithURLPath:KULZiDongTouBiao withParamer:nil completionHandler:^(id responseObject) {
        
        
        
        if ([responseObject[@"result"] integerValue] ==1) {
            
            responseObject = responseObject[@"data"];
            NSDictionary *dic = responseObject[@"info"];
    
            AutoTenderModel *model = [MTLJSONAdapter modelOfClass:[AutoTenderModel class] fromJSONDictionary:dic error:nil];
//            model.amount_wait = dic[@"amount_wait"];
//            model.place_max   = dic[@"place_max"];
            //把数据存储到缓存中
            //  NSArray *array = [[NSArray alloc] initWithObjects:model, nil];
            //[[AppDataManager defaultManager] setSummaryModelArray:array];
            
            successHandle(model);
            
        }else{
            
            NSDictionary *firstdic = (NSDictionary *)responseObject[@"data"];
            if ([firstdic[@"message"] isEqualToString:@"token_expired"]) {
                
              
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NeedsLogin" object:nil];
                
            }else{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AutoTenderMessage" object:self userInfo:@{@"message":firstdic[@"message"]}];
                
                
            }
            
           
        }
        
 
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        failHandler(error,statusCode);
    }];
    
    
}

//保存自动投标设置
+(void)requestAutoTenderModelStatus:(NSString *)status andAmount_from:(NSString *)amount_from andAmount_to:(NSString *)amount_to andDeadline_day_from:(NSString *)deadline_day_from andDeadline_day_to:(NSString *)deadline_day_to andDeadline_month_from:(NSString *)deadline_month_from andDeadline_month_to:(NSString *)deadline_month_to andApr:(NSString *)apr andLeft:(NSString *)left SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler
{
    
    NSDictionary *param =@{@"status":status,@"amount_from":amount_from,@"amount_to":amount_to,@"deadline_day_from":deadline_day_from,@"deadline_day_to":deadline_day_to,@"deadline_month_from":deadline_month_from,@"deadline_month_to":deadline_month_to,@"apr":apr,@"left":left};
    
    
    [RequestManager postRequestWithURLPath:KULZiDongTouBiao withParamer:param completionHandler:^(id responseObject) {
        
        successHandle(responseObject);
      
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
       failHandler(error,statusCode);
    }];
    
    
}






@end
