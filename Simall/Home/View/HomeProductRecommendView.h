//
//  HomeProductRecommendView.h
//  Simall
//
//  Created by 张浩 on 16/4/26.
//  Copyright © 2016年 张浩. All rights reserved.
//  首页产品推荐cell  view

#import <UIKit/UIKit.h>

@protocol HomeProductRecommendViewDelegate
- (void)homeProductRecommendViewClickWithBtnTag:(NSInteger)btnTag;
@end

@interface HomeProductRecommendView : UIView
@property (nonatomic, assign)id <HomeProductRecommendViewDelegate>delegate;
- (id)initWithImgStr:(NSString *)imgStr priceStr:(NSString *)priceStr infoStr:(NSString *)infoStr andTag:(NSInteger)tag;
@end
