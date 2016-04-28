//
//  ProductDetailTopView.h
//  JCHProject
//
//  Created by 张浩 on 16/4/15.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailTopView : UIView
@property (nonatomic , strong)UIImageView *titleImgView;
@property (nonatomic , strong)UIImageView *recommandImgView;
@property (nonatomic , strong)UILabel *titleLab;
@property (nonatomic , strong)UILabel *infoLab;
- (id)initWithTitleImg:(NSString *)imgStr isRecommand:(NSInteger)recommandStatus titleStr:(NSString *)titleStr infoStr:(NSString *)infoStr;
@end
