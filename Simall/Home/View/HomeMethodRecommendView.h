//
//  HomeMethodRecommendView.h
//  Simall
//
//  Created by 张浩 on 16/4/27.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeMethodRecommendViewDelegate
//- (void)homeProductRecommendViewClickWithBtnTag:(NSInteger)btnTag;
@end
@interface HomeMethodRecommendView : UIView
@property (nonatomic, assign)id <HomeMethodRecommendViewDelegate>delegate;
- (id)initWithTitleImg:(NSString *)img titleStr:(NSString *)title tag:(NSInteger)tag;
@end
