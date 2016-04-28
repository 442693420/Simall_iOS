//
//  UILableScrollerView.m
//  LableScrollView
//
//  Created by 张浩 on 16/4/13.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "UILableScrollerView.h"
#define ScrollViewWidth self.frame.size.width
#define ScrollViewHeight self.frame.size.height
static CGFloat refreshTimer = 2.0;
@interface UILableScrollerView()
/**
 *	数据
 */
@property (nonatomic, assign) NSInteger labCount;
@property (strong, nonatomic) NSArray *labArr;

@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageView;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation UILableScrollerView

/**
 *	默认大小 ：宽：屏幕宽
 高：屏幕宽/2
 *
 */
//- (instancetype)init{
//    return [self initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*0.6)];
//}

/**
 *	自定义大小
 */
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
    }
    return self;
}
/**
 *	点击代理触发
 */
- (void)clickLab{
    [self.delegate clickedLabIndex:self.pageView.currentPage];
}
-(void)configViewsWithLabArr:(NSArray *)labArr{
    [self.timer invalidate];
    self.timer = nil;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.labArr = labArr;
    self.labCount = labArr.count;
    [self prepareScollViewWithLabArr];
    [self preparePageView];
    [self addTimer];
}


- (void)prepareScollViewWithLabArr{
    if (self.labCount) {
        for (int i = 0; i < self.labCount; i++) {
            CGFloat labY = ScrollViewHeight * (i+1);
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, labY, ScrollViewWidth, ScrollViewHeight)];
            titleLabel.font = [UIFont systemFontOfSize:14];
            titleLabel.textColor = [UIColor darkGrayColor];
            titleLabel.text = self.labArr[i];
            [self.scrollView addSubview:titleLabel];
        }
        UILabel *firstLab = [[UILabel alloc] init];
        firstLab.text = self.labArr.lastObject;
        firstLab.font = [UIFont systemFontOfSize:14];
        firstLab.frame = CGRectMake(0, 0, ScrollViewWidth, ScrollViewHeight);
        [self.scrollView addSubview:firstLab];
        
        UILabel *lastLab = [[UILabel alloc] init];
        lastLab.text = self.labArr.firstObject;
        lastLab.font = [UIFont systemFontOfSize:14];
        lastLab.frame = CGRectMake(0, (self.labCount + 1) * ScrollViewHeight, ScrollViewWidth, ScrollViewHeight);
        [self.scrollView addSubview:lastLab];
        
        self.scrollView.contentOffset = CGPointMake(0, ScrollViewHeight);
        self.scrollView.contentSize = CGSizeMake(0, (self.labCount + 2) * ScrollViewHeight);
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        
        [self.scrollView addSubview:self.button];
        [self addSubview:self.scrollView];
    }
}


-(void)preparePageView{
    self.pageView.numberOfPages = self.labCount;
    self.pageView.currentPage = 0;
    [self addSubview:self.pageView];
}

- (void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:refreshTimer target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)nextImage {
    NSInteger index = self.pageView.currentPage;
    if (index == self.labCount + 1) {
        index = 0;
    } else {
        index++;
    }
    [self.scrollView setContentOffset:CGPointMake(0,(index + 1) * ScrollViewHeight)animated:YES];
}

#pragma mark - UIScrollViewDelegate
/**
 *	contentOffset改变时确定当前显示下标
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = (self.scrollView.contentOffset.y + ScrollViewHeight * 0.5) / ScrollViewHeight;
    if (index == self.labCount + 2) {
        index = 1;
    } else if(index == 0) {
        index = self.labCount;
    }
    self.pageView.currentPage = index - 1;
}

/**
 *	开始手动滑动时，销毁定时器
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    self.timer = nil;
}

/**
 *	手动结束后开启计时器
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

/**
 *  减速结束确定显示内容
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = (self.scrollView.contentOffset.y + ScrollViewHeight * 0.5) / ScrollViewHeight;
    if (index == self.labCount + 1) {
        [self.scrollView setContentOffset:CGPointMake(0, ScrollViewHeight) animated:NO];
    } else if (index == 0) {
        [self.scrollView setContentOffset:CGPointMake(0, self.labCount * ScrollViewHeight) animated:NO];
    }
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView{
    if(_scrollView == nil){
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScrollViewWidth, ScrollViewHeight)];
        _scrollView.delegate = self;
    }
    return  _scrollView;
}

- (UIPageControl *)pageView{
    if(_pageView == nil){
        _pageView = [[UIPageControl alloc] initWithFrame:CGRectZero];
    }
    return  _pageView;
}

- (UIButton *)button{
    if (_button == nil) {
        _button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScrollViewWidth,(self.labCount + 2) * ScrollViewHeight)];
        [_button addTarget:self action:@selector(clickLab) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}


@end
