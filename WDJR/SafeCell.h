//
//  SafeCell.h
//  WDJR
//
//  Created by fyaex001 on 2016/11/16.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SafeCell : UITableViewCell


@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic, assign) BOOL isHide;//是否隐藏最后一根线
@property (nonatomic,strong)UILabel *mess; //显示信息的个数



+(instancetype)safeCellTableView:(UITableView *)tableView;


@end
