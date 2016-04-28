//
//  SupplyAndDemandViewController.m
//  JCHProject
//
//  Created by 张浩 on 16/4/12.
//  Copyright © 2016年 张浩. All rights reserved.
//
//Controller
#import "SupplyAndDemandViewController.h"
//View
#import "SupplyAndDemandPurchaseTableViewCell.h"
#import "SupplyAndDemandDemandTableViewCell.h"
#import "SupplyAndDemandInventoryTableViewCell.h"
//Service

//Request

@interface SupplyAndDemandViewController ()<UITableViewDelegate,UITableViewDataSource,DYSegmentDelegate>

@property (nonatomic , strong)NSMutableArray *purchaseArr;//采购
@property (nonatomic , strong)NSMutableArray *demandArr;//需求
@property (nonatomic , strong)NSMutableArray *inventoryArr;//库存

@end
static NSString *CellIdentifier1 = @"SupplyAndDemandPurchaseTableViewCell";
static NSString *CellIdentifier2 = @"SupplyAndDemandDemandTableViewCell";
static NSString *CellIdentifier3 = @"SupplyAndDemandInventoryTableViewCell";

@implementation SupplyAndDemandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"供需";
    
    [self.tableView registerClass:[SupplyAndDemandPurchaseTableViewCell class] forCellReuseIdentifier:CellIdentifier1];
    [self.tableView registerClass:[SupplyAndDemandDemandTableViewCell class] forCellReuseIdentifier:CellIdentifier2];
    [self.tableView registerClass:[SupplyAndDemandInventoryTableViewCell class] forCellReuseIdentifier:CellIdentifier3];

    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.tableView];
    
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(44);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segmentControl.mas_bottom).offset(0.5);
        make.left.right.mas_equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-44);
    }];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSDictionary *dic12 = @{@"title":@"测试设备",@"time":@"截止日期:2016-01-21",@"status":@"2"};
    NSDictionary *dic13 = @{@"title":@"测试设备",@"time":@"截止日期:2016-01-21",@"status":@"1"};
    NSDictionary *dic14 = @{@"title":@"测试设备",@"time":@"截止日期:2016-01-21",@"status":@"0"};
    NSDictionary *dic15 = @{@"title":@"测试设备",@"time":@"截止日期:2016-01-21",@"status":@"2"};
    NSDictionary *dic16 = @{@"title":@"测试设备",@"time":@"截止日期:2016-01-21",@"status":@"1"};
    NSDictionary *dic17 = @{@"title":@"测试设备",@"time":@"截止日期:2016-01-21",@"status":@"0"};
    self.purchaseArr = [[NSMutableArray alloc]initWithObjects:dic12,dic12,dic13,dic14,dic15,dic16,dic17, nil];

    
    NSDictionary *dic = @{@"image":@"re1.png",@"title":@"联系人:王菲",@"info":@"山东-济宁   有效期至:2016-04-15",@"status":@"0",@"other":@"测试小时，这是一条测试数据，测试列表上的数据是否正确显示。"};
    NSDictionary *dic1 = @{@"image":@"re1.png",@"title":@"联系人:王菲",@"info":@"山东-济宁   有效期至:2016-04-15",@"status":@"0",@"other":@"测试小时，这是一条测试数据，测试列表上的数据是否正确显示。"};
    NSDictionary *dic2 = @{@"image":@"re1.png",@"title":@"联系人:王菲",@"info":@"山东-济宁   有效期至:2016-04-15",@"status":@"1",@"other":@"测试小时，这是一条测试数据，测试列表上的数据是否正确显示。"};
    NSDictionary *dic3 = @{@"image":@"re1.png",@"title":@"联系人:王菲",@"info":@"山东-济宁   有效期至:2016-04-15",@"status":@"0",@"other":@"测试小时，这是一条测试数据，测试列表上的数据是否正确显示。"};
    NSDictionary *dic4 = @{@"image":@"re1.png",@"title":@"联系人:王菲",@"info":@"山东-济宁   有效期至:2016-04-15",@"status":@"1",@"other":@"测试小时，这是一条测试数据，测试列表上的数据是否正确显示。"};
    NSDictionary *dic5 = @{@"image":@"re1.png",@"title":@"联系人:王菲",@"info":@"山东-济宁   有效期至:2016-04-15",@"status":@"0",@"other":@"测试小时，这是一条测试数据，测试列表上的数据是否正确显示。"};
    self.demandArr = [[NSMutableArray alloc]initWithObjects:dic,dic1,dic2,dic3,dic4,dic5, nil];
    
    
    NSDictionary *dic6 = @{@"image":@"re1.png",@"title":@"名称:摄像头",@"price":@"价格:￥2321.00",@"count":@"数量:0",@"brand":@"品牌:12312",@"model":@"型号:312",@"time":@"有效时间:2016-03-04"};
    NSDictionary *dic7 = @{@"image":@"re1.png",@"title":@"名称:摄像头",@"price":@"价格:￥2321.00",@"count":@"数量:0",@"brand":@"品牌:12312",@"model":@"型号:312",@"time":@"有效时间:2016-03-04"};
    NSDictionary *dic8 = @{@"image":@"re1.png",@"title":@"名称:摄像头",@"price":@"价格:￥2321.00",@"count":@"数量:0",@"brand":@"品牌:12312",@"model":@"型号:312",@"time":@"有效时间:2016-03-04"};
    NSDictionary *dic9 = @{@"image":@"re1.png",@"title":@"名称:摄像头",@"price":@"价格:￥2321.00",@"count":@"数量:0",@"brand":@"品牌:12312",@"model":@"型号:312",@"time":@"有效时间:2016-03-04"};
    NSDictionary *dic10 = @{@"image":@"re1.png",@"title":@"名称:摄像头",@"price":@"价格:￥2321.00",@"count":@"数量:0",@"brand":@"品牌:12312",@"model":@"型号:312",@"time":@"有效时间:2016-03-04"};
    NSDictionary *dic11 = @{@"image":@"re1.png",@"title":@"名称:摄像头",@"price":@"价格:￥2321.00",@"count":@"数量:0",@"brand":@"品牌:12312",@"model":@"型号:312",@"time":@"有效时间:2016-03-04"};
    self.inventoryArr = [[NSMutableArray alloc]initWithObjects:dic6,dic7,dic8,dic9,dic10,dic11, nil];
    
    
    [self.tableView reloadData];
    
    [self viewDidLayoutSubviews];

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
#pragma tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = 0;
    switch (self.tableView.tag) {
        case 0:
            count = self.purchaseArr.count;
            break;
        case 1:
            count = self.demandArr.count;
            break;
        case 2:
            count = self.inventoryArr.count;
            break;
        default:
            break;
    }
    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableView.tag == 0) {
        SupplyAndDemandPurchaseTableViewCell *cell = (SupplyAndDemandPurchaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        NSDictionary *dic = [self.purchaseArr objectAtIndex:indexPath.row];
        cell.dic = dic;
        [cell showView];
        return cell;
    }else if (self.tableView.tag == 1){
        SupplyAndDemandDemandTableViewCell *cell = (SupplyAndDemandDemandTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        NSDictionary *dic = [self.demandArr objectAtIndex:indexPath.row];
        cell.dic = dic;
        [cell showView];
        return cell;
    }else{
        SupplyAndDemandInventoryTableViewCell *cell = (SupplyAndDemandInventoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        NSDictionary *dic = [self.inventoryArr objectAtIndex:indexPath.row];
        cell.dic = dic;
        [cell showView];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSDictionary *dic = self.dataArray[indexPath.row];
//    CGFloat height = [TitleInfoNormalLabelTableViewCell rowHeightWithString:dic[@"title"] isArrow:YES];
    if (self.tableView.tag == 0) {
        return 70;
    }else if (self.tableView.tag == 1){
        return 100;
    }else{
        return 130;
    }
}


- (void)segmentControl:(DYSegment *)segmentControl didSelectAtIndex:(NSUInteger)index{
    self.tableView.tag = index;
    [self.tableView reloadData];
}

#pragma mark - getter and setter
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        [_tableView setTableFooterView:[[UIView alloc]init]];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;

}
- (DYSegment *)segmentControl{
    if (_segmentControl == nil) {
        DYSegmentConfiguration *configuration =
        [DYSegmentConfiguration configurationWithItems:@[
                                                         @"采购信息",
                                                         @"需求信息",
                                                         @"库存信息"
                                                         ]];
        configuration.itemTextColor = [UIColor darkGrayColor];
        configuration.itemSelectedTextColor = [UIColor darkGrayColor];
        _segmentControl = [DYSegment
                           segmentControlWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44.f)
                           configuration:configuration
                           delegate:self];
    }
    return _segmentControl;
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
