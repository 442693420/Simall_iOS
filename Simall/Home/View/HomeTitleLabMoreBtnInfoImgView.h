//
//  HomeTitleLabMoreBtnInfoImgView.h
//  JCHProject
//
//  Created by 张浩 on 16/4/12.
//  Copyright © 2016年 张浩. All rights reserved.
//HomeTwoCellView

#import <UIKit/UIKit.h>
@protocol HomeTitleLabMoreBtnInfoImgViewDelegate
- (void)homeTitleLabMoreBtnInfoImgViewClickWithBtnTag:(NSInteger)btnTag;
@end

@interface HomeTitleLabMoreBtnInfoImgView : UIView
@property (nonatomic, assign)id <HomeTitleLabMoreBtnInfoImgViewDelegate>delegate;
- (id)initWithTitleStr:(NSString *)titleStr infoImg:(NSString *)imgStr btnTag:(NSInteger)btnTag;

@end
