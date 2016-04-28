//
//  SearchViewController.m
//  JCHProject
//
//  Created by 张浩 on 16/4/14.
//  Copyright © 2016年 张浩. All rights reserved.
//
//Controller
//View
#import "SearchTableViewCell.h"
//Object
//Request
#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITextField *searchForTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 30)];
    [searchForTextField setBackgroundColor:RGB(63, 188, 240, 1)];
    searchForTextField.delegate = self;
    searchForTextField.placeholder = @"请输入商品名称";
    [searchForTextField addTarget:self action:@selector(methodOfTextField) forControlEvents:UIControlEventEditingChanged];//
    searchForTextField.font = [UIFont systemFontOfSize:14.0f];
    searchForTextField.returnKeyType = UIReturnKeySearch;
    searchForTextField.textColor = [UIColor whiteColor];
    searchForTextField.layer.cornerRadius = 5.0f;
    [searchForTextField setValue:RGB(255, 255, 255, 0.6) forKeyPath:@"_placeholderLabel.textColor"];
    self.textFieldForSearch = searchForTextField;
    self.navigationItem.titleView = self.textFieldForSearch;
    
    //搜索图片
    UIView *searchLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setFrame:CGRectMake(0, 3, 24, 24)];
    [searchBtn setImage:[UIImage imageNamed:@"sdj-w"] forState:UIControlStateNormal];
    searchBtn.userInteractionEnabled = NO;
    [searchLeftView addSubview:searchBtn];
    self.textFieldForSearch.leftView = searchLeftView;
    self.textFieldForSearch.leftViewMode = UITextFieldViewModeAlways;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backBefore:)];
    [self.navigationItem setHidesBackButton:YES];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollViewForMain = scrollView;
    self.scrollViewForMain.scrollEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.scrollViewForMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 在scrollView上加个view，根据view的高度控制scrollView的contentSize
    UIView *containerV = [UIView new];
    containerV.backgroundColor = [UIColor clearColor];
    [self.scrollViewForMain addSubview:containerV];
    self.container = containerV;
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollViewForMain);
        make.width.equalTo(self.scrollViewForMain);
    }];
    
    UITableView *productForTableView = [[UITableView alloc]init];
    productForTableView.scrollEnabled = NO;
    productForTableView.delegate = self;
    productForTableView.dataSource = self;
    self.tableViewForProduct = productForTableView;
    [self.container addSubview:productForTableView];
    [self getData];
    NSInteger num = [self.countList count];
    [self.tableViewForProduct mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.container.mas_top);
        make.left.equalTo(self.container.mas_left);
        make.right.equalTo(self.container.mas_right);
        make.centerX.equalTo(self.container.mas_centerX);
        make.height.mas_equalTo(44*num+25);
    }];
    //清除历史记录按钮
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"清除历史记录" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    button.backgroundColor = MainColor;
    button.tintColor = [UIColor whiteColor];
    if (num == 0) {
        button.hidden = YES;
    }
    else {
        button.hidden = NO;
    }
    button.layer.cornerRadius = 10.0f;
    [button addTarget:self action:@selector(dataOfDelete:) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:button];
    self.buttonForClear = button;
    [self.buttonForClear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableViewForProduct.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.container.mas_centerX);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(100);
    }];
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.buttonForClear.mas_bottom).with.offset(10);
    }];
    
    UISwipeGestureRecognizer *recongnier = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    recongnier.numberOfTouchesRequired = 1;
    recongnier.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
    [self.container addGestureRecognizer:recongnier];
}


- (void)viewWillAppear:(BOOL)animated {
    [self.textFieldForSearch becomeFirstResponder];
    if (self.searchText.length>0) {
        [self.textFieldForSearch setText:self.searchText];
        //        [[self.textFieldForSearch resignFirstResponder]
        [self methodOfTextField];
    }
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    [self.textFieldForSearch resignFirstResponder];
}

#pragma mark - 从userDefault获取历史记录
- (void)getData {
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSMutableData *data = [userDefault objectForKey:@"searchedProduct_V2.0"];
//    self.searchBeforeList = [[NSMutableArray alloc]init];
//    if (data != nil) {
//        self.searchBeforeList = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
//    }
//    self.countList = [[NSMutableArray alloc]init];
//    self.countList = self.searchBeforeList;
}

#pragma mark - 清除历史按钮
- (void)dataOfDelete:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"确认删除历史记录？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
    [self.textFieldForSearch resignFirstResponder];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        self.searchBeforeList = [[NSMutableArray alloc]init];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault removeObjectForKey:@"searchedProduct_V2.0"];
        [userDefault synchronize];
        [self.tableViewForProduct mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(25);
        }];
        [self.buttonForClear setHidden:YES];
        [self.tableViewForProduct reloadData];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.textFieldForSearch resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (self.textFieldForSearch.text.length > 0) {
        [self.textFieldForSearch resignFirstResponder];
//        SearchObject *search = self.countList[0];
//        [self saveSeachHistory];
//        SearchResultViewController *scdVC = [[SearchResultViewController alloc] init];
//        scdVC.searchObject = search;
//        [self.navigationController pushViewController:scdVC animated:YES];
    }
    return NO;
}

#pragma mark - textField响应事件
- (void)methodOfTextField {
    NSString *searchText = self.textFieldForSearch.text;
    UITextRange *selectedRange = self.textFieldForSearch.markedTextRange;
    NSString * newText = [self.textFieldForSearch textInRange:selectedRange];  //获取高亮部分
    if(newText.length==0){
        NSLog(@"%@",self.textFieldForSearch.text);
        NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        searchText = [searchText stringByTrimmingCharactersInSet:whitespace];
        if (searchText.length > 0 && ![[PublicObject convertNullString:searchText] isEqualToString:@""]) {
            self.buttonForClear.hidden = YES;
            [self searchGoodsProperty];
        }
        else {
            self.countList = self.searchBeforeList;
            NSInteger hehe = [self.countList count];
            if (hehe != 0) {
                self.buttonForClear.hidden = NO;
            }
            [self.tableViewForProduct mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(44*hehe+25);
            }];
            [self.tableViewForProduct reloadData];
        }
    }
}


#pragma mark - 类别搜索
- (void)searchGoodsProperty {
    //http://172.19.2.19:8080/mgy/api/store/search.do?action=queryGoodsProperty&keyWords=1&type=1
//    NSMutableDictionary *parametersDic = [[NSMutableDictionary alloc]init];
//    NSString *contentString = self.textFieldForSearch.text;
//    contentString = [contentString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [parametersDic setValue:contentString forKey:@"keyWords"];
//    NSString *type = [NSString stringWithFormat:@"%ld",(long)[PublicObject publicModelType]];
//    if ([type isEqualToString:@"0"]) {
//        type = @"3";//首页
//    }
//    [parametersDic setValue:type forKey:@"type"];//1便利店  2家装 3便利店或者家装
//    [[ServerObject shareNetService] GetData:kQueryGoodsProperty andParameters:parametersDic andSuccess:^(NSMutableDictionary *successDictionary) {
//        NSDictionary *result = successDictionary;
//        int status = [[result objectForKey:@"status"] intValue];
//        if (status == 0) {
//            
//            if (self.textFieldForSearch.text.length==0) {
//                return;
//            }
//            
//            self.productList = [[NSMutableArray alloc]init];
//            NSArray *arrayList = [result objectForKey:@"obj"];
//            for (int i = 0; i < [arrayList count]; i++) {
//                SearchObject *sspo = [SearchObject mj_objectWithKeyValues:arrayList[i]];
//                [self.productList addObject:sspo];
//            }
//            //添加搜索内容
//            SearchObject *sspo = [[SearchObject alloc] init];
//            [sspo setTypeName:self.textFieldForSearch.text];
//            [self.productList insertObject:sspo atIndex:0];
//            self.countList = self.productList;
//            
//            NSInteger numHa = [self.countList count];
//            [self.tableViewForProduct mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(44*numHa+25);
//            }];
//            [self.tableViewForProduct reloadData];
//        }
//        else {
//            [PublicObject showHUDView:self.view title:kNetWorkError content:@"" time:kHUDTime andCodes:^{
//            }];
//        }
//    } andFailure:^(NSError *error) {
//        [PublicObject showHUDView:self.view title:kNetWorkError content:@"" time:kHUDTime andCodes:^{
//        }];
//    }];
}

/**
 *  保存搜索记录
 */
-(void)saveSeachHistory{
    NSLog(@"%lu",self.textFieldForSearch.text.length);
    if (self.textFieldForSearch.text.length==0) {
        return;
    }
//    SearchObject *sspo = [[SearchObject alloc] init];
//    [sspo setTypeName:self.textFieldForSearch.text];
//    NSInteger beforeCount = [self.searchBeforeList count];
//    if (beforeCount > 0) {
//        __block NSInteger searchIndex = -1;
//        [self.searchBeforeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            SearchObject *searchObj = (SearchObject *)obj;
//            if ([searchObj.typeName isEqualToString:sspo.typeName]) {
//                searchIndex = idx;
//            }
//        }];
//        if (searchIndex >= 0) {
//            [self.searchBeforeList exchangeObjectAtIndex:searchIndex withObjectAtIndex:0];
//        }
//        else {
//            [self.searchBeforeList addObject:sspo];
//        }
//    }
//    else {
//        //增加到搜索记录中
//        [self.searchBeforeList addObject:sspo];
//    }
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.searchBeforeList];
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    [userDefault setObject:data forKey:@"searchedProduct_V2.0"];
//    [userDefault synchronize];
}

#pragma mark - 取消按钮方法
- (void)backBefore:(id)sender {
    [self.textFieldForSearch resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.countList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.textFieldForSearch.text.length == 0) {
        return 25;
    }
    else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewForHeader = [[UIView alloc]init];
    UILabel *labelForTitle = [[UILabel alloc]init];
    [viewForHeader addSubview:labelForTitle];
    labelForTitle.font = [UIFont systemFontOfSize:13.0];
    labelForTitle.textAlignment = NSTextAlignmentLeft;
    [labelForTitle setTextColor:RGB(56, 56, 56, 1.0)];
    labelForTitle.text = @"历史搜索";
    self.labelForHeaderTitle = labelForTitle;
    [labelForTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewForHeader.mas_top);
        make.left.equalTo(viewForHeader.mas_left).with.offset(5);
        make.right.equalTo(viewForHeader.mas_right).with.offset(-5);
        make.bottom.equalTo(viewForHeader.mas_bottom);
    }];
    return viewForHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Cellindentifier = @"Cellindentifier";
    SearchTableViewCell *cell=[[SearchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cellindentifier];
//    SearchObject *ssPO = self.countList[indexPath.row];
//    if (self.textFieldForSearch.text.length == 0) {
//        [cell.keywordLab setText:[PublicObject convertNullString:ssPO.typeName]];
//    }
//    else {
//        [cell.keywordLab setText:self.textFieldForSearch.text];
//    }
//    if ([PublicObject convertNullNumber:ssPO.incode].integerValue == 0) {
//        [cell.zaiLab setHidden:YES];
//        [cell.searchLab setHidden:YES];
//        [cell.classLab setHidden:YES];
//    }
//    else {
//        [cell.zaiLab setHidden:NO];
//        [cell.searchLab setHidden:NO];
//        [cell.classLab setText:ssPO.typeName];
//    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.textFieldForSearch resignFirstResponder];
//    SearchObject *search = self.countList[indexPath.row];
//    [self saveSeachHistory];
//    if (self.textFieldForSearch.text.length == 0) {
//        //历史纪录
//        NSLog(@"%@",[PublicObject convertNullString:search.typeName]);
//        if ([PublicObject convertNullString:search.typeName].length==0) {
//            return;
//        }
//        self.textFieldForSearch.text = search.typeName;
//        [self searchGoodsProperty];
//    }
//    else {
//        SearchResultViewController *scdVC = [[SearchResultViewController alloc] init];
//        scdVC.searchObject = search;
//        [self.navigationController pushViewController:scdVC animated:YES];
//        return;
//    }
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
