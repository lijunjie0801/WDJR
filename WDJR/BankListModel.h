//
//  BankListModel.h
//  WDJR
//
//  Created by fyaex001 on 2016/12/27.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BaseModel.h"

@interface BankListModel : BaseModel

@property(nonatomic, strong) NSString *bank_id; //唯一编号
@property(nonatomic, strong) NSString *bank_name;//银行卡名称
@property(nonatomic, strong) NSString *bank_ico;//银行卡图标
@property(nonatomic, strong) NSString *account; //卡号
@property(nonatomic, strong) NSNumber *is_default; //是否是默认的卡
@property(nonatomic, strong) NSNumber *is_real; //是否实名认证
@property(nonatomic, strong) NSString *real_name; //姓名
@property(nonatomic, strong) NSString *bank_code; //银行代码


//首页中获取
+(void)requestBankListModelCompletionHandler:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler;


@end
