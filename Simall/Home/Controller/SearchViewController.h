//
//  SearchViewController.h
//  JCHProject
//
//  Created by 张浩 on 16/4/14.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, copy)NSString *searchText;
@property (nonatomic, strong)UITextField *textFieldForSearch;
@property (nonatomic, weak)UITableView *tableViewForProduct;
@property (nonatomic, weak)UIScrollView *scrollViewForMain;
@property (nonatomic, weak)UILabel *labelForHeaderTitle;
@property(nonatomic,weak)UIView *container;
@property (nonatomic, weak)UIButton *buttonForClear;
@property (nonatomic, strong)NSMutableArray *productList;
@property (nonatomic, strong)NSMutableArray *searchBeforeList;
@property (nonatomic, strong)NSMutableArray *countList;
@end
