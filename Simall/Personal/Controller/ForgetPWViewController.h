//
//  ForgetPWViewController.h
//  JCHProject
//
//  Created by 张浩 on 16/4/14.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPWViewController : UIViewController
@property (nonatomic, unsafe_unretained) IBOutlet UITextField *usernameTextField;
@property (nonatomic, unsafe_unretained) IBOutlet UITextField *passwordTextField;
@property (nonatomic, unsafe_unretained) IBOutlet UITextField *verifyCodeTextField;
@property (nonatomic, unsafe_unretained) IBOutlet UIButton *verifycodeBtn;
@property (nonatomic, unsafe_unretained) IBOutlet UIButton *registButton;

@property (nonatomic, strong) NSTimer *timer;//短信验证码倒计时
@property (nonatomic, assign) int second;//验证码可重发秒数
@end
