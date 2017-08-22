//
//  MessageScrollerModel.h
//  WDJR
//
//  Created by fyaex001 on 2016/10/26.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BaseModel.h"

@interface MessageScrollerModel : BaseModel

@property(nonatomic, strong) NSString *adId;
@property(nonatomic, strong) NSString *adurl;
@property(nonatomic, strong) NSString *type;
@property(nonatomic, strong) NSString *title;

+(void)requestMessageScrollerModelOfCompletionHandler:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler;

@end
