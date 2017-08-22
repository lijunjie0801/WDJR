//
//  GesturePasswordController.h
//  GZB
//
//  Created by fyaex001 on 16/3/11.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BaseViewController.h"
#import "TentacleView.h"
#import "GesturePasswordView.h"
#import "BaseViewController.h"

@interface GesturePasswordController : BaseViewController<VerificationDelegate,ResetDelegate,GesturePasswordDelegate>


-(void)clear;

@end
