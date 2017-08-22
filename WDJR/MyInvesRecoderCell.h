//
//  MyInvesRecoderCell.h
//  WDJR
//
//  Created by fyaex001 on 2016/11/8.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInvesRecoderCell : UITableViewCell


@property(nonatomic, strong) UILabel *titlelbl;
@property(nonatomic, strong) UILabel *moneylbl;
@property(nonatomic, strong) UILabel *stateslbl;

+(instancetype)myInvesRecoderCellTableView:(UITableView *)tableView;

@end
