//
//  Key.h
//  PSBProject
//
//  Created by 张浩 on 16/1/25.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "AccoutObject.h"

#pragma mark - 网络

/** 全局用户对象 */
//UIKIT_EXTERN AccoutObject *kAccountObject;

UIKIT_EXTERN double KLongitude;
UIKIT_EXTERN double KLatitude;
UIKIT_EXTERN NSString *KLocation;

/** 连接失败，请检查网络连接 */
UIKIT_EXTERN NSString *const kConnectionFailureError;
/** 请求超时，请检查连接网络 */
UIKIT_EXTERN NSString *const kRequestTimedOutError;
/** 认证失败，请检查网络连接 */
UIKIT_EXTERN NSString *const kAuthenticationError;

/** 接口地址 */
UIKIT_EXTERN NSString *const kPublic_URL;
UIKIT_EXTERN NSString *const kImage_URL;
UIKIT_EXTERN NSString *const kImageUpload_URL;


//首页
UIKIT_EXTERN NSString *const kHomeUpdate;//最新更新
UIKIT_EXTERN NSString *const kHomeProductRecommend;//商品推荐
UIKIT_EXTERN NSString *const kHomeEngineerRecommend;//工程师推荐
UIKIT_EXTERN NSString *const kHomeMethodRecommend;//方案推荐
UIKIT_EXTERN NSString *const kHomeXunJiaUpdate;//询价信息更新
UIKIT_EXTERN NSString *const kHomeXuQiuUpdate;//需求信息更新
UIKIT_EXTERN NSString *const kHomeKuCunUpdate;//库存信息更新


//商城
UIKIT_EXTERN NSString *const kStoreClassLevel;//商城左.右侧分类


/////////////////////////////////////Personal/////////////////////////////////////
/**1 登录 */
UIKIT_EXTERN NSString *const kLogin;

/**2. 注册 */
UIKIT_EXTERN NSString *const kRegist;

/**3. 修改头像 */
UIKIT_EXTERN NSString *const kChangePhoto;



#pragma mark - 常量
UIKIT_EXTERN CGFloat const kHUDTime;
UIKIT_EXTERN CGFloat const kAnimaTime;
UIKIT_EXTERN NSString *const kLastCatchTime;
UIKIT_EXTERN NSString *const kLastCatchInfoTime;
UIKIT_EXTERN NSString *const kIsNetConnect;
UIKIT_EXTERN NSString *const kPassword;//密码
UIKIT_EXTERN NSString *const kPhoneNumber;//手机号
UIKIT_EXTERN NSString *const kUserInfoDefault;//用户信息
UIKIT_EXTERN NSString *const kPushArray;//用户的推送消息数量


UIKIT_EXTERN NSString *const kIsLoadingPic;//是否加载图片的key

UIKIT_EXTERN NSString *const ISAUTOLOGIN;//是否自动登录的key


#pragma mark - 定义宏

#define HttpRequestService [HttpRequest shareIndex]
#define PublicObj [PublicObject shareIndex]
#define RGB(Red,Green,Blue,Alpha) [UIColor colorWithRed:Red/255.0 green:Green/255.0 blue:Blue/255.0 alpha:Alpha]

//程序主色调
#define MainColor [UIColor colorWithRed:63.0/255.0 green:188/255.0 blue:181.0/255.0 alpha:1.000]
#define BackGroundColor [UIColor colorWithRed:228.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1.0]
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define IS_IOS8_OR_ABOVE ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IOS7_OR_ABOVE ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#define DefaultImage [UIImage imageNamed:@"tabbar"]


#define NormalFontSize 16               //普通字体大小
#define LeftSpace 35                    //控件左边距
#define ElementHeight 50                //控件高度
#define ButtonHeight 40                 //按钮高度
#define VerifyCodeTime 90               //验证码等待时间


//tabbar最近一次选择的Index
UIKIT_EXTERN NSUInteger kLastSelectedIndex;


//#ifdef IS_IOS8_OR_ABOVE
#define RemoteNotificationTypeAlert UIUserNotificationTypeAlert
#define RemoteNotificationTypeBadge UIUserNotificationTypeBadge
#define RemoteNotificationTypeSound UIUserNotificationTypeSound
#define RemoteNotificationTypeNone  UIUserNotificationTypeNone
//#else
//#define RemoteNotificationTypeAlert UIRemoteNotificationTypeAlert
//#define RemoteNotificationTypeBadge UIRemoteNotificationTypeBadge
//#define RemoteNotificationTypeSound UIRemoteNotificationTypeSound
//#define RemoteNotificationTypeNone  UIRemoteNotificationTypeNone
//#endif




@interface Key : NSObject

@end
