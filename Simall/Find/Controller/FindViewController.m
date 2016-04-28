//
//  FindViewController.m
//  JCHProject
//
//  Created by 张浩 on 16/4/12.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "FindViewController.h"
#import "ScanViewController.h"
@interface FindViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *tableView;
@end

static NSString *CellIdentifier = @"TableViewCell";
@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发现";
    
    //cell加入缓存池
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.right.mas_equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 2;
    }
    else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    switch (indexPath.section) {
        case 0:
            if(indexPath.row == 0)
            {
                cell.textLabel.text =  @"商友圈";
            }else{
                cell.textLabel.text =  @"找商友";
            }
            break;
        case 1:
            cell.textLabel.text =  @"集城活动";
            break;
        case 2:
            cell.textLabel.text =  @"扫一扫";
            break;
        default:
            break;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            if(indexPath.row == 0)
            {
            }else{
            }
            break;
        case 1:
            break;
        case 2:
        {
            ScanViewController *rt = [[ScanViewController alloc]init];
            rt.scanResult = ^(NSString *result){
//                BOOL isCard = [result hasPrefix:@"CARD_"];
//                if (isCard) {
//                    if ([PublicObject getUserInfoDefault]) {
//                        CardPwdViewController *cardViewController =[[CardPwdViewController alloc] initWithNibName:@"CardPwdViewController" bundle:nil];
//                        cardViewController.hidesBottomBarWhenPushed = YES;
//                        cardViewController.type = 1;
//                        cardViewController.cardInfo = [result stringByReplacingOccurrencesOfString:@"CARD_" withString:@""];
//                        [self.navigationController pushViewController:cardViewController animated:YES];
//                    }else{
//                        [PublicObject showHUDView:self.view title:@"请先登录" content:@"" time:kHUDTime andCodes:^{
//                            [self login];
//                        }];
//                    }
//                }else{
//                    [self getProductDataByBarCode:result];
//                }
            };
            UINavigationController* libraNav = [[UINavigationController alloc] initWithRootViewController:rt];
            //    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"xtopbg.png"] forBarMetrics:UIBarMetricsDefault];
            //    [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
            //    UIImage *img =[[UIImage alloc] init];
            //    [[UINavigationBar appearance] setShadowImage:img];
            [self.navigationController presentViewController:libraNav animated:YES completion:^{
            }];

        }
            break;
        default:
            break;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
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
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView setTableFooterView:[[UIView alloc]init]];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
@end
