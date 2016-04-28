//
//  HomeMethodRecommendTableViewCell.h
//  Simall
//
//  Created by 张浩 on 16/4/27.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeMethodRecommendView.h"
@protocol HomeMethodRecommendTableViewCellDelegate
- (void)clickHomeMethodRecommendTableViewCellWithIndex:(NSInteger)index;
@end
@interface HomeMethodRecommendTableViewCell : UITableViewCell
@property (nonatomic , strong)NSArray *dataArr;
@property (nonatomic,assign)id <HomeMethodRecommendTableViewCellDelegate>delegate;
- (void)showView;
@end
