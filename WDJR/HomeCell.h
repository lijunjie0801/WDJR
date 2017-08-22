//
//  HomeCell.h
//  WDJR
//
//  Created by fyaex001 on 2016/10/26.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeCellDelegate <NSObject>

-(void)touBiaoClick:(NSString *)salt andisSecret:(NSString *)secret;

@end

@class HomeModel;


@interface HomeCell : UITableViewCell



@property(nonatomic, strong) HomeModel *homeModel;
@property(nonatomic, weak) id<HomeCellDelegate> delegate;

+(instancetype)HomeCellWithTableView:(UITableView *)tableView;

@end
