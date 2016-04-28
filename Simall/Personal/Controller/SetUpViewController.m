//
//  SetUpViewController.m
//  JCHProject
//
//  Created by 张浩 on 16/4/21.
//  Copyright © 2016年 张浩. All rights reserved.
//
//Controller
#import "SetUpViewController.h"
//View
#import "LableSwitchTableViewCell.h"
#import "TitleInfoLableTableViewCell.h"
//Object
//Request

@interface SetUpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *tableView;

@property (nonatomic , strong)NSMutableArray *dataOneArr;
@property (nonatomic , strong)NSMutableArray *dataTwoArr;
@end

static NSString *CellIdentifier1 = @"LableSwitchTableViewCell";
static NSString *CellIdentifier2 = @"TitleInfoLableTableViewCell";

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    //cell加入缓存池
    [self.tableView registerClass:[LableSwitchTableViewCell class] forCellReuseIdentifier:CellIdentifier1];
    [self.tableView registerClass:[TitleInfoLableTableViewCell class] forCellReuseIdentifier:CellIdentifier2];
    
    //封装数据
    NSString *jztpStatus = [[NSUserDefaults standardUserDefaults] objectForKey:kIsLoadingPic];
    NSLog(@"%@",jztpStatus);
    NSDictionary *dic1 = @{@"title":@"加载图片",@"info":jztpStatus,@"type":@"switch"};
    NSDictionary *dic2 = @{@"title":@"清理缓存",@"info":@"10.02MB",@"type":@"lable"};
    NSDictionary *dic3 = @{@"title":@"关于集成号",@"info":@"",@"type":@"NO"};
    [self.dataOneArr addObject:dic1];
    [self.dataOneArr addObject:dic2];
    [self.dataTwoArr addObject:dic3];

}
/**
 *  分割线顶头
 */
-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
#pragma tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dataOneArr.count;
    }else{
        return self.dataTwoArr.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSDictionary *dic = [self.dataOneArr objectAtIndex:indexPath.row];
        if (indexPath.row == 0) {
            LableSwitchTableViewCell *cell = (LableSwitchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            cell.titleLab.text = dic[@"title"];
            NSString *status = dic[@"info"];
            if ([status isEqualToString:@"YES"]) {
                cell.switchBtn.on = YES;
            }else{
                cell.switchBtn.on = NO;
            }
            return cell;
        }else{
            TitleInfoLableTableViewCell *cell = (TitleInfoLableTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
            cell.titleLab.text = dic[@"title"];
            cell.infoLab.text = dic[@"info"];
            return cell;
        }
    }else{
        NSDictionary *dic = [self.dataTwoArr objectAtIndex:indexPath.row];
        TitleInfoLableTableViewCell *cell = (TitleInfoLableTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        cell.titleLab.text = dic[@"title"];
        cell.infoLab.hidden = YES;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
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
-(UITableView *)tableView{
    if(_tableView == nil){
         _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}
@end
