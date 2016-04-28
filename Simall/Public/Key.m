//
//  Key.m
//  PSBProject
//
//  Created by 张浩 on 16/1/25.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "Key.h"
#pragma mark - 网络
/** 全局用户对象 */
//AccoutObject *kAccountObject = nil;

NSString *const kConnectionFailureError = @"连接失败，请检查网络连接";
NSString *const kRequestTimedOutError  = @"请求超时，请检查连接网络";
NSString *const kAuthenticationError  = @"认证失败，请检查网络连接";

//接口地址
NSString *const kPublic_URL = @"http://api.simall.com.cn/system/";

NSString *const kImage_URL = @"";
NSString *const kImageUpload_URL = @"";




//首页
NSString *const kHomeUpdate = @"datastatistics/data?";//最新更新
NSString *const kHomeProductRecommend = @"product/list?";//商品推荐
NSString *const kHomeEngineerRecommend = @"engineer/list?";//工程师推荐
NSString *const kHomeMethodRecommend = @"engineerdoc/list?";//方案推荐
NSString *const kHomeXunJiaUpdate = @"supplyasking/list?";//询价信息更新
NSString *const kHomeXuQiuUpdate = @"supplyasking/list?";//需求信息更新
NSString *const kHomeKuCunUpdate = @"inventoryrelease/list?";//库存信息更新


//商城
NSString *const kStoreClassLevel = @"equipattributes/list?";//商城左.右侧分类


/////////////////////////////////////Personal/////////////////////////////////////
/**1 登录 */
NSString *const kLogin = @"api.parent.login.do?";

/**2.*/
NSString *const kRegist = @"api.user.checkStuIsExist.do?";

/**3. 修改头像 */
NSString *const kChangePhoto = @"api.picture.upload.do?";


#pragma mark - 常量
CGFloat const kHUDTime = 1.0f;
CGFloat const kAnimaTime  = 0.30f;
NSString *const kLastCatchTime = @"LastCatchTime";
NSString *const kLastCatchInfoTime = @"LastCatchTime_Info";
NSString *const kIsNetConnect = @"isNetConnect";
NSString *const kPassword = @"password";//密码
NSString *const kPhoneNumber = @"phoneNumber";//用户名
NSString *const kUserInfoDefault = @"userDefault";//用户信息
NSString *const kPushArray = @"pushArray";//用户的推送消息

NSString *const kIsLoadingPic = @"isLoadingPic";//是否加载图片的key

NSString *const ISAUTOLOGIN = @"isAutoLogin";//是否自动登录的key

/** tabbar最近一次选择的Index */
NSUInteger kLastSelectedIndex = 0;
@implementation Key

@end
