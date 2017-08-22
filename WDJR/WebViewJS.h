//
//  WebViewJS.h
//  WDJR
//
//  Created by fyaex001 on 2016/12/14.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <JavaScriptCore/JavaScriptCore.h>
@protocol WebViewJSObjectProtocol <JSExport>

-(void)redirect:(NSString *)type;

@end



//代理方法
@protocol WebViewJSDelegate <NSObject>

-(void)redirectJS:(NSString *)type;
@end

@interface WebViewJS : NSObject<WebViewJSObjectProtocol>

@property(nonatomic, weak) id<WebViewJSDelegate> delegate;

@end
