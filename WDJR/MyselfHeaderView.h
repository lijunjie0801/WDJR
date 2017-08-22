//
//  MyselfHeaderView.h
//  WDJR
//
//  Created by fyaex001 on 2016/11/2.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyBalanceModel;


@protocol MyselfHeaderViewDelegate <NSObject>

-(void)withDrawClick;//提现
-(void)topUpClick;//充值

@end



@interface MyselfHeaderView : UIView


@property(nonatomic, strong) MyBalanceModel *myBankModel;

@property(nonatomic, strong) id<MyselfHeaderViewDelegate> delegate;

@end
