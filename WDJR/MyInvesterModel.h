//
//  MyInvesterModel.h
//  WDJR
//
//  Created by fyaex001 on 2016/11/9.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BaseModel.h"

@interface MyInvesterModel : BaseModel

@property(nonatomic, strong) NSString *title;//标题
@property(nonatomic, strong) NSString *amount;//金额
@property(nonatomic, strong) NSString *status_display;//借款状态
@property(nonatomic, strong) NSString *created_at;//投标时间
@property(nonatomic, strong) NSString *reward_tender;//投标奖励
@property(nonatomic, strong) NSString *reward_keep;//续投奖励
@property(nonatomic, strong) NSString *interest;//利息
@property(nonatomic, strong) NSString *collect;//续投奖励
@property(nonatomic, strong) NSString *way_display;//投标方式

+(void)requestMyInvesterModelStartDate:(NSString *)startDate andEndData:(NSString *)endDate andPage:(NSInteger)page SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler;



@end
