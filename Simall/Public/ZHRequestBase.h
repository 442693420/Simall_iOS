//
//  ZHRequestBase.h
//  PSBProject
//
//  Created by 张浩 on 16/3/1.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHNetwork.h"
#import "MJExtension.h"

/**
 失败数据block
 */
typedef void (^resultErrorBlock)(NSString *errorString);
@interface ZHRequestBase : NSObject
+ (ZHRequestBase *)shareDYBaseRequest;

/**
 GET请求
 */
+ (void)getWithMethodName:(NSString *)methodName param:(id)param responseBlock:(responseBlock)responseDataBlock;

/**
 POST请求
 */
+ (void)postWithMethodName:(NSString *)methodName param:(id)param responseBlock:(responseBlock)responseDataBlock;

+ (void)putWithUrl:(NSString *)url param:(id)param responseBlock:(responseBlock)responseDataBlock;

+ (void)deleteWithUrl:(NSString *)url param:(id)param responseBlock:(responseBlock)responseDataBlock;

@end
