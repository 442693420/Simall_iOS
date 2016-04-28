//
//  HomeEngineerRecommendTableViewCell.h
//  Simall
//
//  Created by 张浩 on 16/4/26.
//  Copyright © 2016年 张浩. All rights reserved.
//   首页推荐工程师cell

#import <UIKit/UIKit.h>
#import "HomeEngineerRecommendView.h"
@protocol HomeEngineerRecommendTableViewCellDelegate
- (void)clickHomeEngineerRecommendTableViewCellWithIndex:(NSInteger)index;
@end
@interface HomeEngineerRecommendTableViewCell : UITableViewCell
@property (nonatomic , strong)NSArray *dataArr;
@property (nonatomic,assign)id <HomeEngineerRecommendTableViewCellDelegate>delegate;
- (void)showView;
@end
