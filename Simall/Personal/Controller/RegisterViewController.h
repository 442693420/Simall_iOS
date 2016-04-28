//
//  RegisterViewController.h
//  JCHProject
//
//  Created by 张浩 on 16/4/14.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (nonatomic, unsafe_unretained) IBOutlet UITextField *usernameTextField;//用户名
@property (nonatomic, unsafe_unretained) IBOutlet UITextField *passwordTextField;//密码
@property (nonatomic, unsafe_unretained) IBOutlet UITextField *verifyCodeTextField;//验证码
@property (nonatomic, unsafe_unretained) IBOutlet UITextField *inviteCodeTextField;//邀请码
@property (nonatomic, unsafe_unretained) IBOutlet UIButton *verifycodeBtn;//获取验证码
@property (nonatomic, unsafe_unretained) IBOutlet UIButton *registButton;//注册

@property (nonatomic, strong) NSTimer *timer;//短信验证码倒计时
@property (nonatomic, assign) int second;//验证码可重发秒数

@property (nonatomic, assign) BOOL isAgreeDelegate;//是否同意协议
@property (nonatomic, weak) UIButton *isAgreeDelegateButton;//同意协议按钮
@end
