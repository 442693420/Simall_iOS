//
//  RegisterViewController.m
//  JCHProject
//
//  Created by 张浩 on 16/4/14.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"用户注册";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpView];
    
}
- (void)setUpView {
    float padding = 30.f;
    
    //输入框
    UITextField *mobileTextF = [UITextField new];
    [mobileTextF setBackgroundColor:[UIColor clearColor]];
    mobileTextF.font = [UIFont systemFontOfSize:14.0f];
    mobileTextF.keyboardType = UIKeyboardTypeNumberPad;
    [mobileTextF setPlaceholder:@"手机号码"];
    self.usernameTextField = mobileTextF;
    //用户名图片
    UIView *userNameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *userNameLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 26, 26)];
    userNameLeftImageView.image = [UIImage imageNamed:@"iphone"];
    [userNameLeftView addSubview:userNameLeftImageView];
    self.usernameTextField.leftView = userNameLeftView;
    self.usernameTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.usernameTextField];
    UILabel *usernameLabel = [[UILabel alloc] init];
    usernameLabel.frame = CGRectMake(30, self.usernameTextField.frame.size.height - 0.5f, self.usernameTextField.frame.size.width - 30, 0.5f);
    usernameLabel.backgroundColor = RGB(205, 205, 205, 1);
    [self.view addSubview:usernameLabel];
    
    UITextField *pwTextF = [UITextField new];
    [pwTextF setPlaceholder:@"密码"];
    pwTextF.font = [UIFont systemFontOfSize:14.0f];
    pwTextF.secureTextEntry = YES;
    [pwTextF setBackgroundColor:[UIColor clearColor]];
    self.passwordTextField = pwTextF;
    
    //密码图片
    UIView *passwordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *passwordLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 26, 26)];
    passwordLeftImageView.image = [UIImage imageNamed:@"lock"];
    [passwordLeftView addSubview:passwordLeftImageView];
    self.passwordTextField.leftView = passwordLeftView;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.passwordTextField];
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.frame = CGRectMake(30, self.passwordTextField.frame.size.height - 0.5f, self.passwordTextField.frame.size.width - 30, 0.5f);
    passwordLabel.backgroundColor = RGB(205, 205, 205, 1);
    [self.view addSubview:passwordLabel];
    
    UITextField *verifyCodeTextF = [UITextField new];
    [verifyCodeTextF setPlaceholder:@"验证码"];
    verifyCodeTextF.font = [UIFont systemFontOfSize:14.0f];
    verifyCodeTextF.keyboardType = UIKeyboardTypeNumberPad;
    [verifyCodeTextF setBackgroundColor:[UIColor clearColor]];
    self.verifyCodeTextField = verifyCodeTextF;
    //验证码图片
    UIView *verifyCodeLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *verifyCodeLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 26, 26)];
    verifyCodeLeftImageView.image = [UIImage imageNamed:@"yzm.png"];
    [verifyCodeLeftView addSubview:verifyCodeLeftImageView];
    self.verifyCodeTextField.leftView = verifyCodeLeftView;
    self.verifyCodeTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.verifyCodeTextField];
    
    UILabel *verifyCodeLabel = [[UILabel alloc] init];
    verifyCodeLabel.frame = CGRectMake(30, self.verifyCodeTextField.frame.size.height - 0.5f, self.verifyCodeTextField.frame.size.width - 30, 0.5f);
    verifyCodeLabel.backgroundColor = RGB(205, 205, 205, 1);
    [self.view addSubview:verifyCodeLabel];
    
    //获取验证码按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 3, 120, 24)];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [btn setBackgroundColor:MainColor];
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:self.verifyCodeTextField.font];
    [btn addTarget:self action:@selector(messageVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = btn.frame.size.height / 2;
    self.verifycodeBtn = btn;
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 130, 30)];
    [rightView addSubview:self.verifycodeBtn];
    self.verifyCodeTextField.rightView = rightView;
    self.verifyCodeTextField.rightViewMode = UITextFieldViewModeAlways;
    
    UITextField *inviteCodeTextF = [UITextField new];
    [inviteCodeTextF setPlaceholder:@"邀请码（没有可不填）"];
    inviteCodeTextF.font = [UIFont systemFontOfSize:14.0f];
    inviteCodeTextF.keyboardType = UIKeyboardTypeNumberPad;
    [inviteCodeTextF setBackgroundColor:[UIColor clearColor]];
    self.inviteCodeTextField = inviteCodeTextF;
    //邀请码图片
    UIView *inviteCodeLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *inviteCodeLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 26, 26)];
    inviteCodeLeftImageView.image = [UIImage imageNamed:@"yqm.png"];
    [inviteCodeLeftView addSubview:inviteCodeLeftImageView];
    self.inviteCodeTextField.leftView = inviteCodeLeftView;
    self.inviteCodeTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.inviteCodeTextField];
    
    UILabel *inviteCodeLabel = [[UILabel alloc] init];
    inviteCodeLabel.frame = CGRectMake(30, self.inviteCodeTextField.frame.size.height - 0.5f, self.inviteCodeTextField.frame.size.width - 30, 0.5f);
    inviteCodeLabel.backgroundColor = RGB(205, 205, 205, 1);
    [self.view addSubview:inviteCodeLabel];
    
    UIButton *buttonForDelegate = [[UIButton alloc]init];
    [buttonForDelegate setImage:[UIImage imageNamed:@"nocheck_b"] forState:UIControlStateNormal];
    [buttonForDelegate addTarget:self action:@selector(isAgreeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonForDelegate];
    self.isAgreeDelegateButton = buttonForDelegate;
    self.isAgreeDelegate = YES;
    
    UIButton *buttonForTextDelegate = [[UIButton alloc]init];
    buttonForTextDelegate.backgroundColor = [UIColor clearColor];
    [buttonForTextDelegate setTitleColor:RGB(98, 98, 98, 1) forState:UIControlStateNormal];
    buttonForTextDelegate.titleLabel.font = [UIFont systemFontOfSize:11];
    [buttonForTextDelegate setTitle:@"已同意用户注册协议" forState:UIControlStateNormal];
    [buttonForTextDelegate addTarget:self action:@selector(textDelegateJump:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonForTextDelegate];
    
    UIButton *registBtn = [[UIButton alloc] init];
    [registBtn setBackgroundColor:MainColor];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    registBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    registBtn.layer.cornerRadius = 5.0f;
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(signup:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    self.registButton = registBtn;
    
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(padding);
        make.top.equalTo(self.view.mas_top).with.offset(padding);
        make.right.equalTo(self.view.mas_right).with.offset(-padding);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@30);
    }];
    [usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.usernameTextField.mas_left).with.offset(30);
        make.bottom.equalTo(self.usernameTextField.mas_bottom).with.offset(-0.5f);
        make.right.equalTo(self.usernameTextField.mas_right);
        make.height.equalTo(@0.5f);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.usernameTextField.mas_left);
        make.top.equalTo(self.usernameTextField.mas_bottom).with.offset(padding/2);
        make.right.equalTo(self.usernameTextField.mas_right);
        make.height.equalTo(@30);
    }];
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordTextField.mas_left).with.offset(30);
        make.bottom.equalTo(self.passwordTextField.mas_bottom).with.offset(-0.5f);
        make.right.equalTo(self.passwordTextField.mas_right);
        make.height.equalTo(@0.5f);
    }];
    
    [self.verifyCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordTextField.mas_left);
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(padding/2);
        make.right.equalTo(self.passwordTextField.mas_right);
        make.height.equalTo(@30);
    }];
    [verifyCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.verifyCodeTextField.mas_left).with.offset(30);
        make.bottom.equalTo(self.verifyCodeTextField.mas_bottom).with.offset(-0.5f);
        make.right.equalTo(self.verifyCodeTextField.mas_right);
        make.height.equalTo(@0.5f);
    }];
    
    [self.inviteCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.verifyCodeTextField.mas_left);
        make.top.equalTo(self.verifyCodeTextField.mas_bottom).with.offset(padding/2);
        make.right.equalTo(self.verifyCodeTextField.mas_right);
        make.height.equalTo(@30);
    }];
    [inviteCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inviteCodeTextField.mas_left).with.offset(30);
        make.bottom.equalTo(self.inviteCodeTextField.mas_bottom).with.offset(-0.5f);
        make.right.equalTo(self.inviteCodeTextField.mas_right);
        make.height.equalTo(@0.5f);
    }];
    
    [self.isAgreeDelegateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inviteCodeTextField.mas_bottom).with.offset(10);
        make.left.equalTo(self.usernameTextField.mas_left);
        make.height.width.mas_equalTo(20);
    }];
    
    [buttonForTextDelegate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.isAgreeDelegateButton.mas_top);
        make.left.equalTo(self.isAgreeDelegateButton.mas_right).with.offset(5);
        make.height.equalTo(self.isAgreeDelegateButton.mas_height);
    }];
    
    [self.registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonForDelegate.mas_bottom).with.offset(10);
        make.left.equalTo(self.usernameTextField.mas_left);
        make.right.equalTo(self.usernameTextField.mas_right);
        make.height.equalTo(@35);
        make.width.equalTo(self.usernameTextField.mas_width);
    }];
}

- (void)isAgreeButton:(id)sender {
    if (self.isAgreeDelegate) {
        self.isAgreeDelegate = NO;
        [self.isAgreeDelegateButton setImage:[UIImage imageNamed:@"nocheck_a"] forState:UIControlStateNormal];
    } else {
        self.isAgreeDelegate = YES;
        [self.isAgreeDelegateButton setImage:[UIImage imageNamed:@"nocheck_b"] forState:UIControlStateNormal];
    }
}
//隐藏键盘的方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
