//
//  ZHRequestBase+NetworkingPost.h
//  Simall
//
//  Created by 张浩 on 16/4/27.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "ZHRequestBase.h"

@interface ZHRequestBase (NetworkingPost)
+ (void)networkingPostByParam:(NSDictionary *)param methodName:(NSString *)methodName requestStartBlock:(requestStartBlock)startBlock responseBlock:(responseBlock)responseBlock;
@end
