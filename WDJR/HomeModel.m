//
//  HomeModel.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/3.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

/*
 @property(nonatomic, strong) NSString *title;//标题
 @property(nonatomic, strong) NSString *state;//借款状态
 @property(nonatomic, strong) NSString *amount; //借款总金额
 @property(nonatomic, strong) NSString *repayment;//还款方式
 @property(nonatomic, strong) NSString *apr;//年化收益率
 @property(nonatomic, strong) NSString * deadline;//借款周期
 @property(nonatomic, strong) NSString *amount_has;//已经投的金额
 */
+(NSDictionary *)JSONDictionary
{
    return @{
             @"title":@"title",
             @"status":@"status",
             @"amount":@"amount",
             @"repayment":@"repayment",
             @"apr":@"apr",
             @"deadline":@"deadline",
             @"is_day":@"is_day",
             @"type_label":@"type_label",
             @"salt":@"salt",
             @"times":@"times",
             @"open_at":@"open_at",
             @"repay_at":@"repay_at",
             @"progress":@"progress",
             @"pledge":@"pledge",
             @"is_secret":@"is_secret",
             @"type_name":@"type_name",
             @"houseDic":@"house",
             @"thumb":@"thumb",
             @"apr_add":@"apr_add",
             @"amount_has":@"amount_has"
             };
}


//-(void)setValue:(id)value forKey:(NSString *)key
//{
//    NSLog(@"没有发现这个字段==%@",key);
//}


//首页中获取数据
+(void)requestHomeModelCompletionHandler:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler
{
    
    [RequestManager getRequestWithURLPath:[NSString stringWithFormat:@"%@6",KULhomeTouBiao]  withParamer:nil completionHandler:^(id responseObject) {
        
        
        
        if ([responseObject[@"result"] integerValue] ==1) {
            
            responseObject = responseObject[@"data"];
            NSArray *dataArray = responseObject[@"list"];
            
            NSArray *array =[MTLJSONAdapter modelsOfClass:[HomeModel class] fromJSONArray:dataArray error:nil];
            
            //[[AppDataManager defaultManager] setHomeData:array];
            successHandle(array);
            
        }else{
            
        }
        
        
        

        
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        failHandler(error,statusCode);
    }];
}


//我要理财中获取数据
+(void)requestHomeModelManagerPage:(NSInteger)page andStatus:(NSInteger)status andDeadline:(NSString *)deadline CompletionHandler:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler
{
    NSString *url = [NSString stringWithFormat:@"%@&status=%ld&deadline=%@&page=%ld",KULBorrowList,(long)status,deadline,(long)page];
    
    [RequestManager getRequestWithURLPath:url withParamer:nil completionHandler:^(id responseObject) {
        
        
        
        if ([responseObject[@"result"] integerValue] ==1) {
            
            responseObject = responseObject[@"data"];
            NSArray *dataArray = responseObject[@"list"];
            
            NSArray *array =[MTLJSONAdapter modelsOfClass:[HomeModel class] fromJSONArray:dataArray error:nil];
            
            //[[AppDataManager defaultManager] setHomeData:array];
            successHandle(array);
        }else{
            
        }
        
        
    
        
    
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        failHandler(error,statusCode);
    }];
    
}




@end
