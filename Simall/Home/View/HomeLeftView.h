//
//  HomeLeftView.h
//  JCHProject
//
//  Created by 张浩 on 16/4/12.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeLeftViewDelegate
- (void)hidenHomeLeftView;
- (void)clickHomeLeftViewWithIndex:(NSInteger)index;
- (void)clickHomeLeftViewSetUpView;
- (void)clickHomeLeftViewModelView;
@end
@interface HomeLeftView : UIView

@property (nonatomic,assign)id <HomeLeftViewDelegate>delegate;
@property (nonatomic , assign)NSInteger status; //0关闭状态  1打开状态
- (id)initWithTableViewArr:(NSArray *)dataArr;

@end
