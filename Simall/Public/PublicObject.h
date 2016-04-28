//
//  PublicObject.h
//  PSBProject
//
//  Created by 张浩 on 16/1/25.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AccountObject.h"
@interface PublicObject : NSObject


@property(nonatomic ,strong) NSDateFormatter *dateFormate;

//+ (void)saveUserInfoDefault:(AccountObject *)user;//保存个人信息
//+ (AccountObject *)getUserInfoDefault;
/**
 *	图片数组转化
 */
+ (NSMutableArray *)getImageList:(NSString *)imageStr;
/**
 *	图片放大
 */
+(void)showImage:(UIButton*)avatarImageView;

+ (void)showHUDView:(id)theView title:(NSString*)theTitle content:(NSString*)theContent time:(float)thTime andCodes:(void(^)())finish;
+ (void)showHUDBegain:(id)theView title:(NSString *)theTitle;
+ (void)dissMissHUDEnd;

+ (NSString*)convertNullString:(NSString *)oldString;
+ (NSNumber*)convertNullNumber:(NSNumber*)oldNum;

+ (UIImage *)fixOrientation:(UIImage *)aImage;//图片旋转
+ (NSString *)phoneModelString;//获取设备名称
+ (NSString *)md5:(NSString *)str;//md5加密
+ (NSString *)buildRequstData:(NSMutableDictionary *)requestDic;;//数据签名


//+ (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText;

//验证邮箱
+ (BOOL)isEmailAddress:(NSString*)candidate;
//验证用户名
+ (BOOL)isUserName:(NSString*)candidate;
//验证密码
+ (BOOL)isPassword:(NSString*)candidate;
//手机号
+ (BOOL)isTel:(NSString*)candidate;
//日期转周几
+ (NSString *)weekdayStringFromDate:(NSString *)inputDateStr;
//获取设备ip地址
+ (NSString *)deviceIPAdress;
//字典转Json格式字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;
//时间转时间戳
+ (NSString *)timeStrChangeToTimeNumWith:(NSString *)timeFormatter timeStr:(NSString *)timeStr;
//时间戳转时间
+ (NSString *)timeNumChangeToTimeStrWith:(NSString *)timeFormatter timeNum:(NSString *)timeNum;

@end
