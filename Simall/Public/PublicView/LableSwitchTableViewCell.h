//
//  LableSwitchTableViewCell.h
//  JCHProject
//
//  Created by 张浩 on 16/4/22.
//  Copyright © 2016年 张浩. All rights reserved.
//  带有一个titleLab和一个开关switch的自定义cell

#import <UIKit/UIKit.h>

@interface LableSwitchTableViewCell : UITableViewCell
@property (nonatomic , strong)UILabel *titleLab;
@property (nonatomic ,strong)UISwitch *switchBtn;
@end
