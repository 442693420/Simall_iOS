//
//  HomeFourTableViewCell.h
//  JCHProject
//
//  Created by 张浩 on 16/4/13.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTitleLabCenterBtnInfoLabView.h"

@interface HomeFourTableViewCell : UITableViewCell
@property (nonatomic , strong)HomeTitleLabCenterBtnInfoLabView *oneView;
@property (nonatomic , strong)HomeTitleLabCenterBtnInfoLabView *twoView;
@property (nonatomic , strong)HomeTitleLabCenterBtnInfoLabView *threeView;
- (void)showView;

@end
