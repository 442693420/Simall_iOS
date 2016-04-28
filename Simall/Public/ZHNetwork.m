//
//  ZHNetwork.m
//  PSBProject
//
//  Created by 张浩 on 16/3/1.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "ZHNetwork.h"
#import "AFNetworking.h"
@implementation ZHNetwork
+ (ZHNetwork *)shareDYNetwork {
    static ZHNetwork *instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (instance == nil) {
            instance = [[ZHNetwork alloc] init];
        }
    });
    return instance;
}

- (void)getRequest:(NSString *)url
            params:(NSDictionary *)params
           success:(requestSuccessBlock)successHandler
           failure:(requestFailureBlock)failureHandler {
    
    //网络不可用
    if (![self checkNetworkStatus]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet
                                                         setWithObjects:@"application/json", @"text/json", @"text/javascript",
                                                         @"text/html", @"text/plain", nil];
    // 请求超时设定
    manager.requestSerializer.timeoutInterval = 10;
    /**
     *  请求队列的最大并发数
     */
    // manager.operationQueue.maxConcurrentOperationCount = 5;
    [manager GET:url
      parameters:params
        progress:nil
         success:^(NSURLSessionDataTask *_Nonnull task,
                   id _Nullable responseObject) {
             NSDictionary *dic = (NSDictionary *)responseObject;
             successHandler(dic);
         }
         failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
             ZHLog(@"------GET请求失败-------%@", error);
             failureHandler(error);
         }];
}

- (void)postRequest:(NSString *)url
             params:(NSDictionary *)params
            success:(requestSuccessBlock)successHandler
            failure:(requestFailureBlock)failureHandler {
    
    if (![self checkNetworkStatus]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    AFHTTPSessionManager *manager = [self getRequstManager];
    //header
    NSString *headStr = @"android:CHGT8HILS5HAA";
    NSData *headData = [headStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *headEncode = [headData base64EncodedStringWithOptions:0];
    NSString *head = [NSString stringWithFormat:@"Basic %@",headEncode];
    [manager.requestSerializer setValue:head forHTTPHeaderField:@"Authorization"];
    [manager POST:url
       parameters:params
         progress:^(NSProgress *_Nonnull downloadProgress) {
             
         }
          success:^(NSURLSessionDataTask *_Nonnull task,
                    id _Nullable responseObject) {
              successHandler(responseObject);
          }
          failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
              ZHLog(@"------POST请求失败-------%@", error);
              failureHandler(error);
          }];
}

- (void)putRequest:(NSString *)url
            params:(NSDictionary *)params
           success:(requestSuccessBlock)successHandler
           failure:(requestFailureBlock)failureHandler {
    
    if (![self checkNetworkStatus]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    AFHTTPSessionManager *manager = [self getRequstManager];
    
    [manager PUT:url
      parameters:params
         success:^(NSURLSessionDataTask *_Nonnull task,
                   id _Nullable responseObject) {
             successHandler(responseObject);
         }
         failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
             ZHLog(@"------PUT请求失败-------%@", error);
             failureHandler(error);
         }];
}

- (void)deleteRequest:(NSString *)url
               params:(NSDictionary *)params
              success:(requestSuccessBlock)successHandler
              failure:(requestFailureBlock)failureHandler {
    
    if (![self checkNetworkStatus]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    AFHTTPSessionManager *manager = [self getRequstManager];
    
    [manager DELETE:url
         parameters:params
            success:^(NSURLSessionDataTask *_Nonnull task,
                      id _Nullable responseObject) {
                successHandler(responseObject);
            }
            failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
                ZHLog(@"------DELETE请求失败-------%@", error);
                failureHandler(error);
            }];
}

/**
 下载文件，监听下载进度
 */
- (void)downloadRequest:(NSString *)url
     successAndProgress:(progressBlock)progressHandler
               complete:(responseBlock)completionHandler {
    
    if (![self checkNetworkStatus]) {
        progressHandler(0, 0, 0);
        completionHandler(nil, nil);
        return;
    }
    
    NSURLSessionConfiguration *sessionConfiguration =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]
                                    initWithSessionConfiguration:sessionConfiguration];
    
    NSURLRequest *request =
    [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    // NSProgress *kProgress = nil;
    
    NSURLSessionDownloadTask *downloadTask = [manager
                                              downloadTaskWithRequest:request
                                              progress:^(NSProgress *_Nonnull downloadProgress) {
                                                  ZHLog(@"------下载进度-------%@", downloadProgress);
                                              }
                                              destination:^NSURL *_Nonnull(NSURL *_Nonnull targetPath,
                                                                           NSURLResponse *_Nonnull response) {
                                                  NSURL *documentUrl =
                                                  [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
                                                                                         inDomain:NSUserDomainMask
                                                                                appropriateForURL:nil
                                                                                           create:NO
                                                                                            error:nil];
                                                  return [documentUrl
                                                          URLByAppendingPathComponent:[response suggestedFilename]];
                                              }
                                              completionHandler:^(NSURLResponse *_Nonnull response,
                                                                  NSURL *_Nullable filePath, NSError *_Nullable error) {
                                                  if (error) {
                                                      ZHLog(@"------下载失败-------%@", error);
                                                  }
                                                  completionHandler(response, error);
                                              }];
    
#warning mark - 设置block去追踪下载任务进度情况 - 此处存疑，只需要进度还是需要数据
    [manager setDownloadTaskDidWriteDataBlock:^(
                                                NSURLSession *_Nonnull session,
                                                NSURLSessionDownloadTask *_Nonnull downloadTask,
                                                int64_t bytesWritten, int64_t totalBytesWritten,
                                                int64_t totalBytesExpectedToWrite) {
        progressHandler(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
        
    }];
    [downloadTask resume];
}

/**
 *  发送一个POST请求
 *  @param fileConfig 文件相关参数模型
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 *  无上传进度监听
 */
- (void)updateRequest:(NSString *)url
               params:(NSDictionary *)params
           fileConfig:(DYFileConfig *)fileConfig
              success:(requestSuccessBlock)successHandler
              failure:(requestFailureBlock)failureHandler {
    
    if (![self checkNetworkStatus]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    AFHTTPSessionManager *manager = [self getRequstManager];
    [manager POST:url
       parameters:params
constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
    [formData appendPartWithFileData:fileConfig.fileData
                                name:fileConfig.name
                            fileName:fileConfig.fileName
                            mimeType:fileConfig.mimeType];
}
         progress:^(NSProgress *_Nonnull uploadProgress) {
             ZHLog(@"------上传进度----111---%@", uploadProgress);
         }
          success:^(NSURLSessionDataTask *_Nonnull task,
                    id _Nullable responseObject) {
              successHandler(responseObject);
          }
          failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
              ZHLog(@"------上传失败----111---%@", error);
              failureHandler(error);
          }];
}

/**
 上传文件，监听上传进度
 */
- (void)updateRequest:(NSString *)url
               params:(NSDictionary *)params
           fileConfig:(DYFileConfig *)fileConfig
   successAndProgress:(progressBlock)progressHandler
             complete:(responseBlock)completionHandler {
    
    if (![self checkNetworkStatus]) {
        progressHandler(0, 0, 0);
        completionHandler(nil, nil);
        return;
    }
    
    NSURLSessionConfiguration *sessionConfiguration =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]
                                    initWithSessionConfiguration:sessionConfiguration];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]
                                    multipartFormRequestWithMethod:@"POST"
                                    URLString:url
                                    parameters:params
                                    constructingBodyWithBlock:^(
                                                                id<AFMultipartFormData> _Nonnull formData) {
                                        [formData appendPartWithFileData:fileConfig.fileData
                                                                    name:fileConfig.name
                                                                fileName:fileConfig.fileName
                                                                mimeType:fileConfig.mimeType];
                                    }
                                    error:nil];
    
    NSURLSessionUploadTask *uploadTask =
    [manager uploadTaskWithStreamedRequest:request
                                  progress:^(NSProgress *_Nonnull uploadProgress) {
                                      ZHLog(@"------上传进度----222---%@", uploadProgress);
                                  }
                         completionHandler:^(NSURLResponse *_Nonnull response,
                                             id _Nullable responseObject,
                                             NSError *_Nullable error) {
                             if (error) {
                                 ZHLog(@"------上传失败---222----%@", error);
                             }
                             completionHandler(response, error);
                         }];
    
    [manager setTaskDidSendBodyDataBlock:^(
                                           NSURLSession *_Nonnull session, NSURLSessionTask *_Nonnull task,
                                           int64_t bytesSent, int64_t totalBytesSent,
                                           int64_t totalBytesExpectedToSend) {
        progressHandler(bytesSent, totalBytesSent, totalBytesExpectedToSend);
    }];
    
    [uploadTask resume];
}

- (AFHTTPSessionManager *)getRequstManager {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 请求超时设定
    manager.requestSerializer.timeoutInterval = 10;
    //    manager.securityPolicy.allowInvalidCertificates = YES;
    
    return manager;
}

/**
 监控网络状态
 */
- (BOOL)checkNetworkStatus {
    
    __block BOOL isNetworkUse = YES;
    
    AFNetworkReachabilityManager *reachabilityManager =
    [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager
     setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
         if (status == AFNetworkReachabilityStatusUnknown) {
             isNetworkUse = YES;
         } else if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
             isNetworkUse = YES;
         } else if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
             isNetworkUse = YES;
         } else if (status == AFNetworkReachabilityStatusNotReachable) {
             // 网络异常操作
             isNetworkUse = NO;
             ZHLog(@"网络异常,请检查网络是否可用！");
         }
     }];
    [reachabilityManager startMonitoring];
    return isNetworkUse;
}

@end

/**
 *  封装上传文件数据的模型类
 */
@implementation DYFileConfig

+ (instancetype)fileConfigWithfileData:(NSData *)fileData
                                  name:(NSString *)name
                              fileName:(NSString *)fileName
                              mimeType:(NSString *)mimeType {
    return [[self alloc] initWithfileData:fileData
                                     name:name
                                 fileName:fileName
                                 mimeType:mimeType];
}

- (instancetype)initWithfileData:(NSData *)fileData
                            name:(NSString *)name
                        fileName:(NSString *)fileName
                        mimeType:(NSString *)mimeType {
    if (self = [super init]) {
        _fileData = fileData;
        _name = name;
        _fileName = fileName;
        _mimeType = mimeType;
    }
    return self;
}

@end
