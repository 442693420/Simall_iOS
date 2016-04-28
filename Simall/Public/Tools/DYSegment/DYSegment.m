//
//  DYSegment.m
//  DYCommonControl
//
//  Created by 周德艺 on 16/1/2.
//  Copyright © 2016年 周德艺. All rights reserved.
//

#import "DYSegment.h"

#define BUTTONINITTAG 10000

NSString * const DYSegmentControlSelectIndexNotification = @"DYSegmentControlSelectIndexNotification";
NSString * const DYSegmentControlIndexKey = @"DYSegmentControlIndexKey";


@interface DYSegment ()

@property (nonatomic, strong) NSLock * lock;
@property (nonatomic, strong) UIView * slideBlock;
@property (nonatomic, weak) UIButton * currentItem;

@end

@implementation DYSegment

#pragma mark - initializer - 构造器
/**
 *  @method initWithConfiguration:
 *  @abstract   使用属性配置对象构造分栏控制器
 */
- (instancetype)initWithFrame: (CGRect)frame configuration: (DYSegmentConfiguration *)configuration delegate: (id<DYSegmentDelegate>)delegate
{
    frame.size.height = 44.f;
    if (self = [super initWithFrame: frame]) {
        self.configuration = configuration;
        self.delegate = delegate;
        
        [self setupSelf];
        [self setupItems];
    }
    return self;
}

/**
 *  @method segmentControlWithConfiguration:
 *  @abstract   使用属性配置对象构造分栏控制器
 */
+ (instancetype)segmentControlWithFrame: (CGRect)frame configuration: (DYSegmentConfiguration *)configuration delegate: (id<DYSegmentDelegate>)delegate
{
    return [[self alloc] initWithFrame: frame configuration: configuration delegate: delegate];
}


#pragma mark - setup - 配置
/**
 *  配置分栏控制器属性
 */
- (void)setupSelf
{
    self.backgroundColor = _configuration.backgroundColor;
    self.layer.cornerRadius = _configuration.cornerRadius;
    self.layer.borderColor = _configuration.cornerColor.CGColor;
    self.layer.borderWidth = _configuration.cornerWidth;
    self.clipsToBounds = YES;
}

/**
 *  配置分栏按钮属性
 */
- (void)setupItems
{
    self.buttonArray = [[NSMutableArray alloc]init];
    [_configuration.items enumerateObjectsUsingBlock: ^(NSString * _Nonnull itemTitle, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton * item = [self segmentItemWithIndex: idx];
        [item setTitle: itemTitle forState: UIControlStateNormal];
        [self addSubview: item];
        [self.buttonArray addObject:item];
        if (idx == 0) { [self clickSegmentItem: item]; }
    }];
    
    [self addSubview: self.slideBlock];
//    UIView *line = ({
//        UIView *view = [UIView new];
//        [view  setBackgroundColor:[UIColor lightGrayColor]];
//        [self addSubview:view];
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(0.5);
//            make.left.bottom.right.mas_equalTo(self);
//        }];
//        view;
//    });
}


#pragma mark - subview init - 子控件初始化
/**
 *  创建分隔栏按钮
 */
- (UIButton *)segmentItemWithIndex: (NSUInteger)index
{
    CGFloat itemWidth = CGRectGetWidth(self.bounds) / _configuration.items.count;
    CGFloat itemHeight = CGRectGetHeight(self.bounds);
    UIButton * segmentItem = [[UIButton alloc] initWithFrame: CGRectMake(index * itemWidth, 0, itemWidth, itemHeight)];
    
    segmentItem.tag = BUTTONINITTAG + index;
    segmentItem.backgroundColor = _configuration.itemBackgroundColor;
    [segmentItem.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [segmentItem setTitleColor: _configuration.itemTextColor forState: UIControlStateNormal];
    [segmentItem setTitleColor: _configuration.itemSelectedTextColor forState: UIControlStateSelected];
    [segmentItem addTarget: self action: @selector(clickSegmentItem:) forControlEvents: UIControlEventTouchUpInside];
    segmentItem.transform = CGAffineTransformMakeScale(_configuration.itemNormalScale, _configuration.itemNormalScale);
    
    return segmentItem;
}

/**
 *  创建滑动块
 */
- (UIView *)slideBlock
{
    if (!_slideBlock) {
        CGFloat itemWidth = CGRectGetWidth(self.bounds) / _configuration.items.count;
        CGFloat height = CGRectGetHeight(self.bounds);
        _slideBlock = [[UIView alloc] initWithFrame: CGRectMake(0, height - 2.f, itemWidth, 2.f)];
        _slideBlock.backgroundColor = _configuration.slideBlockColor;
    }
    return _slideBlock;
}

/**
 *  线程锁
 */
- (NSLock *)lock
{
    if (!_lock) { _lock = [NSLock new]; }
    return _lock;
}


#pragma mark - setter
/**
 *  设置新选中按钮时取消旧选中效果
 */
- (void)setCurrentItem: (UIButton *)currentItem
{
    [_currentItem setSelected: NO];
    _currentItem.backgroundColor = _configuration.itemBackgroundColor;
    
    [UIView animateWithDuration: 0.2f animations: ^{
        _currentItem.transform = CGAffineTransformMakeScale(_configuration.itemNormalScale, _configuration.itemNormalScale);
        currentItem.transform = CGAffineTransformMakeScale(_configuration.itemSelectScale, _configuration.itemSelectScale);
    }];
    [currentItem setSelected: YES];
    currentItem.backgroundColor = _configuration.itemSelectedColor;
    _currentItem = currentItem;
}


#pragma mark - event
/**
 *  点击分栏按钮回调
 */
- (void)clickSegmentItem: (UIButton *)segmentItem
{
    if (segmentItem == _currentItem)
    { return; }
    [self.lock lock];
    NSLog(@"%ld",(long)segmentItem.tag);
    self.currentItem = segmentItem;
    NSUInteger index = segmentItem.tag - BUTTONINITTAG;
    [self changeAssociateViewWithIndex: index];
    [self callbackWithIndex: index];
    
    [self.lock unlock];
}

/**
 *  改变关联的视图
 */
- (void)changeAssociateViewWithIndex: (NSUInteger)index
{
    if (_scrollView) {
        if (_scrollView.contentSize.width / CGRectGetWidth(_scrollView.frame) >= index) {
            [_scrollView setContentOffset: CGPointMake(index * CGRectGetWidth(_scrollView.frame), 0) animated: YES];
        }
    }
    if (_pageControl) {
        if (_pageControl.numberOfPages > index) {
            _pageControl.currentPage = index;
        }
    }
    if (_slideBlock) {
        CGRect frame = _slideBlock.frame;
        CGFloat itemWidth = CGRectGetWidth(self.bounds) / _configuration.items.count;
        frame.origin.x = index * itemWidth;
        [UIView animateWithDuration: 0.15f animations: ^{
            _slideBlock.frame = frame;
        }];
    }
}

/**
 *  通过代理回调
 */
- (void)callbackWithIndex: (NSUInteger)index
{
    _configuration.currentIndex = index;
    if ([_delegate respondsToSelector: @selector(segmentControl:didSelectAtIndex:)]) {
        [_delegate segmentControl: self didSelectAtIndex: index];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName: DYSegmentControlSelectIndexNotification object: self userInfo: @{DYSegmentControlIndexKey: @(index)}];
    }
}


@end
