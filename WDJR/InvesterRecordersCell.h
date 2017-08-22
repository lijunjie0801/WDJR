//
//  InvesterRecordersCell.h
//  WDJR
//
//  Created by fyaex001 on 2016/11/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InvestRecoderModel;
@interface InvesterRecordersCell : UITableViewCell

@property(nonatomic, strong) InvestRecoderModel *investRecoderModel;

+(instancetype)InvesterRecordersCellWithTableView:(UITableView *)tableView;

@end
