//
//  MessageScrollerModel.m
//  WDJR
//
//  Created by fyaex001 on 2016/10/26.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "MessageScrollerModel.h"

@implementation MessageScrollerModel


+(NSDictionary *)JSONDictionary
{

    return @{
             
             @"adId":@"id",
             @"adurl":@"url",
             @"title":@"title",
             @"type":@"type"
             };
}


+(NSValueTransformer *)imgUrlJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}





+(void)requestMessageScrollerModelOfCompletionHandler:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler
{
    [RequestManager getRequestWithURLPath:KURLHomeMessage withParamer:nil completionHandler:^(id responseObject) {
        
        
        
        if ([responseObject[@"result"] integerValue] ==1) {
            
            responseObject = responseObject[@"data"];
            NSArray *dataArray = responseObject[@"list"];
     
            NSArray *array =[MTLJSONAdapter modelsOfClass:[MessageScrollerModel class] fromJSONArray:dataArray error:nil];
            
            //[[AppDataManager defaultManager] setBannerModelArray:array];
            
            successHandle(array);
            
        }else{
            
        }
        
        

        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        failHandler(error,statusCode);
    }];
}



@end
