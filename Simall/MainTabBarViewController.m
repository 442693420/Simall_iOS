//
//  MainTabBarViewController.m
//  JCHProject
//
//  Created by 张浩 on 16/4/12.
//  Copyright © 2016年 张浩. All rights reserved.
//
//Controller
#import "MainTabBarViewController.h"
#import "HomeViewController.h"
#import "StoreClassViewController.h"
#import "FindViewController.h"
#import "PersonalViewController.h"
@interface MainTabBarViewController ()
@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
[super viewDidLoad];
// Do any additional setup after loading the view.
[self setupViewControllers];
}
- (void)setupViewControllers {
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    UINavigationController *homeNavigationController = [[UINavigationController alloc]
                                                  initWithRootViewController:homeViewController];
    [self changeNVC:homeNavigationController];
    StoreClassViewController *storeClassViewController = [[StoreClassViewController alloc] init];
    UINavigationController *storeClassNavigationController = [[UINavigationController alloc]
                                                             initWithRootViewController:storeClassViewController];
    [self changeNVC:storeClassNavigationController];

    FindViewController *findViewController = [[FindViewController alloc] init];
    UINavigationController *findNavigationController = [[UINavigationController alloc]
                                                  initWithRootViewController:findViewController];
    [self changeNVC:findNavigationController];

    PersonalViewController *personalViewController = [[PersonalViewController alloc] init];
    UINavigationController *personalNavigationController = [[UINavigationController alloc]
                                                      initWithRootViewController:personalViewController];
    [self changeNVC:personalNavigationController];

    [self customizeTabBarForController];
    
    [self setViewControllers:@[
                               homeNavigationController,
                               storeClassNavigationController,
                               findNavigationController,
                               personalNavigationController,
                               ]];
}
- (void)customizeTabBarForController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"tabBar_home_off",
                            CYLTabBarItemSelectedImage : @"tabBar_home_on",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"商城",
                            CYLTabBarItemImage : @"tabBar_supplyAndDemand_off",
                            CYLTabBarItemSelectedImage : @"tabBar_supplyAndDemand_on",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"发现",
                            CYLTabBarItemImage : @"tabBar_find_off",
                            CYLTabBarItemSelectedImage : @"tabBar_find_on",
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"tabBar_personal_off",
                            CYLTabBarItemSelectedImage : @"tabBar_personal_on",
                            };

    
    NSArray *tabBarItemsAttributes = @[dict1 , dict2 , dict3 , dict4];
    self.tabBarItemsAttributes = tabBarItemsAttributes;
}
/**
 *	统一修改样式
 */
- (void)changeNVC:(UINavigationController *)navigationController{
    
    //删除导航栏下边的黑线
    [navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    navigationController.view.backgroundColor=[UIColor grayColor];
    navigationController.navigationBar.translucent =  NO;//透明
    //导航栏颜色
    navigationController.navigationBar.barTintColor = MainColor;
    //修改UINavigationController title 的颜色和大小
    UIColor * titleColor = [UIColor whiteColor];
    UIFont * font = [UIFont boldSystemFontOfSize:20];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:titleColor,NSForegroundColorAttributeName,font,NSFontAttributeName, nil];
    navigationController.navigationBar.titleTextAttributes = dic;
//    //返回按钮
//    navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    UIViewController *viewController = navigationController.viewControllers[0];
//    UIButton *personalBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [personalBtn setImage:[UIImage imageNamed:@"personal_white.png"] forState:UIControlStateNormal];
//    [personalBtn addTarget:viewController action:@selector(goPersonalVC:) forControlEvents:UIControlEventTouchUpInside];
//    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:personalBtn];
//    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:viewController action:nil];
    //    navigation栏的图片
    //    [navigationController setBackgroundImage:[UIImage imageNamed:@"cpxx-7"] forBarMetrics:UIBarMetricsDefault ];
    //    修改navigation下边框
    //    [navigationController setShadowImage:[UIImage imageNamed:@"cpxx-8"]];
    
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
