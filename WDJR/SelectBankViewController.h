//
//  SelectBankViewController.h
//  WDJR
//
//  Created by lijunjie on 2017/8/2.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
@protocol selectBankDelegate<NSObject>
-(void)selectBank:(NSString *)bankName:(NSString *)bankId;
@end
@interface SelectBankViewController : BaseTableViewController
@property(nonatomic, weak)id<selectBankDelegate>delegate;
@end
