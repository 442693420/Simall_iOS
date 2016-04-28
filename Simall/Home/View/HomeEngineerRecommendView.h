//
//  HomeEngineerRecommendView.h
//  Simall
//
//  Created by 张浩 on 16/4/26.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeEngineerRecommendViewDelegate
//- (void)homeProductRecommendViewClickWithBtnTag:(NSInteger)btnTag;
@end
@interface HomeEngineerRecommendView : UIView
@property (nonatomic, assign)id <HomeEngineerRecommendViewDelegate>delegate;
- (id)initWithTitleImg:(NSString *)img nameStr:(NSString *)name recommendNum:(NSInteger)recommendNum tag:(NSInteger)tag;
@end
