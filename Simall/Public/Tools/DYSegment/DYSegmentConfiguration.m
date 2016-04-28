//
//  DYSegmentConfiguration.m
//  DYCommonControl
//
//  Created by 周德艺 on 16/1/2.
//  Copyright © 2016年 周德艺. All rights reserved.
//

#import "DYSegmentConfiguration.h"

@implementation DYSegmentConfiguration

#pragma mark - initializer - 构造器
/** 构造器方法*/
- (instancetype)init
{
    return [self initWithItems: nil];
}

/** 构造器方法*/
- (instancetype)initWithItems: (NSArray<NSString *> *)items
{
    NSAssert((items != nil && items.count > 0), @"Can not init configuration for segment control with nil array");
    if (self = [super init]) {
        self.items = items;
        [self setupConfiguration];
    }
    return self;
}


/** 构造器方法*/
+ (instancetype)configurationWithItems: (NSArray<NSString *> *)items
{
    return [[self alloc] initWithItems: items];
}


#pragma mark - setup - 配置
/**
 *  配置属性
 */
- (void)setupConfiguration
{
    self.itemNormalScale = 1;
    self.itemSelectScale = 1;
    self.backgroundColor = [UIColor whiteColor];
    self.itemSelectedColor = [UIColor clearColor];
    self.itemBackgroundColor = [UIColor clearColor];
    self.itemTextColor = MainColor;
    self.itemSelectedTextColor = MainColor;
    self.slideBlockColor = MainColor;
    //    self.cornerRadius = 5.f;
    //    self.cornerWidth = 1.f;
    //    self.cornerColor = [UIColor blackColor];
    
}

@end
