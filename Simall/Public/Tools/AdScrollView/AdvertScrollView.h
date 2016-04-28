//
//  AdvertScrollView.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *	Delegate 用于点击代理
 */
@protocol ZHAdvertScrollViewDelegate <NSObject>

- (void)clickedImageIndex:(NSInteger)index;

@end
@interface AdvertScrollView : UIView<UIScrollViewDelegate>
@property (weak, nonatomic)id<ZHAdvertScrollViewDelegate> delegate;

/**
 *	配置图片文字展示
 *
 *	@param images			图片数组
 *	@param titleArray	文字数组
 */
- (void)configViewsWithImages:(NSArray *)images titles:(NSArray *)titleArray;
- (void)configViewsWithImageURLs:(NSArray *)imageURLs titles:(NSArray *)titleArray;
@end
