//
//  AutoTenderModel.h
//  WDJR
//
//  Created by fyaex001 on 2016/11/16.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BaseModel.h"

@interface AutoTenderModel : BaseModel

@property(nonatomic, strong) NSString *status;//是否开启状态

@property(nonatomic, strong) NSNumber *place;//当前排名

@property(nonatomic, strong) NSNumber *place_max;//总人数

@property(nonatomic, strong) NSNumber *place_old;//昨日排名

@property(nonatomic, strong) NSString *amount_wait;//排队资金

@property(nonatomic, strong) NSString *left;//账户保留金额

@property(nonatomic, strong) NSString *amount_from;//最小投标金额

@property(nonatomic, strong) NSString *amount_to;//最大投标金额

@property(nonatomic, strong) NSString *deadline_day_from;//天标最小期限

@property(nonatomic, strong) NSString *deadline_day_to;//天标最大期限

@property(nonatomic, strong) NSString *deadline_month_from;//月标最小期限

@property(nonatomic, strong) NSString *deadline_month_to;//月标最大期限

@property(nonatomic, strong) NSString *apr;//最小年利化率

@property(nonatomic, strong) NSString *usable;//可用余额



//自动投标展示
+(void)requestAutoTenderModelShowSuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler;



//保存自动投标信息
+(void)requestAutoTenderModelStatus:(NSString *)status andAmount_from:(NSString *)amount_from andAmount_to:(NSString *)amount_to andDeadline_day_from:(NSString *)deadline_day_from andDeadline_day_to:(NSString *)deadline_day_to  andDeadline_month_from:(NSString *)deadline_month_from andDeadline_month_to:(NSString *)deadline_month_to andApr:(NSString *)apr andLeft:(NSString *)left SuccessHandle:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler;








@end
