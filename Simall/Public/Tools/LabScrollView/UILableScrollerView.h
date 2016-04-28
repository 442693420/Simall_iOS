//
//  UILableScrollerView.h
//  LableScrollView
//
//  Created by 张浩 on 16/4/13.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
*	Delegate 用于点击代理
*/
@protocol UILableScrollerViewDelegate <NSObject>

- (void)clickedLabIndex:(NSInteger)index;

@end
@interface UILableScrollerView : UIView<UIScrollViewDelegate>
@property (weak, nonatomic)id<UILableScrollerViewDelegate> delegate;

/**
 *	配置文字展示
 *
 *	@param labArr			文字数组
 */
- (void)configViewsWithLabArr:(NSArray *)labArr;


@end
