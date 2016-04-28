//
//  LoginViewController.h
//  JCHProject
//
//  Created by 张浩 on 16/4/14.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (nonatomic, unsafe_unretained) IBOutlet UITextField *usernameTextField;
@property (nonatomic, unsafe_unretained) IBOutlet UITextField *passwordTextField;
@property (nonatomic, unsafe_unretained) IBOutlet UIButton *loginButton;
@property (nonatomic, unsafe_unretained) IBOutlet UIButton *registButton;
@property (nonatomic, unsafe_unretained) IBOutlet UIButton *forgetPWButton;

@property (strong, nonatomic) void (^dismissView)(BOOL isSuccess);

@end
