//
//  SecondInvesterModel.h
//  WDJR
//
//  Created by fyaex001 on 2016/11/9.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BaseModel.h"

@interface SecondInvesterModel : BaseModel


@property(nonatomic, strong) NSString *title;//标题
@property(nonatomic, strong) NSString *amount;//金额
@property(nonatomic, strong) NSString *status;//借款状态
@property(nonatomic, strong) NSString *created_at;//投标时间
@property(nonatomic, strong) NSString *amount_yes;//已收本金
@property(nonatomic, strong) NSString *interest_yes;//已收利息
@property(nonatomic, strong) NSString *interest;//利息
@property(nonatomic, strong) NSString *start_date;//开始时间
@property(nonatomic, strong) NSString *end_date;//结束时间
@property(nonatomic, strong) NSString *repay_day;//还息日

+(void)requestSecondInvesterModelStartDate:(NSString *)startDate andEndData:(NSString *)endDate andPage:(NSInteger)page SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler;


@end
