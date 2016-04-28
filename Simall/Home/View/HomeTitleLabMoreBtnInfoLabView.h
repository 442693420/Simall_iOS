//
//  HomeTitleLabMoreBtnInfoLabView.h
//  JCHProject
//
//  Created by 张浩 on 16/4/12.
//  Copyright © 2016年 张浩. All rights reserved.
//  HomeOneCellView

#import <UIKit/UIKit.h>
@protocol HomeTitleLabMoreBtnInfoLabViewDelegate
- (void)homeTitleLabMoreBtnInfoLabViewClickWithBtnTag:(NSInteger)btnTag;
@end
@interface HomeTitleLabMoreBtnInfoLabView : UIView
@property (nonatomic, assign)id <HomeTitleLabMoreBtnInfoLabViewDelegate>delegate;
- (id)initWithTitleStr:(NSString *)titleStr infoStr:(NSString *)infoStr btnTag:(NSInteger)btnTag;
@end
