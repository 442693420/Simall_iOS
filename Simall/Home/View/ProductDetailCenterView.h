//
//  ProductDetailCenterView.h
//  JCHProject
//
//  Created by 张浩 on 16/4/15.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ProductDetailCenterViewDelegate
- (void)presentProductDetailChooseView;
@end
@interface ProductDetailCenterView : UIView
@property (nonatomic , strong)UIView *labBackView;
@property (nonatomic , strong)UIView *btnBackView;
@property (nonatomic,assign)id <ProductDetailCenterViewDelegate>delegate;
- (id)initWithLabDicArr:(NSArray *)labArr;
@end
