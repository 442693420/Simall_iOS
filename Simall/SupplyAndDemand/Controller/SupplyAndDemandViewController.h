//
//  SupplyAndDemandViewController.h
//  JCHProject
//
//  Created by 张浩 on 16/4/12.
//  Copyright © 2016年 张浩. All rights reserved.
//  

#import <UIKit/UIKit.h>
#import "DYSegment.h"

@interface SupplyAndDemandViewController : UIViewController
@property (nonatomic, strong) DYSegment *segmentControl;
@property (nonatomic, strong) UITableView *tableView;

@end
