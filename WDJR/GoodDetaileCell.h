//
//  GoodDetaileCell.h
//  WDJR
//
//  Created by fyaex001 on 2016/11/4.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodDetailCellDelegate<NSObject>

-(void)fengkongClick;

@end

@interface GoodDetaileCell : UITableViewCell


@property(nonatomic,weak) id<GoodDetailCellDelegate> delegate;

+(instancetype)goodDetaileCellWithTableView:(UITableView *)tableView;

@end
