//
//  WebViewJS.m
//  WDJR
//
//  Created by fyaex001 on 2016/12/14.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "WebViewJS.h"

@implementation WebViewJS

-(void)redirect:(NSString *)type
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([self.delegate respondsToSelector:@selector(redirectJS:)]) {
            
            [self.delegate redirectJS:type];
        }
        
    });
}



@end
