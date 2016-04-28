//
//  HomeUpdateView.h
//  Simall
//
//  Created by 张浩 on 16/4/26.
//  Copyright © 2016年 张浩. All rights reserved.
//  首页最近更新cell 中的view

#import <UIKit/UIKit.h>

@protocol HomeUpdateViewDelegate
- (void)homeUpdateViewClickWithBtnTag:(NSInteger)btnTag;
@end

@interface HomeUpdateView : UIView
@property (nonatomic, assign)id <HomeUpdateViewDelegate>delegate;
- (id)initWithTitleStr:(NSString *)titleStr nowNumStr:(NSString *)nowNumStr allNumStr:(NSString *)allNumStr titleImgColor:(UIColor *)imgColor Tag:(NSInteger)tag;

@end
