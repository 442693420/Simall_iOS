//
//  ProductDetailChooseViewController.m
//  JCHProject
//
//  Created by 张浩 on 16/4/15.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "ProductDetailChooseViewController.h"

@interface ProductDetailChooseViewController ()
@property (nonatomic , strong)UIButton *upBtn;
@property (nonatomic , strong)UIButton *downBtn;
@property (nonatomic , strong)UIButton *submitBtn;

@property (nonatomic , assign)NSInteger buyNum;
@end

@implementation ProductDetailChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    self.view.backgroundColor = MainColor;
    
    [self.view addSubview:self.textField];
    [self.view addSubview:self.upBtn];
    [self.view addSubview:self.downBtn];
    [self.view addSubview:self.submitBtn];
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"选择数量";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor whiteColor];
    titleLab.backgroundColor = RGB(45, 170, 250, 1);
    titleLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    [self.upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.textField.mas_left).offset(-20);
        make.height.equalTo(@40);
        make.width.equalTo(@60);
        make.centerY.equalTo(self.textField.mas_centerY);
    }];
    [self.downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textField.mas_right).offset(20);
        make.height.equalTo(@40);
        make.width.equalTo(@60);
        make.centerY.equalTo(self.textField.mas_centerY);
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(60);
        make.right.equalTo(self.view.mas_right).offset(-60);
        make.height.equalTo(@40);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
    }];

    //圆角
 self.upBtn.layer.masksToBounds = YES;
    self.upBtn.layer.cornerRadius = 2.0;
    
    self.downBtn.layer.masksToBounds = YES;
    self.downBtn.layer.cornerRadius = 2.0;
    
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 5.0;
}
- (void)upClick{
    if (self.buyNum != 999) {
        self.buyNum = self.buyNum+1;
    }else{
        self.buyNum = 999;
    }
    self.textField.text = [NSString stringWithFormat:@"%ld",(long)self.buyNum];

}
- (void)downClick{
    if (self.buyNum != 1) {
        self.buyNum = self.buyNum-1;
    }else{
        self.buyNum = 1;
    }
    self.textField.text = [NSString stringWithFormat:@"%ld",(long)self.buyNum];
}
- (void)submitClick{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    if ([self.textField.text intValue]>999) {
        self.textField.text = @"999";
        self.buyNum = 999;
    }else if ([self.textField.text intValue]<1||self.textField.text.length == 0||[self.textField.text isEqualToString:@""]){
        self.textField.text = @"1";
        self.buyNum = 1;
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text intValue]>999) {
        [PublicObject showHUDView:self.view title:@"库存剩余999" content:@"" time:1 andCodes:^{
        }];
        textField.text = @"999";
        self.buyNum = 999;
    }else if ([self.textField.text intValue]<1||self.textField.text.length == 0||[self.textField.text isEqualToString:@""]){
        [PublicObject showHUDView:self.view title:@"至少选一件" content:@"" time:1 andCodes:^{
        }];
        self.textField.text = @"1";
        self.buyNum = 1;
    }else{
        self.buyNum = [textField.text integerValue];
    }
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
#pragma mark getter and setter
-(UITextField *)textField{
    if (_textField == nil) {
        _textField = [[UITextField alloc]init];
        _textField.textColor = [UIColor darkGrayColor];
        _textField.textAlignment = NSTextAlignmentCenter;
    }
    return _textField;
}
-(UIButton *)upBtn{
    if (_upBtn == nil) {
        _upBtn = [[UIButton alloc]init];
        _upBtn.backgroundColor = [UIColor whiteColor];
        [_upBtn setTitle:@"+" forState:UIControlStateNormal];
        [_upBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [_upBtn setTitleColor:MainColor forState:UIControlStateNormal];
        [_upBtn addTarget:self action:@selector(upClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _upBtn;
}
-(UIButton *)downBtn{
    if (_downBtn == nil) {
        _downBtn = [[UIButton alloc]init];
        _downBtn.backgroundColor = [UIColor whiteColor];
        [_downBtn setTitle:@"-" forState:UIControlStateNormal];
        [_downBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [_downBtn setTitleColor:MainColor forState:UIControlStateNormal];
        [_downBtn addTarget:self action:@selector(downClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downBtn;
}
-(UIButton *)submitBtn{
    if (_submitBtn == nil) {
        _submitBtn = [[UIButton alloc]init];
        _submitBtn.backgroundColor = [UIColor whiteColor];
        [_submitBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:MainColor forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
@end
