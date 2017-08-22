//
//  ReturnMoneyModel.h
//  WDJR
//
//  Created by fyaex001 on 2016/11/11.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BaseModel.h"

@interface ReturnMoneyModel : BaseModel

@property(nonatomic, strong) NSString *title;//标题
@property(nonatomic, strong) NSString *amount;//本息
@property(nonatomic, strong) NSString *principle;//本金
@property(nonatomic, strong) NSString *borrow_num;//当前期数
@property(nonatomic, strong) NSString *periods;//期数
@property(nonatomic, strong) NSString *created_at;//投标时间
@property(nonatomic, strong) NSString *interest_days;//计息天数
@property(nonatomic, strong) NSString *interest;//利息
@property(nonatomic, strong) NSString *status;//状态
@property(nonatomic, strong) NSString *end_date;//还款时间


//已经回款
+(void)requestReturnMoneyModelandPage:(NSInteger)page andStatus:(NSString *)status SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler;

//待收明细
+(void)requestDaiReturnMoneyModelandPage:(NSInteger)page andStatus:(NSString *)status SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler;




@end
