//
//  HomeProductRecommendTableViewCell.h
//  Simall
//
//  Created by 张浩 on 16/4/26.
//  Copyright © 2016年 张浩. All rights reserved.
//  首页产品推荐cell

#import <UIKit/UIKit.h>
#import "HomeProductRecommendView.h"
@protocol HomeProductRecommendTableViewCellDelegate
- (void)clickHomeProductRecommendTableViewCellWithIndex:(NSInteger)index;
@end
@interface HomeProductRecommendTableViewCell : UITableViewCell
@property (nonatomic , strong)NSMutableArray *dataArr;
@property (nonatomic,assign)id <HomeProductRecommendTableViewCellDelegate>delegate;
- (void)showView;
@end
