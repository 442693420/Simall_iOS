//
//  HomeOneTableViewCell.h
//  JCHProject
//
//  Created by 张浩 on 16/4/12.
//  Copyright © 2016年 张浩. All rights reserved.
//  最新询价、最新需求cell

#import <UIKit/UIKit.h>
#import "HomeTitleLabMoreBtnInfoLabView.h"

@interface HomeOneTableViewCell : UITableViewCell
@property (nonatomic , strong)HomeTitleLabMoreBtnInfoLabView *oneView;
@property (nonatomic , strong)HomeTitleLabMoreBtnInfoLabView *twoView;
- (void)showView;
@end
