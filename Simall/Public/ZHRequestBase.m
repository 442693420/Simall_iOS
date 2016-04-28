//
//  ZHRequestBase.m
//  PSBProject
//
//  Created by 张浩 on 16/3/1.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "ZHRequestBase.h"
#import "AFNetworking.h"

static NSString *kAPI_URL = @"http://172.20.186.78:8180/";

@implementation ZHRequestBase
+ (ZHRequestBase *)shareDYBaseRequest{
    static ZHRequestBase *instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if(instance == nil){
            instance = [[ZHRequestBase alloc]init];
        }
    });
    return instance;
}

+ (void)getWithMethodName:(NSString *)methodName param:(id)param responseBlock:(responseBlock)responseDataBlock {
    NSDictionary *params = (NSDictionary *)param;
    NSLog(@"%@",methodName);
    NSString *requestStr = [NSString stringWithFormat:@"%@%@",kAPI_URL,methodName];
    for (int index = 0; index < params.allKeys.count; index ++) {
        NSString *key = params.allKeys[index];
        NSString *value = params[key];
        requestStr = [requestStr stringByAppendingString:@"&"];
        requestStr = [requestStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
    }
    ZHLog(@"get 请求地址--%@",requestStr);
    requestStr = [requestStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    ZHLog(@"get 请求地址--%@",requestStr);
    [[ZHNetwork shareDYNetwork] getRequest:requestStr params:nil success:^(id responseObj) {
        responseDataBlock(responseObj, nil);
    } failure:^(NSError *error) {
        ZHLog(@"%@", error);
        responseDataBlock(nil, error);
    }];
}
+ (void)postWithMethodName:(NSString *)methodName param:(id)param responseBlock:(responseBlock)responseDataBlock {
    NSString *requestStr = [NSString stringWithFormat:@"%@%@",kPublic_URL,methodName];
    ZHLog(@"post 请求地址--%@",requestStr);
    [[ZHNetwork shareDYNetwork] postRequest:requestStr params:param success:^(id responseObj) {
        responseDataBlock(responseObj, nil);
    } failure:^(NSError *error) {
        ZHLog(@"%@", error);
        responseDataBlock(nil, error);
    }];
}

+ (void)putWithUrl:(NSString *)url param:(id)param responseBlock:(responseBlock)responseDataBlock {
    [[ZHNetwork shareDYNetwork] putRequest:url params:param success:^(id responseObj) {
        responseDataBlock(responseObj, nil);
    } failure:^(NSError *error) {
        ZHLog(@"%@", error);
        responseDataBlock(nil, error);
    }];
}

+ (void)deleteWithUrl:(NSString *)url param:(id)param  responseBlock:(responseBlock)responseDataBlock {
    
    [[ZHNetwork shareDYNetwork] deleteRequest:url params:param success:^(id responseObj) {
        responseDataBlock(responseObj, nil);
    } failure:^(NSError *error) {
        ZHLog(@"%@", error);
        responseDataBlock(nil, error);
    }];
}

@end
