//
//  RepaymentScheduleModel.h
//  WDJR
//
//  Created by fyaex001 on 2016/12/12.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BaseModel.h"

@interface RepaymentScheduleModel : BaseModel

@property(nonatomic, strong) NSString *borrow_num;//期数
@property(nonatomic, strong) NSString *repay_date;//还款日
@property(nonatomic, strong) NSString *amount;//还款本息
@property(nonatomic, strong) NSString *principle;//本金
@property(nonatomic, strong) NSString *interest;//利息
@property(nonatomic, strong) NSString *status_display;//还款状态



+(void)requestRepaymentScheduleModelSalt:(NSString *)salt SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler;

@end
