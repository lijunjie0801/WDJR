//
//  AddressModel.h
//  WDJR
//
//  Created by lijunjie on 2017/8/2.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
 ///存放城市
@property (nonatomic, strong) NSArray *cities;
//省的名称
@property (nonatomic, strong) NSString *name;
@end
