//
//  DYSegment.h
//  DYCommonControl
//
//  Created by 周德艺 on 16/1/2.
//  Copyright © 2016年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYSegmentConfiguration.h"


#pragma mark - protocol - 协议
@class DYSegment;

@protocol DYSegmentDelegate <NSObject>

/**
 *  @method segmentControl: didSelectAtIndex:
 *  @abstract   点击分栏按钮回调协议方法
 */
- (void)segmentControl: (DYSegment *)segmentControl didSelectAtIndex: (NSUInteger)index;

@end


#pragma mark - class - 类

@interface DYSegment : UIView

@property (nonatomic, strong) NSMutableArray *buttonArray;

/**
 *  @property   configuration
 *  @abstract   分栏控制器的配置属性
 */
@property (nonatomic, strong) DYSegmentConfiguration * configuration;

/**
 *  @property   delegate
 *  @abstract   协议回调代理人
 */
@property (nonatomic, weak) id<DYSegmentDelegate> delegate;

/**
 *  @property   scrollView
 *  @abstract   滚动视图。如果此项不为空，分栏控制器可以控制滚动视图的滚动
 */
@property (nonatomic, weak) UIScrollView * scrollView;

/**
 *  @property   pageControl
 *  @abstract   页面显示视图。如果此项不为空，分栏控制器可以控制页面显示控件的移动
 */
@property (nonatomic, weak) UIPageControl * pageControl;

/**
 *  @method initWithConfiguration:
 *  @abstract   使用属性配置对象构造分栏控制器
 */
- (instancetype)initWithFrame: (CGRect)frame configuration: (DYSegmentConfiguration *)configuration delegate: (id<DYSegmentDelegate>)delegate;

/**
 *  @method segmentControlWithConfiguration:
 *  @abstract   使用属性配置对象构造分栏控制器
 */
+ (instancetype)segmentControlWithFrame: (CGRect)frame configuration: (DYSegmentConfiguration *)configuration delegate: (id<DYSegmentDelegate>)delegate;

- (void)clickSegmentItem: (UIButton *)segmentItem;


@end
