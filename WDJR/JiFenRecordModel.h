//
//  JiFenRecordModel.h
//  WDJR
//
//  Created by fyaex001 on 2016/12/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BaseModel.h"

@interface JiFenRecordModel : BaseModel

@property(nonatomic, strong) NSString *created_at;//时间
@property(nonatomic, strong) NSString *name;//类型
@property(nonatomic, strong) NSString *amount;//数额
@property(nonatomic, strong) NSString *usable;//可用余额
@property(nonatomic, strong) NSString *used;//已使用
@property(nonatomic, strong) NSString *total;//总额
@property(nonatomic, strong) NSString *remark;//备注


+(void)requestJiFenRecordModelStartDate:(NSString *)startDate andEndData:(NSString *)endDate andPage:(NSInteger)page SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler;


@end
