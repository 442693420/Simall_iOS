//
//  PurchaseViewController.m
//  Simall
//
//  Created by 张浩 on 16/4/27.
//  Copyright © 2016年 张浩. All rights reserved.
//
//Controller
#import "PurchaseViewController.h"
//View
#import "MCMenuButton.h"
#import "MenuView.h"
@interface PurchaseViewController ()<UIGestureRecognizerDelegate,MenuViewDelegate,UITableViewDelegate,UITableViewDataSource>
/**
 *  头部筛选模块
 */
@property (nonatomic , strong)UIView *topView;
@property (nonatomic , strong)MCMenuButton *leftButton;
@property (nonatomic , strong)MCMenuButton *rightButton;
@property (nonatomic , strong)MenuView *leftView;
@property (nonatomic , strong)MenuView *rightView;
@property (nonatomic , strong)UITableView *tableView;

@property (nonatomic , strong)NSArray *leftArray;
@property (nonatomic , strong)NSArray *rightArray;
@end

@implementation PurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"采购信息";
    self.view.backgroundColor = [UIColor whiteColor];
    self.leftArray = @[@"发布时间",@"剩余时间"];
    self.rightArray = @[@"已经中标",@"平台担保"];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    
    [self.topView addSubview:self.leftButton];
    [self.topView addSubview:self.rightButton];
    [self.topView addSubview:self.leftView];
    [self.topView addSubview:self.rightView];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left);
        make.top.equalTo(self.topView);
        make.bottom.equalTo(self.topView.mas_bottom).offset(-1);
    }];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftButton.mas_right).offset(1);
        make.right.equalTo(self.topView.mas_right);
        make.width.equalTo(self.leftButton.mas_width);
        make.top.equalTo(self.topView);
        make.bottom.equalTo(self.topView.mas_bottom).offset(-1);
    }];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.leftButton.mas_bottom);
        make.right.equalTo(self.leftButton.mas_right);
        make.height.mas_equalTo(44 * self.leftArray.count);
    }];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.rightButton.mas_bottom);
        make.left.equalTo(self.rightButton.mas_left);
        make.height.mas_equalTo(44 * self.rightArray.count);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
    self.leftView.hidden = YES;
    self.rightView.hidden = YES;
    __weak typeof(self) weakSelf = self;
    
    //点击左侧按钮
    self.leftButton.clickedBlock = ^(id data){
        weakSelf.leftView.hidden = NO;
        weakSelf.rightView.hidden = YES;
    };
    
    //点击右侧按钮
    self.rightButton.clickedBlock = ^(id data){
        weakSelf.leftView.hidden = YES;
        weakSelf.rightView.hidden = NO;
    };
    
    self.currentPage = 1;
    //下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.currentPage = 1;
        [self getDataListWithCurrentPage:self.currentPage andRowOfPage:@"20"];
    }];
    // 上拉刷新方法1
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (self.currentPage == self.allPages) {
            [PublicObject showHUDView:self.view title:@"已经是最后一页" content:@"" time:1 andCodes:^{
                [self.tableView.footer endRefreshing];
            }];
        }else{
            self.currentPage++;
            [self getDataListWithCurrentPage:self.currentPage andRowOfPage:@"20"];
        }
        
    }];
    //
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidenMenuView)];
    click.delegate = self;
    [self.view addGestureRecognizer:click];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableView.header beginRefreshing];
}
//接口
- (void)getDataListWithCurrentPage:(NSInteger)currentPage andRowOfPage:(NSString *)rowOfPage{
    NSDictionary *param = @{@"uid":@"",@"state":@"tj",@"pageSize":@"6",@"orderBySortId":@"true"};
    [ZHRequestBase networkingPostByParam:param methodName:kHomeEngineerRecommend requestStartBlock:^{
    } responseBlock:^(id dataObj, NSError *error) {
        NSLog(@"%@",dataObj);
        if(dataObj){
            NSLog(@"%@",dataObj);
            NSError *err;
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:dataObj
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:&err];
            NSLog(@"%@",dataDic);
            int status = [[dataDic objectForKey:@"flag"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataDic objectForKey:@"msg"]];
            if (status == 1) {
                NSArray *arr = [dataDic objectForKey:@"data"];
               
            }else{
                [PublicObject showHUDView:self.view title:msg content:@"" time:kHUDTime andCodes:^{
                }];
            }
        }else{
            [PublicObject showHUDView:self.view title:@"请求失败" content:@"" time:1 andCodes:^{
            }];
        }
    }];
}
//隐藏menuView
- (void)hidenMenuView{
    self.leftView.hidden = YES;
    self.rightView.hidden = YES;
}
#pragma mark delegate
-(void)menuViewClickWithIndex:(NSInteger)index{
    [self hidenMenuView];
    switch (index) {
        case 0:
            
            break;
            
        default:
            break;
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
-(UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _topView;
}
-(MCMenuButton *)leftButton{
    if (_leftButton == nil) {
        _leftButton = [[MCMenuButton alloc] initWithTitle:@"选择排序"];
        _leftButton.backgroundColor = [UIColor whiteColor];
    }
    return _leftButton;
}
-(MCMenuButton *)rightButton{
    if (_rightButton == nil) {
        _rightButton = [[MCMenuButton alloc] initWithTitle:@"选择类型"];
        _rightButton.backgroundColor = [UIColor whiteColor];
    }
    return _rightButton;
}
-(MenuView *)leftView{
    if (_leftView == nil) {
        _leftView = [[MenuView alloc] initWithDataSource:self.leftArray];
        _leftView.delegate = self;
        _leftView.tag = 0;
    }
    return _leftView;
}
-(MenuView *)rightView{
    if (_rightView == nil) {
        _rightView = [[MenuView alloc]initWithDataSource:self.rightArray];
        _rightView.delegate = self;
        _rightView.tag = 1;
    }
    return _rightView;
}
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CFShow((__bridge CFTypeRef)(self.view.subviews));
    NSLog(@"%@",NSStringFromClass([touch.view class]));
    if ([touch.view isKindOfClass:[MCMenuButton class]]){
        return NO;
    }
    return YES;
}
@end
