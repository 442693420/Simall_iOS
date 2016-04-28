//
//  LoginViewController.m
//  JCHProject
//
//  Created by 张浩 on 16/4/14.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPWViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //返回按钮
    UIButton* leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,60,30)];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
//    [leftButton setImage:[UIImage imageNamed:@"arrow_white_left.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem= leftItem;

    
    [self setUpView];
    
}
- (void)setUpView {
    
    float padding = 30.f;
    
    //输入框
    UITextField *loginTextF =[UITextField new];
    [loginTextF setPlaceholder:@"手机号码"];
    [loginTextF setKeyboardType:UIKeyboardTypeNumberPad];
    self.usernameTextField = loginTextF;
    //用户名图片
    UIView *userNameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *userNameLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 26, 26)];
    userNameLeftImageView.image = [UIImage imageNamed:@"iphone"];
    [userNameLeftView addSubview:userNameLeftImageView];
    self.usernameTextField.leftView = userNameLeftView;
    self.usernameTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.usernameTextField];
    UILabel *usernameLabel = [[UILabel alloc] init];
    usernameLabel.frame = CGRectMake(30, self.usernameTextField.frame.size.height - 0.6f, self.usernameTextField.frame.size.width - 30, 0.6f);
    usernameLabel.backgroundColor = RGB(205, 205, 205, 1);
    [self.view addSubview:usernameLabel];
    
    UITextField *pwTextF =[UITextField new];
    [pwTextF setPlaceholder:@"密码"];
    pwTextF.secureTextEntry = YES;
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
    passwordLabel.frame = CGRectMake(30, self.passwordTextField.frame.size.height - 0.6f, self.passwordTextField.frame.size.width - 30, 0.6f);
    passwordLabel.backgroundColor = RGB(205, 205, 205, 1);
    [self.view addSubview:passwordLabel];
    
    UIButton *loginBtn =[[UIButton alloc] init];
    [loginBtn setBackgroundColor:MainColor];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.layer.cornerRadius = 5.0f;
    [self.view addSubview:loginBtn];
    self.loginButton = loginBtn;
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registBtn setBackgroundColor:[UIColor clearColor]];
    [registBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
    [registBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [registBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    self.registButton = registBtn;
    
    UIButton *forgetPWBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPWBtn setBackgroundColor:[UIColor clearColor]];
    [forgetPWBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPWBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [forgetPWBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [forgetPWBtn addTarget:self action:@selector(forgotPW) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPWBtn];
    self.forgetPWButton = forgetPWBtn;
    
    UILabel *centerLab = UILabel.new;
    [centerLab setBackgroundColor:RGB(205, 205, 205, 1)];
    [self.view addSubview:centerLab];
    
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(padding);
        make.top.equalTo(self.view.mas_top).with.offset(padding);
        make.right.equalTo(self.view.mas_right).with.offset(-padding);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@30);
    }];
    
    [usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.usernameTextField.mas_left).with.offset(30);
        make.right.equalTo(self.usernameTextField.mas_right);
        make.bottom.equalTo(self.usernameTextField.mas_bottom);
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
        make.right.equalTo(self.passwordTextField.mas_right);
        make.bottom.equalTo(self.passwordTextField.mas_bottom);
        make.height.equalTo(@0.5f);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(padding);
        make.left.equalTo(self.passwordTextField.mas_left);
        make.right.equalTo(self.passwordTextField.mas_right);
        make.height.equalTo(@35);
    }];
    
    [self.registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginButton.mas_bottom).with.offset(padding/2);
        make.left.equalTo(self.usernameTextField.mas_left);
        make.height.equalTo(@30);
        make.width.equalTo(self.loginButton.mas_width).with.multipliedBy(0.5);
    }];
    
    [self.forgetPWButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginButton.mas_bottom).with.offset(padding/2);
        make.right.equalTo(self.usernameTextField.mas_right);
        make.height.equalTo(@30);
        make.width.equalTo(self.loginButton.mas_width).with.multipliedBy(0.5);
    }];
    
    [centerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.registButton.mas_centerY);
        make.height.equalTo(@15);
        make.width.equalTo(@0.6f);
    }];
    
}
//隐藏键盘的方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)login{

}
- (void)regist{
    RegisterViewController *viewController = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)forgotPW{
    ForgetPWViewController *viewController = [[ForgetPWViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
}
-(void)backClick{
//    self.dismissView(NO);
    [self dismissViewControllerAnimated:YES completion:^{
    }];
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
