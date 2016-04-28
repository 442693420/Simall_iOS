//
//  HomeThreeTableViewCell.h
//  JCHProject
//
//  Created by 张浩 on 16/4/13.
//  Copyright © 2016年 张浩. All rights reserved.
//首页快报cell

#import <UIKit/UIKit.h>
#import "UILableScrollerView.h"

@interface HomeThreeTableViewCell : UITableViewCell
@property(nonatomic , strong)UILableScrollerView *labScrollView;
@property (nonatomic , strong)UILabel *titleLab;
- (void)showViewWithTitle:(NSString *)title labArr:(NSArray *)labAarr;
@end
