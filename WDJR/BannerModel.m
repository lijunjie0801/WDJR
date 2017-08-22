//
//  BannerModel.m
//  WDJR
//
//  Created by fyaex001 on 2016/10/26.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel

+(NSDictionary *)JSONDictionary
{
    return @{
             @"title":@"title",
             @"image":@"image"
             };
}


+(NSValueTransformer *)imgUrlJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}



+(void)requestBannerModelOfCompletionHandler:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler
{
    //NSDictionary *dic = [ParameterFactory parametersOfUserID];
    
    [RequestManager getRequestWithURLPath:KULAdBanner withParamer:nil completionHandler:^(id responseObject) {
        
        
        
        if ([responseObject[@"result"] integerValue] ==1) {
            
            responseObject = responseObject[@"data"];
            NSArray *dataArray = responseObject[@"list"];
            NSArray *array =[MTLJSONAdapter modelsOfClass:[BannerModel class] fromJSONArray:dataArray error:nil];
            
            // [[AppDataManager defaultManager] setBannerModelArray:array];
            
            successHandle(array);
            
        }else{
            
        }
        
  
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        failHandler(error,statusCode);
    }];
}


@end
