//
//  HomeModel.h
//  WDJR
//
//  Created by fyaex001 on 2016/11/3.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BaseModel.h"

@interface HomeModel : BaseModel

@property(nonatomic, strong) NSString *title;//标题
@property(nonatomic, strong) NSString *status;//借款状态
@property(nonatomic, strong) NSString *amount; //借款总金额
@property(nonatomic, strong) NSString *repayment;//还款方式
@property(nonatomic, strong) NSString *apr;//年化收益率
@property(nonatomic, strong) NSString * deadline;//借款周期
@property(nonatomic, strong) NSString *amount_has;//已经投的金额
@property(nonatomic, strong) NSString *times;//投资次数
@property(nonatomic, strong) NSString *salt;//产品标识
@property(nonatomic, strong) NSString *is_day;//周期类型
@property(nonatomic, strong) NSString *type_label;//标题前面的文字
@property(nonatomic, strong) NSString *open_at;//开标时间
@property(nonatomic, strong) NSString *repay_at;//还款时间
@property(nonatomic, strong) NSString *progress;//进度


@property(nonatomic, strong) NSNumber *is_secret;//是否为天标

@property(nonatomic, strong) NSArray *pledge;//担保物图片

@property(nonatomic, strong) NSString *type_name;//判断是否为房贷
@property(nonatomic, strong) NSDictionary *houseDic; //房贷的数据
@property(nonatomic, strong) NSString *thumb;//进度背景图片
@property(nonatomic, strong) NSString *apr_add;//加息



//首页中获取
+(void)requestHomeModelCompletionHandler:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler;


//我要理财中获取
+(void)requestHomeModelManagerPage:(NSInteger)page andStatus:(NSInteger)status andDeadline:(NSString *)deadline CompletionHandler:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler;



@end
