//
//  SpinView.h
//  SpinViewTest
//
//  Created by yanruichen on 14/10/27.
//  Copyright (c) 2014年 yanruichen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpinView : UIView
@property(nonatomic)BOOL hidesWhenStopped;
-(void)startAnimating;
-(void)stopAnimating;
@end
