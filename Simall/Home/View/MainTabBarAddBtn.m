//
//  MainTabBarAddBtn.m
//  JCHProject
//
//  Created by 张浩 on 16/4/12.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "MainTabBarAddBtn.h"
@interface MainTabBarAddBtn () {
    CGFloat _buttonImageHeight;
}

@end
@implementation MainTabBarAddBtn

+ (void)load {
    [super registerSubclass];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

//上下结构的 button
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 控件大小,间距大小
    CGFloat const imageViewEdgeWidth   = self.bounds.size.width * 0.7;
    CGFloat const imageViewEdgeHeight  = imageViewEdgeWidth * 0.9;
    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMarginT = self.bounds.size.height - labelLineHeight - imageViewEdgeWidth;
    CGFloat const verticalMargin  = verticalMarginT / 2;
    
    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdgeWidth * 0.5;
    CGFloat const centerOfTitleLabel = imageViewEdgeWidth  + verticalMargin * 2 + labelLineHeight * 0.5 + 5;
    
    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeHeight);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
    
    //title position 位置
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
}

#pragma mark -
#pragma mark - CYLPlusButtonSubclassing Methods

/*
 *
 Create a custom UIButton with title and add it to the center of our tab bar
 *
 */
//+ (instancetype)plusButton {
//    MainTabBarAddBtn *button = [[MainTabBarAddBtn alloc] init];
//    UIImage *buttonImage = [UIImage imageNamed:@"post_normal"];
//    [button setImage:buttonImage forState:UIControlStateNormal];
//    [button setBackgroundColor:[UIColor redColor]];
//    [button setTitle:@"其他" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:9.5];
//    [button sizeToFit]; // or set frame in this way `button.frame = CGRectMake(0.0, 0.0, 250, 100);`
//    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
//    return button;
//}
/*
 *
 Create a custom UIButton without title and add it to the center of our tab bar
 *
 */
+ (instancetype)plusButton
{

    UIImage *buttonImage = [UIImage imageNamed:@"home_add.png"];
    UIImage *highlightImage = [UIImage imageNamed:@"home_add.png"];

    MainTabBarAddBtn* button = [MainTabBarAddBtn buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];

    return button;
}

#pragma mark -
#pragma mark - Event Response

- (void)clickPublish {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showHomeBottomPopView"object:nil];
}



#pragma mark - CYLPlusButtonSubclassing
//+ (NSUInteger)indexOfPlusButtonInTabBar {
//    return 3;
//}

+ (CGFloat)multiplerInCenterY {
    return  0.3;
}

@end
