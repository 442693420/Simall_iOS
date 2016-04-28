//
//  HomeTitleLabCenterBtnInfoLabView.h
//  JCHProject
//
//  Created by 张浩 on 16/4/13.
//  Copyright © 2016年 张浩. All rights reserved.
//HomeFourCellView

#import <UIKit/UIKit.h>

@protocol HomeTitleLabCenterBtnInfoLabViewDelegate
- (void)homeTitleLabCenterBtnInfoLabViewClickWithBtnTag:(NSInteger)btnTag;
@end

@interface HomeTitleLabCenterBtnInfoLabView : UIView
@property (nonatomic, assign)id <HomeTitleLabCenterBtnInfoLabViewDelegate>delegate;
- (id)initWithTitleStr:(NSString *)titleStr nowNumStr:(NSString *)nowNumStr allNumStr:(NSString *)allNumStr titleImgColor:(UIColor *)imgColor Tag:(NSInteger)tag;

@end
