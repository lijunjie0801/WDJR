//
//  LeftCell.h
//  WDJR
//
//  Created by fyaex001 on 2016/11/2.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftCell : UITableViewCell

@property(nonatomic, strong) UILabel     *titlelbl;
@property(nonatomic, strong) UIImageView *iconImg;
@property(nonatomic, strong) UILabel     *detaillbl;


+(instancetype)leftCellWithTableView:(UITableView *)tableView;
@end
