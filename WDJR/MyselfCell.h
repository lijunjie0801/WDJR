//
//  MyselfCell.h
//  WDJR
//
//  Created by fyaex001 on 2016/11/2.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyBalanceModel;
@interface MyselfCell : UITableViewCell

@property(nonatomic, strong) MyBalanceModel *myBalanceModel;

+(instancetype)myselfCellWithTableView:(UITableView *)tableView;

@end
