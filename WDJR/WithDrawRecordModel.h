//
//  WithDrawRecordModel.h
//  WDJR
//
//  Created by fyaex001 on 2016/12/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BaseModel.h"

@interface WithDrawRecordModel : BaseModel

@property(nonatomic, strong) NSString *bank_name;//提现银行
@property(nonatomic, strong) NSString *bank_acc;//提现银行卡号
@property(nonatomic, strong) NSString *account;//提现金额
@property(nonatomic, strong) NSString *account_actual;//到账金额
@property(nonatomic, strong) NSString *created_at;//提现时间
@property(nonatomic, strong) NSString *deal_at;//处理时间
@property(nonatomic, strong) NSString *serve_fee;//服务费
@property(nonatomic, strong) NSString *status_display;//状态



+(void)requestWithDrawRecordModelStartDate:(NSString *)startDate andEndData:(NSString *)endDate andPage:(NSInteger)page SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler;

@end
