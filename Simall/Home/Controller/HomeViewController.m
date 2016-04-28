//
//  HomeViewController.m
//  JCHProject
//
//  Created by 张浩 on 16/4/12.
//  Copyright © 2016年 张浩. All rights reserved.
//
//Controller
#import "HomeViewController.h"
#import "JCWebViewController.h"
#import "SearchViewController.h"
#import "LoginViewController.h"
#import "SupplyAndDemandViewController.h"
#import "ProductDetailViewController.h"
#import "SetUpViewController.h"
#import "PurchaseViewController.h"
//View
#import "AdvertScrollView.h"
#import "HomeUpdateTableViewCell.h"
#import "HomeUpdateView.h"
#import "HomeSectionHeadView.h"
#import "HomeProductRecommendTableViewCell.h"
#import "HomeProductRecommendView.h"
#import "HomeEngineerRecommendTableViewCell.h"
#import "HomeEngineerRecommendView.h"
#import "HomeMethodRecommendTableViewCell.h"
#import "HomeMethodRecommendView.h"

#import "HomeLeftView.h"
#import "HomeBottomPopView.h"

@interface HomeViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,ZHAdvertScrollViewDelegate,HomeUpdateViewDelegate,HomeProductRecommendViewDelegate,HomeProductRecommendTableViewCellDelegate,HomeEngineerRecommendViewDelegate,HomeEngineerRecommendTableViewCellDelegate,HomeMethodRecommendTableViewCellDelegate,HomeMethodRecommendViewDelegate,HomeLeftViewDelegate,HomeBottomPopViewDelegate>

@property (nonatomic, copy)NSString *searchText;
@property (nonatomic, strong)UITextField *textFieldForSearch;
@property (nonatomic , strong)UITableView *tableView;
@property(nonatomic, strong) AdvertScrollView *adVertScrollView;
@property(nonatomic , strong)UIView *homeBtnBackView;
@property(nonatomic , strong)HomeLeftView *homeLeftView;
@property(nonatomic , strong)HomeBottomPopView *homeBottomView;
@property(nonatomic , strong)UIButton *leftButton;

//数据
@property (nonatomic , strong)NSArray *adArr;
@property (nonatomic , strong)NSMutableDictionary *updateDic;//最新更新数据
@property (nonatomic , strong)NSMutableArray *productRecommendArr;//商品推荐数据
@property (nonatomic , strong)NSMutableArray *engineerRecommendArr;//工程师推荐数据
@property (nonatomic , strong)NSMutableArray *methodRecommendArr;//方案推荐数据

@end

static NSString *headCellIdentifier = @"HeadCell";
static NSString *cellIdentifierUpdate = @"HomeUpdateTableViewCell";
static NSString *cellIdentifierProductRecommend = @"HomeProductRecommendTableViewCell";
static NSString *cellIdentifierEngineerRecommend = @"HomeEngineerRecommendTableViewCell";
static NSString *cellIdentifierMethodRecommend = @"HomeMethodRecommendTableViewCell";


@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(showHomeBottomPopView) name:@"showHomeBottomPopView" object:nil];
    
    UITextField *searchForTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 30)];
    [searchForTextField setBackgroundColor:[UIColor whiteColor]];
    searchForTextField.delegate = self;
    searchForTextField.placeholder = @"请输入商品关键字";
    [searchForTextField addTarget:self action:@selector(methodOfTextField) forControlEvents:UIControlEventEditingChanged];//
    searchForTextField.font = [UIFont systemFontOfSize:14.0f];
    searchForTextField.returnKeyType = UIReturnKeySearch;
    searchForTextField.textColor = [UIColor darkGrayColor];
    searchForTextField.layer.cornerRadius = 5.0f;
    [searchForTextField setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.textFieldForSearch = searchForTextField;
    self.navigationItem.titleView = self.textFieldForSearch;
    
    //搜索图片
    UIView *searchLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setFrame:CGRectMake(0, 3, 24, 24)];
    [searchBtn setImage:[UIImage imageNamed:@"sdjsdasw"] forState:UIControlStateNormal];
    searchBtn.userInteractionEnabled = NO;
    [searchLeftView addSubview:searchBtn];
    self.textFieldForSearch.leftView = searchLeftView;
    self.textFieldForSearch.leftViewMode = UITextFieldViewModeAlways;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backBefore:)];
    [self.navigationItem setHidesBackButton:YES];
    
    
    //导航栏按钮
    self.leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,20,20)];
    [self.leftButton setImage:[UIImage imageNamed:@"home_menu.png"] forState:UIControlStateNormal];
    //    [self.leftButton setTitle:@"更多" forState:UIControlStateNormal];
    [self.leftButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    [self.leftButton addTarget:self action:@selector(presentLeftVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftButton];
    self.navigationItem.leftBarButtonItem= leftItem;
    
    
    //导航栏按钮
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,20,20)];
    [rightButton setImage:[UIImage imageNamed:@"home_bigM.png"] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    [rightButton addTarget:self action:@selector(presentRightVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    [self.view addSubview:self.tableView];
    //    UITabBarController *tabBarControler = (id)UIApplication.sharedApplication.delegate.window.rootViewController;
    //    [self.view insertSubview:self.homeLeftView aboveSubview:tabBarControler.view];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate.window addSubview:self.homeLeftView];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    [self.homeLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCREEN_HEIGHT-64);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.centerY.mas_equalTo(delegate.window.mas_centerY).offset(32);
        make.centerX.mas_equalTo(0).mas_offset(-SCREEN_WIDTH);
    }];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:headCellIdentifier];
    [self.tableView registerClass:[HomeUpdateTableViewCell class] forCellReuseIdentifier:cellIdentifierUpdate];
    [self.tableView registerClass:[HomeProductRecommendTableViewCell class] forCellReuseIdentifier:cellIdentifierProductRecommend];
    [self.tableView registerClass:[HomeEngineerRecommendTableViewCell class] forCellReuseIdentifier:cellIdentifierEngineerRecommend];
    [self.tableView registerClass:[HomeMethodRecommendTableViewCell class] forCellReuseIdentifier:cellIdentifierMethodRecommend];
    
    
    //假的滑动广告
    //    NSString *ad1 = @"http://asimg.zzxb.me/upload/img/f3842c72547e4170afad2a786d019e64.jpg";
    //    NSString *ad2 = @"http://asimg.zzxb.me/upload/img/4580d4455ede424788a0709041a802da.jpg";
    //    NSString *ad3 = @"http://asimg.zzxb.me/upload/img/1e9530a073e442ffbfd79e74ec1f74c2.jpg";
    
    //    self.adArr = @[[NSURL URLWithString:ad1],[NSURL URLWithString:ad2],[NSURL URLWithString:ad3]];
    self.adArr = @[[UIImage imageNamed:@"ad1.png"],[UIImage imageNamed:@"ad2.png"],[UIImage imageNamed:@"ad3.png"]];
    [self loadAdvertScrollViewImages];
    //
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //获取最新更新数据
    [self getUpdateData];
}
#pragma mark 接口
//最新更新接口
- (void)getUpdateData{
    NSDictionary *param = @{@"uid":@""};
    [ZHRequestBase networkingPostByParam:param methodName:kHomeUpdate requestStartBlock:^{
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
                self.updateDic = [dataDic objectForKey:@"data"];
                //获取产品推荐商品
                [self getProductRecommend];
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
//商品推荐接口
- (void)getProductRecommend{
    NSDictionary *param = @{@"uid":@"",@"state":@"tj",@"pageSize":@"10",@"orderBySortId":@"true"};
    [ZHRequestBase networkingPostByParam:param methodName:kHomeProductRecommend requestStartBlock:^{
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
                self.productRecommendArr = [[NSMutableArray alloc]initWithArray:arr];
                [self getEngineerRecommend];
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
//工程师推荐接口
- (void)getEngineerRecommend{
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
                self.engineerRecommendArr = [[NSMutableArray alloc]initWithArray:arr];
                [self getMethodRecommend];
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
//方案推荐接口
- (void)getMethodRecommend{
    NSDictionary *param = @{@"uid":@"",@"state":@"tj",@"pageSize":@"3",@"orderBySortId":@"true"};
    [ZHRequestBase networkingPostByParam:param methodName:kHomeMethodRecommend requestStartBlock:^{
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
                self.methodRecommendArr = [[NSMutableArray alloc]initWithArray:arr];
                [self.tableView reloadData];
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
- (void)presentLeftVC{
    CFShow((__bridge CFTypeRef)(self.homeLeftView));
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (self.homeLeftView.status == 0) {
        [self.homeLeftView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
        }];
        [UIView animateWithDuration:0.5f animations:^{
            [delegate.window layoutIfNeeded];
        }];
        [UIView animateWithDuration:.3 animations:^{
            self.leftButton.transform = CGAffineTransformMakeRotation(M_PI_2);
            [self.leftButton setImage:[UIImage imageNamed:@"home_arrow.png"] forState:UIControlStateNormal];
        }];
        self.homeLeftView.status = 1;
    }else{
        [self hidenHomeLeftView];
    }
    
}
- (void)presentRightVC{
    SearchViewController *viewController = [[SearchViewController alloc]init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES
     ];
}
#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return SCREEN_WIDTH*0.5;
    }else if(indexPath.section == 1){
        return SCREEN_WIDTH / 3 + 30;
    }else if(indexPath.section == 2 ){
        return (SCREEN_WIDTH / 2 +30 ) * (self.productRecommendArr.count/2) + (self.productRecommendArr.count/2)*1; //最后*的3和+的3  是加载数据.count/2
    }
    else if(indexPath.section == 3){
        return (SCREEN_WIDTH - 16)/3+30;
    }
    else if (indexPath.section == 4){
        return (SCREEN_WIDTH - 16)/3+30 + 60;
    }
    else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HomeSectionHeadView *headView = [[HomeSectionHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    if (section == 1) {
        headView.titleView.backgroundColor = [UIColor blueColor];
        headView.titleLab.text = @"最近更新";
        return headView;
    }
    else if (section == 2){
        headView.titleView.backgroundColor = [UIColor redColor];
        headView.titleLab.text = @"产品推荐";
        return headView;
    }
    else if (section == 3){
        headView.titleView.backgroundColor = [UIColor orangeColor];
        headView.titleLab.text = @"工程师推荐";
        return headView;
    }
    else if (section == 4){
        headView.titleView.backgroundColor = [UIColor purpleColor];
        headView.titleLab.text = @"方案推荐";
        return headView;
    }
    else{
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    else{
        return 44;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headCellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell addSubview:self.adVertScrollView];
        return cell;
    }
    else if(indexPath.section == 1){
        HomeUpdateTableViewCell *cell = (HomeUpdateTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifierUpdate];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        NSString *center1 = [NSString stringWithFormat:@"+%@",[PublicObject convertNullString:[self.updateDic objectForKey:@"tsupplyAskingCount"]]];
        NSString *center2 = [NSString stringWithFormat:@"+%@",[PublicObject convertNullString:[self.updateDic objectForKey:@"tprojectRequirementsCount"]]];
        NSString *center3 = [NSString stringWithFormat:@"+%@",[PublicObject convertNullString:[self.updateDic objectForKey:@"tinventoryReleaseCount"]]];
        NSString *bottom1 = [PublicObject convertNullString:[self.updateDic objectForKey:@"supplyAskingCount"]];
        NSString *bottom2 = [PublicObject convertNullString:[self.updateDic objectForKey:@"projectRequirementsCount"]];
        NSString *bottom3 = [PublicObject convertNullString:[self.updateDic objectForKey:@"inventoryReleaseCount"]];
        
        NSDictionary *dic1 = @{@"title":@"最新询价",@"center":center1,@"bottom":bottom1};
        NSDictionary *dic2 = @{@"title":@"最新需求",@"center":center2,@"bottom":bottom2};
        NSDictionary *dic3 = @{@"title":@"最新库存",@"center":center3,@"bottom":bottom3};
        cell.oneView = [[HomeUpdateView alloc]initWithTitleStr:dic1[@"title"] nowNumStr:dic1[@"center"] allNumStr:dic1[@"bottom"] titleImgColor:RGB(45, 170, 250, 1) Tag:0];
        cell.twoView = [[HomeUpdateView alloc]initWithTitleStr:dic2[@"title"] nowNumStr:dic2[@"center"] allNumStr:dic2[@"bottom"] titleImgColor:RGB(253, 147, 38, 1) Tag:1];
        cell.threeView = [[HomeUpdateView alloc]initWithTitleStr:dic3[@"title"] nowNumStr:dic3[@"center"] allNumStr:dic3[@"bottom"] titleImgColor:RGB(47, 176, 11, 1) Tag:1];
        cell.oneView.delegate = self;
        cell.twoView.delegate = self;
        cell.threeView.delegate = self;
        [cell showView];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
    else if(indexPath.section == 2){
        HomeProductRecommendTableViewCell *cell = (HomeProductRecommendTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifierProductRecommend];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if (self.productRecommendArr.count != 0 &&self.productRecommendArr != nil) {
            cell.dataArr = [[NSMutableArray alloc]initWithArray:self.productRecommendArr];
            cell.delegate = self;
            [cell showView];
        }
        return cell;
    }
    else if(indexPath.section == 3){
        HomeEngineerRecommendTableViewCell *cell = (HomeEngineerRecommendTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifierEngineerRecommend];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if (self.engineerRecommendArr.count != 0 &&self.engineerRecommendArr != nil) {
        cell.dataArr = [[NSMutableArray alloc]initWithArray:self.engineerRecommendArr];
        [cell showView];
        }
        return cell;
    }
    else{
        HomeMethodRecommendTableViewCell *cell = (HomeMethodRecommendTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifierMethodRecommend];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if (self.methodRecommendArr.count != 0 &&self.methodRecommendArr != nil) {
        cell.dataArr = [[NSMutableArray alloc]initWithArray:self.methodRecommendArr];
        [cell showView];
        }
        return cell;
        
    }
    //    else if(indexPath.row == 5){
    //           }
    //    else if(indexPath.section == 6){
    //        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:seveenCellIdentifier];
    //        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //        cell.textLabel.text = @"超级性价比推荐";
    //        cell.textLabel.textColor = [UIColor darkGrayColor];
    //        cell.textLabel.font = [UIFont systemFontOfSize:14];
    //        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //        return cell;
    //    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *	载入滚动展示图片
 */
- (void)loadAdvertScrollViewImages {
    //    NSMutableArray *imageUrls = [[NSMutableArray alloc] init];
    //    for (HomeBannerObject *banner in self.scrollNewsArr) {
    //        [imageUrls addObject:[NSURL URLWithString:banner.newspicture]];
    //    }
    //    [self.adVertScrollView configViewsWithImageURLs:self.adArr titles:nil];
    [self.adVertScrollView configViewsWithImages:self.adArr titles:nil];
}
#pragma mark - Delegate

//bannerView
- (void)clickedImageIndex:(NSInteger)index {
    //    if (index < self.scrollNewsArr.count) {
    //        HomeBannerObject *object = self.scrollNewsArr[index];
    //        DYLog(object.headtitle);
    //        NewsDetailViewController *newsDetailVC = [[NewsDetailViewController alloc]
    //                                                  initWithNibName:@"NewsDetailViewController"
    //                                                  bundle:nil];
    //        newsDetailVC.newsId = object.idcode;
    //        newsDetailVC.hidesBottomBarWhenPushed = YES;
    //        [self.navigationController pushViewController:newsDetailVC animated:YES];
    //
    //    }
}
//leftView
- (void)hidenHomeLeftView{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.homeLeftView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0).mas_offset(-SCREEN_WIDTH);
    }];
    [UIView animateWithDuration:0.5f animations:^{
        [delegate.window layoutIfNeeded];
    }];
    [UIView animateWithDuration:.3 animations:^{
        self.leftButton.transform = CGAffineTransformMakeRotation(0);
        [self.leftButton setImage:[UIImage imageNamed:@"home_menu.png"] forState:UIControlStateNormal];
    }];
    self.homeLeftView.status = 0;
    
}
-(void)clickHomeLeftViewWithIndex:(NSInteger)index{
    [self hidenHomeLeftView];
    JCWebViewController *viewController = [[JCWebViewController alloc]init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}
-(void)clickHomeLeftViewSetUpView{
    [self hidenHomeLeftView];
    SetUpViewController *viewController = [[SetUpViewController alloc]init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}
-(void)clickHomeLeftViewModelView{
    [self hidenHomeLeftView];
    
}
//updateCell
-(void)homeUpdateViewClickWithBtnTag:(NSInteger)btnTag{
    switch (btnTag) {
        case 0://最新询价
        {
            PurchaseViewController *viewController = [[PurchaseViewController alloc]init];
            viewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 1://最新需求
        {
            
        }
            break;
        case 2://最新库存
        {
            
        }
            break;
            
        default:
            break;
    }
}
//thirdCell
- (void)homeTitleLabMoreBtnInfoLabViewClickWithBtnTag:(NSInteger)btnTag{
    SupplyAndDemandViewController *viewController = [[SupplyAndDemandViewController alloc]init];
    if (btnTag == 0) {//最新询价
        viewController.tableView.tag = 0;
    }else{//最新需求
        viewController.tableView.tag = 1;
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 1 + 10000;
        [viewController.segmentControl clickSegmentItem:btn];
    }
    [self.navigationController pushViewController:viewController animated:YES];
}
//fourCell
- (void)homeTitleLabMoreBtnInfoImgViewClickWithBtnTag:(NSInteger)btnTag{
    if (btnTag == 0) {//本周热销
        
    }else{//下周热销
        
    }
}
//fiveCell
-(void)clickedLabIndex:(NSInteger)index{
    
}
//sixCell
-(void)homeTitleLabCenterBtnInfoLabViewClickWithBtnTag:(NSInteger)btnTag{
    
}
//sevenCell
-(void)clickHomeFiveTableViewCellWithIndex:(NSInteger)index{
    //    switch (index) {
    //        case 0:
    //        {
    //        }
    //
    //            break;
    //
    //        default:
    //            break;
    //    }
    ProductDetailViewController *viewController = [[ProductDetailViewController alloc]init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES
     ];
}
//homeBottmPopView
-(void)hidenHomeBottomPopView{
    
    UITabBarController *tabBarControler = (id)UIApplication.sharedApplication.delegate.window.rootViewController;
    for (UIView *view in tabBarControler.view.subviews) {
        if ([view isKindOfClass:[HomeBottomPopView class]]) {
            [view removeFromSuperview];
        }
    }
}
-(void)clickHomeBottomPopViewWithIndex:(NSInteger)index{
    [self hidenHomeBottomPopView];
    [self goToLoginVC];
    //    switch (index) {
    //        case 0:
    //        {
    //
    //        }
    //            break;
    //
    //        default:
    //            break;
    //    }
}
#pragma mark nsnotification
- (void)showHomeBottomPopView{
    //获取rootTabBarController
    UITabBarController *tabBarControler = (id)UIApplication.sharedApplication.delegate.window.rootViewController;
    [tabBarControler.view addSubview:self.homeBottomView];
    [self.homeBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCREEN_HEIGHT);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.centerY.centerX.mas_equalTo(tabBarControler.view);
    }];
}
-(void)goToLoginVC{
    LoginViewController *loginController = [[LoginViewController alloc]init];
    UINavigationController *newNVC = [[UINavigationController alloc]initWithRootViewController:loginController];
    newNVC.tabBarItem.title = @"登 录";
    
    newNVC.navigationBar.translucent =  NO;//透明
    //导航栏颜色
    newNVC.navigationBar.barTintColor = MainColor;
    //修改UINavigationController title 的颜色和大小
    UIColor * titleColor = [UIColor whiteColor];
    UIFont * font = [UIFont boldSystemFontOfSize:20];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:titleColor,NSForegroundColorAttributeName,font,NSFontAttributeName, nil];
    newNVC.navigationBar.titleTextAttributes = dic;
    
    //    loginController.dismissView = ^(BOOL isSuccess){
    //        if (isSuccess) {
    //            [self dismissViewControllerAnimated:YES completion:^{
    //            }];
    //        }else{
    //            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
    //        }
    //    };
    
    //调用此方法显示模态窗口
    [self presentViewController:newNVC animated:YES completion:nil];
    
}
//section不跟随滑动
#pragma mark delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView ==_tableView)
    {
        CGFloat sectionHeaderHeight = 44;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y,0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}
#pragma mark - getter and setter
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView setTableFooterView:[[UIView alloc]init]];
    }
    return _tableView;
}
- (AdvertScrollView *)adVertScrollView {
    if (_adVertScrollView == nil) {
        _adVertScrollView = [[AdvertScrollView alloc]
                             initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.5)];
        _adVertScrollView.backgroundColor = [UIColor whiteColor];
        _adVertScrollView.delegate = self;
    }
    return _adVertScrollView;
}
-(UIView *)homeBtnBackView{
    if (_homeBtnBackView == nil) {
        _homeBtnBackView = [[UIView alloc]init];
        _homeBtnBackView.backgroundColor = [UIColor whiteColor];
    }
    return _homeBtnBackView;
}
-(HomeLeftView *)homeLeftView{
    if (_homeLeftView == nil) {
        NSDictionary *dic1 = @{@"title":@"技术交流",@"image":@"home_left_jsjl"};
        NSDictionary *dic2 = @{@"title":@"集城规范",@"image":@"home_left_jcgf"};
        NSDictionary *dic3 = @{@"title":@"集成网站",@"image":@"home_left_jcwz"};
        NSArray *arr = @[dic1,dic2,dic3];
        _homeLeftView = [[HomeLeftView alloc]initWithTableViewArr:arr];
        _homeLeftView.delegate = self;
        _homeLeftView.status = 0;
    }
    return _homeLeftView;
}
-(HomeBottomPopView *)homeBottomView{
    if (_homeBottomView == nil) {
        NSDictionary *dic1 = @{@"title":@"采购询价",@"image":@"home_btn1.png"};
        NSDictionary *dic2 = @{@"title":@"需求发布",@"image":@"home_btn2.png"};
        NSDictionary *dic3 = @{@"title":@"库存发布",@"image":@"home_btn3.png"};
        NSDictionary *dic4 = @{@"title":@"库存发布",@"image":@"home_btn4.png"};
        NSArray *arr = @[dic1,dic2,dic3,dic4];
        _homeBottomView = [[HomeBottomPopView alloc]initWithBtnArr:arr];
        _homeBottomView.delegate = self;
        _homeBottomView.status = 0;
    }
    return _homeBottomView;
}
@end
