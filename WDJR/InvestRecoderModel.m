//
//  InvestRecoderModel.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "InvestRecoderModel.h"

@implementation InvestRecoderModel

+(NSDictionary *)JSONDictionary
{
    return @{
             @"username":@"username",
             @"status":@"status",
             @"amount":@"amount",
             @"created_at":@"created_at"
             };
}



+(void)requestInvestRecoderModelOfSize:(NSInteger)size andSalt:(NSString *)salt CompletionHandler:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler
{

    NSString *url = [NSString stringWithFormat:@"%@%@/invests?page=%d",KULInvestRecoder,salt,size];
    
    
    [RequestManager getRequestWithURLPath:url  withParamer:nil completionHandler:^(id responseObject) {
        
        
        
        if ([responseObject[@"result"] integerValue] ==1) {
            
            responseObject = responseObject[@"data"];
            NSArray *dataArray = responseObject[@"list"];
            
            NSArray *array =[MTLJSONAdapter modelsOfClass:[InvestRecoderModel class] fromJSONArray:dataArray error:nil];
            
            //[[AppDataManager defaultManager] setHomeData:array];
            successHandle(array);
            
        }else{
            
        }
        
        
      
        

        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        failHandler(error,statusCode);
    }];
    
}




@end
