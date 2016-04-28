//
//  AdvertScrollView.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "AdvertScrollView.h"
#define ScrollViewWidth self.frame.size.width
#define ScrollViewHeight self.frame.size.height

static CGFloat refreshTimer = 2.0;

@interface AdvertScrollView()
/**
 *	数据
 */
@property (nonatomic, assign) NSInteger imageCount;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) NSArray *imageURLArray;

@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageView;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation AdvertScrollView

/**
 *	默认大小 ：宽：屏幕宽
 高：屏幕宽/2
 *
 */
- (instancetype)init{
    return [self initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*0.6)];
}

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
- (void)clickImage{
    [self.delegate clickedImageIndex:self.pageView.currentPage];
}

- (void)configViewsWithImages:(NSArray *)images titles:(NSArray *)titleArray {
    [self.timer invalidate];
    self.timer = nil;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.imageArray = images;
    self.imageCount = images.count;
    self.titleArray = titleArray;
    [self prepareScollViewWithImages];
    [self preparePageView];
    [self addTimer];
}
- (void)configViewsWithImageURLs:(NSArray *)imageURLs titles:(NSArray *)titleArray{
    [self.timer invalidate];
    self.timer = nil;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.imageURLArray = imageURLs;
    self.imageCount = imageURLs.count;
    self.titleArray = titleArray;
    [self prepareScollViewWithImageURLs];
    [self preparePageView];
    [self addTimer];
}


- (void)prepareScollViewWithImages{
    if (self.imageArray) {
        for (int i = 0; i < self.imageCount; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = self.imageArray[i];
            CGFloat imageX = ScrollViewWidth * (i+1);
            imageView.frame = CGRectMake(imageX, 0, ScrollViewWidth, ScrollViewHeight);
            if (self.titleArray.count == self.imageCount) {
                UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, ScrollViewHeight - 40, ScrollViewWidth-40, 40)];
                titleLabel.font = [UIFont systemFontOfSize:28];
                titleLabel.textColor = [UIColor whiteColor];
                titleLabel.text = self.titleArray[i];
                [imageView addSubview:titleLabel];
            }
            [self.scrollView addSubview:imageView];
        }
        UIImageView *firstImage = [[UIImageView alloc] init];
        firstImage.image = self.imageArray.lastObject;
        firstImage.frame = CGRectMake(0, 0, ScrollViewWidth, ScrollViewHeight);
        [self.scrollView addSubview:firstImage];
        
        UIImageView *lastImage = [[UIImageView alloc] init];
        lastImage.image = self.imageArray.firstObject;
        lastImage.frame = CGRectMake((self.imageCount + 1) * ScrollViewWidth, 0, ScrollViewWidth, ScrollViewHeight);
        [self.scrollView addSubview:lastImage];
        
        self.scrollView.contentOffset = CGPointMake(ScrollViewWidth, 0);
        self.scrollView.contentSize = CGSizeMake((self.imageCount + 2) * ScrollViewWidth, 0);
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        
        [self.scrollView addSubview:self.button];
        [self addSubview:self.scrollView];
    }
}

- (void)prepareScollViewWithImageURLs{
    if (self.imageURLArray) {
        for (int i = 0; i < self.imageURLArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView sd_setImageWithURL:self.imageURLArray[i] placeholderImage:[UIImage imageNamed:@"default"]];
            CGFloat imageX = ScrollViewWidth * (i+1);
            imageView.frame = CGRectMake(imageX, 0, ScrollViewWidth, ScrollViewHeight);
            if (self.titleArray.count == self.imageURLArray.count) {
                UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, ScrollViewHeight - 40, ScrollViewWidth-40, 40)];
                titleLabel.font = [UIFont systemFontOfSize:28];
                titleLabel.textColor = [UIColor whiteColor];
                titleLabel.text = self.titleArray[i];
                [imageView addSubview:titleLabel];
            }
            [self.scrollView addSubview:imageView];
        }
        UIImageView *firstImage = [[UIImageView alloc] init];
        [firstImage sd_setImageWithURL:self.imageURLArray.lastObject placeholderImage:[UIImage imageNamed:@"default"]];
        firstImage.frame = CGRectMake(0, 0, ScrollViewWidth, ScrollViewHeight);
        [self.scrollView addSubview:firstImage];
        
        UIImageView *lastImage = [[UIImageView alloc] init];
        [lastImage sd_setImageWithURL:self.imageURLArray.firstObject placeholderImage:[UIImage imageNamed:@"default"]];
        lastImage.frame = CGRectMake((self.imageURLArray.count + 1) * ScrollViewWidth, 0, ScrollViewWidth, ScrollViewHeight);
        [self.scrollView addSubview:lastImage];
        
        self.scrollView.contentOffset = CGPointMake(ScrollViewWidth, 0);
        self.scrollView.contentSize = CGSizeMake((self.imageURLArray.count + 2) * ScrollViewWidth, 0);
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        
        [self.scrollView addSubview:self.button];
        [self addSubview:self.scrollView];
    }
}

-(void)preparePageView{
    self.pageView.frame = CGRectMake( (ScrollViewWidth - self.imageCount * 20)/2, ScrollViewHeight*0.9, self.imageCount * 20, 5);
    self.pageView.numberOfPages = self.imageCount;
    self.pageView.currentPageIndicatorTintColor = [UIColor redColor];//PageControl选中的颜色
    self.pageView.pageIndicatorTintColor = [UIColor lightGrayColor];//PageControl未选中的颜色
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
    if (index == self.imageCount + 1) {
        index = 0;
    } else {
        index++;
    }
    [self.scrollView setContentOffset:CGPointMake((index + 1) * ScrollViewWidth, 0)animated:YES];
}

#pragma mark - UIScrollViewDelegate
/**
 *	contentOffset改变时确定当前显示下标
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = (self.scrollView.contentOffset.x + ScrollViewWidth * 0.5) / ScrollViewWidth;
    if (index == self.imageCount + 2) {
        index = 1;
    } else if(index == 0) {
        index = self.imageCount;
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
    int index = (self.scrollView.contentOffset.x + ScrollViewWidth * 0.5) / ScrollViewWidth;
    if (index == self.imageCount + 1) {
        [self.scrollView setContentOffset:CGPointMake(ScrollViewWidth, 0) animated:NO];
    } else if (index == 0) {
        [self.scrollView setContentOffset:CGPointMake(self.imageCount * ScrollViewWidth, 0) animated:NO];
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
        _button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, (self.imageCount + 2) * ScrollViewWidth,ScrollViewHeight)];
        [_button addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}



@end
