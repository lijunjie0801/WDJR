//
//  AllRecordModel.h
//  WDJR
//
//  Created by fyaex001 on 2016/12/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BaseModel.h"

@interface AllRecordModel : BaseModel

@property(nonatomic, strong) NSString *amount;//金额
@property(nonatomic, strong) NSString *usable;//可用余额
@property(nonatomic, strong) NSString *created_at;//记录时间
@property(nonatomic, strong) NSString *total;//账户总金额
@property(nonatomic, strong) NSString *type;//操作类型
@property(nonatomic, strong) NSString *frozen;//冻结金额
@property(nonatomic, strong) NSString *collect;//待收金额



+(void)requestAllRecordModelStartDate:(NSString *)startDate andEndData:(NSString *)endDate andPage:(NSInteger)page SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler;

@end
