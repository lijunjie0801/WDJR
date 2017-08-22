//
//  BannerModel.h
//  WDJR
//
//  Created by fyaex001 on 2016/10/26.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BaseModel.h"

@interface BannerModel : BaseModel

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *image;




+(void)requestBannerModelOfCompletionHandler:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler;



@end
