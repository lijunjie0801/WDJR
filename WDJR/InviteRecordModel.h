//
//  InviteRecordModel.h
//  WDJR
//
//  Created by fyaex001 on 2016/12/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BaseModel.h"

@interface InviteRecordModel : BaseModel

@property(nonatomic, strong) NSString *created_at;//邀请时间
@property(nonatomic, strong) NSString *username;//好友
@property(nonatomic, strong) NSString *amount;//累积投资额
@property(nonatomic, strong) NSString *reward;//奖励
@property(nonatomic, strong) NSString *end_at;//到期时间
@property(nonatomic, strong) NSString *status_display;//状态


+(void)requestInviteRecordModelStartDate:(NSString *)startDate andEndData:(NSString *)endDate andPage:(NSInteger)page SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler;


@end
