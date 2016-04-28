//
//  HomeBottomPopView.h
//  JCHProject
//
//  Created by 张浩 on 16/4/14.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeBottomPopViewDelegate
- (void)hidenHomeBottomPopView;
- (void)clickHomeBottomPopViewWithIndex:(NSInteger)index;
@end
@interface HomeBottomPopView : UIView

@property (nonatomic,assign)id <HomeBottomPopViewDelegate>delegate;
@property (nonatomic , assign)NSInteger status; //0关闭状态  1打开状态
- (id)initWithBtnArr:(NSArray *)dataArr;
@end
