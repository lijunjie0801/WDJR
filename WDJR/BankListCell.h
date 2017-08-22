//
//  BankListCell.h
//  WDJR
//
//  Created by fyaex001 on 2016/12/27.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BankListModel;
@interface BankListCell : UITableViewCell

@property(nonatomic, strong) BankListModel *bankModel;


+(instancetype)BankListModelWithTableView:(UITableView *)tableView;

@end
