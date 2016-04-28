//
//  HomeTwoTableViewCell.h
//  JCHProject
//
//  Created by 张浩 on 16/4/12.
//  Copyright © 2016年 张浩. All rights reserved.
//  本周热销  下周热销cell

#import <UIKit/UIKit.h>
#import "HomeTitleLabMoreBtnInfoImgView.h"

@interface HomeTwoTableViewCell : UITableViewCell
@property (nonatomic , strong)HomeTitleLabMoreBtnInfoImgView *oneView;
@property (nonatomic , strong)HomeTitleLabMoreBtnInfoImgView *twoView;
- (void)showView;
@end
