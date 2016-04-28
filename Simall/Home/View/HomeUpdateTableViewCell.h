//
//  HomeUpdateTableViewCell.h
//  Simall
//
//  Created by 张浩 on 16/4/26.
//  Copyright © 2016年 张浩. All rights reserved.
//  首页最新更新cell

#import <UIKit/UIKit.h>
#import "HomeUpdateView.h"

@interface HomeUpdateTableViewCell : UITableViewCell
@property (nonatomic , strong)HomeUpdateView *oneView;
@property (nonatomic , strong)HomeUpdateView *twoView;
@property (nonatomic , strong)HomeUpdateView *threeView;
- (void)showView;
@end
