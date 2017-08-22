//
//  MyBalanceModel.h
//  WDJR
//
//  Created by fyaex001 on 2016/11/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BaseModel.h"

@interface MyBalanceModel : BaseModel

@property(nonatomic, strong) NSString *usable;  //可用余额
@property(nonatomic, strong) NSString *frozen;  //冻结金额
@property(nonatomic, strong) NSString *collect;  //待收余额
@property(nonatomic, strong) NSString *total;  //总金额

@property(nonatomic, strong) NSString *score;  //积分
@property(nonatomic, strong) NSString *voucher;  //代金券
@property(nonatomic, strong) NSString *nearest_collect; //最近待收

@property(nonatomic, strong) NSString *nearest_collect_date; //最近待收时间
@property(nonatomic, strong) NSString *invite_url; //最近待收

+(void)requestMyBalanceModelSuccessHandle:(SuccessHandle)successHandle failureHandle:(FailedCompletionHander)failureHandle;


@end
