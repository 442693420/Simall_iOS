//
//  StoreClassViewController.m
//  Simall
//
//  Created by 张浩 on 16/4/27.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "StoreClassViewController.h"
#import "StoreClassTableViewCell.h"
#import "StoreClassCollectionViewCell.h"
#import "StoreClassCollectionReusableView.h"
@interface StoreClassViewController ()

@end

@implementation StoreClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"商品分类";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.typeArray = [[NSMutableArray alloc] init];
    self.classArray = [[NSMutableArray alloc] init];
    [self setUpLayOut];
    
    [self getType];
    
}
//页面布局
- (void)setUpLayOut {
    //左侧大的列表
    UITableView *tableView = [[UITableView alloc] init];
    tableView.backgroundColor = [UIColor yellowColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorColor = RGB(205, 205, 205, 1);
    tableView.tableFooterView = [[UIView alloc] init];
    self.typeTableView = tableView;
    [self.view addSubview:self.typeTableView];
    [self.typeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.equalTo(@(SCREEN_WIDTH/4));
    }];
    //二级三级列表，分块显示
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.classCollectionView = collectionView;
    self.classCollectionView.backgroundColor = [UIColor whiteColor];
    [self.classCollectionView registerClass:[StoreClassCollectionViewCell class] forCellWithReuseIdentifier:@"StoreClassCollectionViewCell"];
    [self.classCollectionView registerNib:[UINib nibWithNibName:@"StoreClassCollectionReusableView" bundle:nil]
               forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                      withReuseIdentifier:@"StoreClassCollectionReusableView"];//header注册
    self.classCollectionView.delegate = self;
    self.classCollectionView.dataSource = self;
    self.classCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.classCollectionView];
    [self.classCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeTableView.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
//获取一级菜单
- (void)getType {
    NSDictionary *param = @{@"uid":@"",@"parentCode":@"EQUIPMENT_SEARCH",@"parentId":@"ROOT"};
    [ZHRequestBase networkingPostByParam:param methodName:kStoreClassLevel requestStartBlock:^{
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
                self.typeArray = [[NSMutableArray alloc]initWithArray:arr];
                [self.typeTableView reloadData];
                
                //                NSMutableArray *comList = result[@"list"];
                //                for (int i = 0; i < [comList count]; i++) {
                //                    NSMutableDictionary *dic = comList[i];
                //                    StoreClassObject *typeObject = [StoreClassObject mj_objectWithKeyValues:dic];
                //                    [self.typeArray addObject:typeObject];
                //                }
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

//获取二级和三级菜单
- (void)getDetailType:(NSString *)incode {
    NSLog(@"%@",incode);
    NSDictionary *param = @{@"uid":@"",@"parentCode":@"EQUIPMENT_SEARCH",@"parentId":incode};
    [ZHRequestBase networkingPostByParam:param methodName:kStoreClassLevel requestStartBlock:^{
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
                self.classArray = [[NSMutableArray alloc]initWithArray:arr];
                [self.classCollectionView reloadData];
                
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.typeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"UITableViewCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        // Create a cell to display an ingredient.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    
    NSDictionary *typeDic = self.typeArray[indexPath.row];
    cell.textLabel.text = [PublicObject convertNullString:[typeDic objectForKey:@"shortName"]];
    [cell.textLabel setAdjustsFontSizeToFitWidth:YES];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    if (self.selectIndex == nil) {
        self.selectIndex = indexPath;
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell.textLabel setTextColor:RGB(80, 80, 80, 1)];
        [self getDetailType:[typeDic objectForKey:@"id"]];
    } else if ([self.selectIndex isEqual:indexPath]) {
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell.textLabel setTextColor:RGB(80, 80, 80, 1)];
    } else {
        [cell setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [cell.textLabel setTextColor:RGB(99, 100, 100, 1)];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![self.selectIndex isEqual:indexPath]) {
        if (indexPath.row == 0) {
            NSDictionary *typeDic = self.typeArray[indexPath.row];
            [self getDetailType:[typeDic objectForKey:@"id"]];
        }
        UITableViewCell *oldCell = (UITableViewCell *)[tableView cellForRowAtIndexPath:self.selectIndex];
        [oldCell setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [oldCell.textLabel setTextColor:RGB(99, 100, 100, 1)];
        
        UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell.textLabel setTextColor:[UIColor blackColor]];
        self.selectIndex = indexPath;
        if (indexPath.row != 0) {
            NSDictionary *typeDic = self.typeArray[indexPath.row];
            [self getDetailType:[typeDic objectForKey:@"id"]];
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //	UITableViewCell *cell = [self tableView:self.typeTableView cellForRowAtIndexPath:indexPath];
    //	return cell.frame.size.height;
    return 75;
}

#pragma mark -
#pragma mark -- UICollectionViewDataSource
//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.classArray.count;
}

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSDictionary *subClassDic = self.classArray[section];
    NSLog(@"%@",[subClassDic objectForKey:@"productVo"]);
    
    NSData *JSONData = [[subClassDic objectForKey:@"productVo"] dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *subClassArr = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    return [subClassArr count];
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"StoreClassCollectionViewCell";
    StoreClassCollectionViewCell *cell = (StoreClassCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *subClassDic = self.classArray[indexPath.section];
    NSData *JSONData = [[subClassDic objectForKey:@"productVo"] dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *storeClassArr = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    NSDictionary *typeDic = [storeClassArr objectAtIndex:indexPath.row];
    NSString *icon = [PublicObject convertNullString:[typeDic objectForKey:@"imgFilePath"]];
    
    [cell.classImageView sd_setImageWithURL:[NSURL URLWithString:icon]
                           placeholderImage:[UIImage imageNamed:@"default_productClass"]
                                    options:SDWebImageRetryFailed];
    cell.classLabel.text = [NSString stringWithFormat:@"%@ %@",[PublicObject convertNullString:[typeDic objectForKey:@"brand"]],[PublicObject convertNullString:[typeDic objectForKey:@"model"]]];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float width = (collectionView.frame.size.width - 14)/3;
    return CGSizeMake(width , width + 20);
}


//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,0,0,0);
}

// 定义上下cell的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0f;
}

// 定义cell间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

//Header布局
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        StoreClassCollectionReusableView *headerView = (StoreClassCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"StoreClassCollectionReusableView" forIndexPath:indexPath];
        UILabel *label = (UILabel *)[headerView viewWithTag:1];
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            label.font = [UIFont systemFontOfSize:17];
            [label setTextColor:RGB(66, 66, 66, 1)];
            NSDictionary *subClassDic = self.classArray[indexPath.section];
            label.text = [PublicObject convertNullString:[subClassDic objectForKey:@"shortName"]];
        }
        return headerView;
    }
    return nil;
}
//Header 方法
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.classCollectionView.frame.size.width, 30);
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //    StoreClassDetailViewController *storeClassDetailVC = [[StoreClassDetailViewController alloc] initWithNibName:@"StoreClassDetailViewController" bundle:nil];
    //    storeClassDetailVC.hidesBottomBarWhenPushed = YES;
    //    if ([self.isHotBrand isEqualToString:@"品牌"]) {
    //        StoreHotBrandObject *shbObj = self.classArray[indexPath.row];
    //        storeClassDetailVC.shbObj = shbObj;
    //        storeClassDetailVC.classType = FROMBand;
    //    } else {
    //        storeClassDetailVC.classType = FROMClass;
    //        StoreSubClassObject *subClassObj = self.classArray[indexPath.section];
    //        StoreClassObject *typeObj = subClassObj.subList[indexPath.row];
    //        storeClassDetailVC.storeClassObj = typeObj;
    //    }
    //    [self.navigationController pushViewController:storeClassDetailVC animated:YES];
}

//返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
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
