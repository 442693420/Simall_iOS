//
//  PersonalViewController.m
//  JCHProject
//
//  Created by 张浩 on 16/4/12.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "PersonalViewController.h"
#import "HomeTabBtnView.h"

@interface PersonalViewController ()
@property (nonatomic , strong)UIScrollView *scrollView;
@property (nonatomic , strong)UIView *scrollBackView;
@property (nonatomic , strong)UIView *topBackView;
@property (nonatomic , strong)UIView *bottomBackView;
@property (nonatomic , strong)UIButton *titleBtn;
@property (nonatomic , strong)UILabel *titleLab;

@property (nonatomic , strong)NSArray *btnArr;
@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人中心";
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.scrollBackView];
    
    [self.scrollBackView addSubview:self.topBackView];;
    [self.scrollBackView addSubview:self.bottomBackView];
    
    [self.topBackView addSubview:self.titleBtn];
    [self.topBackView addSubview:self.titleLab];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    [self.scrollBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView);
        make.left.right.equalTo(self.view);
    }];
    [self.topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.scrollBackView);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.4);
    }];
    [self.bottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scrollBackView);
        make.top.equalTo(self.topBackView.mas_bottom);
    }];
    [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBackView.mas_top).offset(8);
        make.width.height.equalTo(@80);
        make.centerX.equalTo(self.topBackView.mas_centerX);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleBtn.mas_bottom).offset(3);
        make.height.equalTo(@30);
        make.centerX.equalTo(self.titleBtn.mas_centerX);
    }];
    NSDictionary *dic1 = @{@"title":@"我的询价",@"image":@"home_btn1.png"};
    NSDictionary *dic2 = @{@"title":@"我的报价",@"image":@"home_btn2.png"};
    NSDictionary *dic3 = @{@"title":@"需求与接单",@"image":@"home_btn3.png"};
    NSDictionary *dic4 = @{@"title":@"我的库存",@"image":@"home_btn4.png"};
    NSDictionary *dic5 = @{@"title":@"商品采购",@"image":@"home_btn5.png"};
    NSDictionary *dic6 = @{@"title":@"我是工程师",@"image":@"home_btn6.png"};
    NSDictionary *dic7 = @{@"title":@"我的订单",@"image":@"home_btn3.png"};
    NSDictionary *dic8 = @{@"title":@"即将推出",@"image":@"home_btn2.png"};

    self.btnArr = @[dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8];
    UIView *lastView;
    for (int i = 0; i < self.btnArr.count; i++) {
        int lie = i%3;
        NSDictionary *dic = [self.btnArr objectAtIndex:i];
        UIImage *img = [UIImage imageNamed:[dic objectForKey:@"image"]];
        NSString *title = [dic objectForKey:@"title"];
        HomeTabBtnView *btnView = [[HomeTabBtnView alloc]initWithTag:i+10 Image:img title:title actionBlock:^(NSInteger tag) {
            //获取userId
            //                switch (tag) {
            //                    case 10://采购询价
            //                    {
            //                        HouseRentMainViewController *viewController = [[HouseRentMainViewController alloc]init];
            //                        viewController.hidesBottomBarWhenPushed = YES;
            //                        [self.navigationController pushViewController:viewController animated:YES];
            //                    }
            //                        break;
            //                    case 15://商品分类
            //                    {
            //                        if (userObj == nil) {
            //                            //去登陆
            //                            [PublicObject showHUDView:self.view title:@"" content:@"未登录" time:1 andCodes:^{
            //                                LoginViewController *loginController = [[LoginViewController alloc]init];
            //                                UINavigationController *newNVC = [[UINavigationController alloc]initWithRootViewController:loginController];
            //                                newNVC.tabBarItem.title = @"登 录";
            //                                newNVC.navigationBar.translucent =  NO;//透明
            //                                //导航栏颜色
            //                                newNVC.navigationBar.barTintColor = MainColor;
            //                                //修改UINavigationController title 的颜色和大小
            //                                UIColor * titleColor = [UIColor whiteColor];
            //                                UIFont * font = [UIFont boldSystemFontOfSize:20];
            //                                NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:titleColor,NSForegroundColorAttributeName,font,NSFontAttributeName, nil];
            //                                newNVC.navigationBar.titleTextAttributes = dic;
            //
            //                                loginController.dismissView = ^(BOOL isSuccess){
            //                                    if (isSuccess) {
            //                                        FloatingPopulationViewController *viewController = [[FloatingPopulationViewController alloc]init];
            //                                        viewController.hidesBottomBarWhenPushed = YES;
            //                                        [self.navigationController pushViewController:viewController animated:YES];
            //                                    }else{
            //                                        [self dismissViewControllerAnimated:YES completion:^{
            //
            //                                        }];
            //                                    }
            //                                };
            //
            //                                //调用此方法显示模态窗口
            //                                [self presentViewController:newNVC animated:YES completion:nil];
            //                            }];
            //                        }
            //                        else{
            //                            FloatingPopulationViewController *viewController = [[FloatingPopulationViewController alloc]init];
            //                            viewController.hidesBottomBarWhenPushed = YES;
            //                            [self.navigationController pushViewController:viewController animated:YES];
            //                        }
            //                    }
            //                        break;
            //                    default:
            //                        break;
            //                }
        }];
//        btnView.backgroundColor = [UIColor yellowColor];
        [self.bottomBackView addSubview:btnView];
        [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastView) {
                if (lie == 0) {
                    make.top.mas_equalTo(lastView.mas_bottom).offset(1);
                    make.left.mas_equalTo(0);
                }else{
                    make.top.mas_equalTo(lastView.mas_top);
                    make.left.mas_equalTo(lastView.mas_right).offset(1);
                }
            }else{
                make.top.left.mas_equalTo(0);
            }
            make.width.mas_equalTo(SCREEN_WIDTH/3);
            make.height.mas_equalTo(SCREEN_WIDTH/3 - 30);
            
        }];
        lastView = btnView;
    }
    [self.bottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
    [self.scrollBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomBackView.mas_bottom);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.scrollBackView.mas_bottom).offset(30);
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
#pragma mark getter and setter
-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _scrollView;
}
-(UIView *)scrollBackView{
    if (_scrollBackView == nil) {
        _scrollBackView = [[UIView alloc]init];
        _scrollBackView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _scrollBackView;
}
-(UIView *)topBackView{
    if (_topBackView == nil) {
        _topBackView = [[UIView alloc]init];
        _topBackView.backgroundColor = RGB(45, 170, 250, 1);
    }
    return _topBackView;
}
-(UIView *)bottomBackView{
    if (_bottomBackView == nil) {
        _bottomBackView = [[UIView alloc]init];
        _bottomBackView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _bottomBackView;
}
-(UIButton *)titleBtn{
    if (_titleBtn == nil) {
        _titleBtn = [[UIButton alloc]init];
        [_titleBtn sd_setImageWithURL:nil forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"personalDefault"]];
    }
    return _titleBtn;
}
-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"未登录";
        _titleLab.font = [UIFont systemFontOfSize:16];
        _titleLab.textColor = [UIColor whiteColor];
    }
    return _titleLab;
}
@end
