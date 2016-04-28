//
//  DYSegmentConfiguration.h
//  DYCommonControl
//
//  Created by 周德艺 on 16/1/2.
//  Copyright © 2016年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DYSegmentConfiguration : NSObject

/** 构造器方法*/
- (instancetype)initWithItems: (NSArray<NSString *> *)items;
/** 构造器方法*/
+ (instancetype)configurationWithItems: (NSArray<NSString *> *)items;


/** 分栏控制器的标题数组*/
@property (nonatomic, copy) NSArray<NSString *> * items;

/** 放大比例*/
@property (nonatomic, assign) CGFloat itemSelectScale;
/** 正常比例*/
@property (nonatomic, assign) CGFloat itemNormalScale;
/** 分栏控制器的圆角半径*/
@property (nonatomic, assign) CGFloat cornerRadius;
/** 分栏控制器的圆角线条宽度*/
@property (nonatomic, assign) CGFloat cornerWidth;
/** 分栏控制器的边缘线条颜色*/
@property (nonatomic, strong) UIColor * cornerColor;
/** 分栏控制器当前选中的下标*/
@property (nonatomic, assign) NSUInteger currentIndex;
/** 分栏控制器的背景颜色*/
@property (nonatomic, strong) UIColor * backgroundColor;

/** 分栏按钮的选中颜色*/
@property (nonatomic, strong) UIColor * itemSelectedColor;
/** 分栏按钮的背景颜色*/
@property (nonatomic, strong) UIColor * itemBackgroundColor;
/** 分栏按钮的字体颜色*/
@property (nonatomic, strong) UIColor * itemTextColor;
/** 分栏按钮的选中字体颜色*/
@property (nonatomic, strong) UIColor * itemSelectedTextColor;

/** 滑块颜色*/
@property (nonatomic, strong) UIColor * slideBlockColor;

@end

