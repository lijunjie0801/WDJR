//
//  TopUpRecordModel.h
//  WDJR
//
//  Created by fyaex001 on 2016/12/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BaseModel.h"

@interface TopUpRecordModel : BaseModel

@property(nonatomic, strong) NSString *ord_id;//订单号
@property(nonatomic, strong) NSString *account;//充值金额
@property(nonatomic, strong) NSString *channel;//充值类型
@property(nonatomic, strong) NSString *status_display;//状态
@property(nonatomic, strong) NSString *created_at;//充值时间
@property(nonatomic, strong) NSString *updated_at;//处理时间



+(void)requestTopUpRecordModelStartDate:(NSString *)startDate andEndData:(NSString *)endDate andPage:(NSInteger)page SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler;

@end
