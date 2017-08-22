/**
 *  ReadMe:
 *  AboutLog:
 *  >>>>> 代表请求出的信息
 *  <<<<< 代表获取到的信息
 *
 */

#import "RequestManager.h"
#import "URLManager.h"
#import "AFNetworkActivityIndicatorManager.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
#import "AFHTTPSessionManager.h"
#endif

@implementation MKRequestTask

- (instancetype)initWithTaskOrOperation:(id)obj
{
    self = [super init];
    if (self) {
        _sessionTaskOrOperation = obj;
    }
    return self;
}

- (void)cancel
{
    if ([_sessionTaskOrOperation respondsToSelector:@selector(cancel)]) {
        [_sessionTaskOrOperation cancel];
    }
}
@end

@implementation RequestManager

+ (MKRequestTask *)postOtherRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer completionHandler:(RequestCompletionHandler)completionHandler failureHandler:(FailureHandler)failureHandler{

    
    
    NSLog(@"接口:%@---------\n参数:%@",requestPath,paramer);
    NSDictionary *dic = [NSDictionary dictionary];
    if ([AppDataManager defaultManager].token) {
        
        dic =@{@"Authorization":[NSString stringWithFormat:@"Bearer %@",[AppDataManager defaultManager].token]};
        
    }else{
        
        dic =@{@"APPVER":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]};
    }
    
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:requestPath]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(paramer).HTTPHeader(dic) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        completionHandler(responseObject);
        
    } progress:^(NSProgress *progress) {
        
        NSLog(@"1111");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failureHandler(error,0);
    }];
    
    return [[MKRequestTask alloc] initWithTaskOrOperation:@""];
    
    

}

+ (MKRequestTask *)postRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer completionHandler:(RequestCompletionHandler)completionHandler failureHandler:(FailureHandler)failureHandler{
    
    
    
    NSLog(@"接口:%@---------\n参数:%@",requestPath,paramer);
    NSDictionary *dic = [NSDictionary dictionary];
    if ([AppDataManager defaultManager].token) {
        
        dic =@{@"Authorization":[NSString stringWithFormat:@"Bearer %@",[AppDataManager defaultManager].token]};
        
    }else{
        
        dic =@{@"APPVER":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]};
    }
    
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:requestPath]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(paramer).HTTPHeader(dic) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        completionHandler(responseObject);
        
    } progress:^(NSProgress *progress) {
        
        NSLog(@"1111");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failureHandler(error,0);
    }];
    
    return [[MKRequestTask alloc] initWithTaskOrOperation:@""];
    
    
    
}


+ (MKRequestTask *) getRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer completionHandler:(RequestCompletionHandler)completionHandler failureHandler:(FailureHandler)failureHandler{
    
    
    
    
    /*
     //设置表头
     [request setValue:[NSString stringWithFormat:@"Bearer %@",[AppDataManager defaultManager].token] forHTTPHeaderField:@"Authorization"];
     */
    
    NSDictionary *dic = [NSDictionary dictionary];
    if ([AppDataManager defaultManager].token) {
        
        dic =@{@"Authorization":[NSString stringWithFormat:@"Bearer %@",[AppDataManager defaultManager].token]};
        
    }else{
        
        dic =@{@"APPVER":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]};
    }
    
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:requestPath]).RequestType(Get).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(paramer).HTTPHeader(dic) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        completionHandler(responseObject);
        
        //        if([responseObject[@"result"] integerValue]== 1)
        //        {
        //            completionHandler(responseObject[@"data"]);
        //        }else
        //        {
        //            NSError *error = [[NSError alloc]initWithDomain:responseObject[@"data"] code:0 userInfo:nil];
        //
        //            if ([error.domain isEqualToString:@"非法访问"]) {
        //                [[NSNotificationCenter defaultCenter] postNotificationName:@"NeedsLogin" object:nil];
        //            }
        //
        //            failureHandler(error ,0);
        //        }
        
        
        
    } progress:^(NSProgress *progress) {
        
        NSLog(@"1111");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failureHandler(error,0);
    }];
    
    return [[MKRequestTask alloc] initWithTaskOrOperation:@""];
    
    
    
//    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
//    
//    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
//    operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    
//    
//#ifdef DEBUG
//   NSLog(@">>>>> path: %@ get parameters:\n%@",requestPath,paramer);
//#endif
//    
//    //1
//    AFHTTPRequestOperation * operation = [operationManager GET:[URLManager requestURLGenetatedWithURL:requestPath] parameters:paramer success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSString *requestTmp = [NSString stringWithString:operation.responseString];
//        
//        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:kNilOptions error:nil];
//        
//#ifdef DEBUG
//        NSLog(@"<<<path: %@ result dicPhoneName:\n%@",requestPath,resultDic);
//#endif
//        completionHandler(resultDic);
////        if(resultDic){
////            if([resultDic[@"result"] integerValue]== 1)
////            {
////                completionHandler(resultDic[@"data"]);
////            }else{
////                NSError *error = [[NSError alloc]initWithDomain:resultDic[@"data"] code:0 userInfo:nil];
////                if (![error.domain isKindOfClass:[NSDictionary class]]) {
////                    if ([error.domain isEqualToString:@"非法访问"]) {
////                        [[NSNotificationCenter defaultCenter] postNotificationName:@"NeedsLogin" object:nil];
////                    }
////                    //AuthList接口返回domain为字典。。。。。。。。
////                }else {
////                    
////                }
////                failureHandler(error ,0);
////            }
////        }else{
////            NSError *error = [[NSError alloc]initWithDomain:@"返回数据为空" code:0 userInfo:nil];
////            failureHandler(error ,0);
////        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        #ifdef DEBUG
//        NSLog(@"请求失败");
//        NSLog(@"XXX error: %@",error.description);
//        #endif
////        
//        NSError * e = [[NSError alloc] initWithDomain:error.userInfo[@"NSLocalizedDescription"] code:error.code userInfo:error.userInfo];
//        error = e;
//        failureHandler(error,operation.response.statusCode);
//    }];
//    
//    //#endif
//    return [[MKRequestTask alloc]initWithTaskOrOperation:operation];
}

+ (MKRequestTask *) deleteRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer completionHandler:(RequestCompletionHandler)completionHandler failureHandler:(FailureHandler)failureHandler{
    
    return nil;
    
//    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
//    
//    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
//    operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//#ifdef DEBUG
//    NSLog(@">>>path: %@ post parameters:\n%@",requestPath,paramer);
//#endif
//    
//    AFHTTPRequestOperation *operation = [operationManager DELETE:[URLManager requestURLGenetatedWithURL:requestPath] parameters:paramer success:^(AFHTTPRequestOperation *operation, id responseObject) {
//    
//        NSString *requestTmp = [NSString stringWithString:operation.responseString];
//        
//        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:kNilOptions error:nil];
//        
//#ifdef DEBUG
//        NSLog(@"<<<<< path: %@ result dic:\n%@",requestPath,resultDic);
//#endif
//        
//        completionHandler(resultDic);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"请求失败");
//        NSLog(@"<<<<< error: %@",error.description);
//        failureHandler(error,operation.response.statusCode);
//        
//    }];
//    
//    return [[MKRequestTask alloc]initWithTaskOrOperation:operation];
}

+ (MKRequestTask *) uploadFileRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer postData:(NSData *)postData postType:(NSInteger)postType completionHandler:(RequestCompletionHandler)completionHandler progressHandler:(ProgressHandler)progressHandler failureHandler:(FailureHandler)failureHandler{
    
    return nil;
    
//    NSString *fileName = @"file";
//    if (postType == 0) {
//        fileName = @"image.jpg";
//    }else{
//        fileName = @"video.mp4";
//    }
//    
//    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
//    
//    NSString* url = [URLManager requestURLGenetatedWithURL:requestPath];
//    NSMutableURLRequest *request =
//    [serializer multipartFormRequestWithMethod:@"POST" URLString:url parameters:paramer constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:postData
//                                    name:@"bin"
//                                fileName:fileName
//                                mimeType:@"application/octet-stream"];
//    } error:nil];
//    
//    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
//    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
//    operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    AFHTTPRequestOperation *operation =
//    [operationManager HTTPRequestOperationWithRequest:request
//                                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                                                  
//                                                  NSUInteger statusCode = operation.response.statusCode;
//                                                  if (statusCode == 200) {
//                                                      NSString *requestTmp = [NSString stringWithString:operation.responseString];
//                                                      NSLog(@"<<<<< Success:\n%@\n string:\n%@", operation.response,requestTmp);
//                                                      
//                                                      completionHandler(requestTmp);
//                                                      
//                                                  }
//                                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                                  
//                                                  NSLog(@"Failure %@", error);
//                                                  
//                                                  failureHandler(error,operation.response.statusCode);
//                                              }];
//    
//    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//        CGFloat progress = (bytesWritten / (double)totalBytesWritten) * 100;
//        if (progressHandler) {
//            progressHandler(progress);
//        }
//    }];
//    
//    [operation start];
//    
//    return [[MKRequestTask alloc]initWithTaskOrOperation:operation];
    
}

+ (MKRequestTask *)downloadFileRquestWithFileUrl:(NSString *)fileUrl fileName:(NSString *)fileName fileCachePath:(NSString *)fileCachePath completionHandler:(RequestCompletionHandler)completionHandler progressHandle:(ProgressHandler)progressHandle failureHandler:(FailureHandler)failureHandler{
    
    
    return nil;
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:fileUrl]];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:fileCachePath append:NO];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSUInteger statusCode = operation.response.statusCode;
//        if (statusCode == 200) {
//            completionHandler(fileCachePath);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        failureHandler(error,operation.response.statusCode);
//    }];
//    
//    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//        CGFloat progress = (bytesRead / totalBytesRead) * 100;
//        progressHandle(progress);
//    }];
//    
//    [operation start];
//    
//    return [[MKRequestTask alloc]initWithTaskOrOperation:operation];
}
@end
