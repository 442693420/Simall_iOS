//
//  HomeRecommendView.h
//  JCHProject
//
//  Created by 张浩 on 16/4/13.
//  Copyright © 2016年 张浩. All rights reserved.
//  首页 推荐 view

#import <UIKit/UIKit.h>

@protocol HomeRecommendViewDelegate
- (void)homeRecommendViewClickWithBtnTag:(NSInteger)btnTag;
@end

@interface HomeRecommendView : UIView
@property (nonatomic, assign)id <HomeRecommendViewDelegate>delegate;
- (id)initWithImgStr:(NSString *)imgStr priceStr:(NSString *)priceStr infoStr:(NSString *)infoStr andTag:(NSInteger)tag;
@end
