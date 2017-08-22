//
//  InvestRecoderModel.h
//  WDJR
//
//  Created by fyaex001 on 2016/11/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BaseModel.h"

@interface InvestRecoderModel : BaseModel

@property(nonatomic, strong) NSString *username;  //用户名
@property(nonatomic, strong) NSString *created_at;//投标时间
@property(nonatomic, strong) NSString *amount; //投标金额
@property(nonatomic, strong) NSString *status; //投标状态


+(void)requestInvestRecoderModelOfSize:(NSInteger)size andSalt:(NSString *)salt CompletionHandler:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler;


@end
