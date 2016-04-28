//
//  StoreClassCollectionViewCell.h
//  MushroomCloud
//
//  Created by konghui on 15/9/14.
//  Copyright (c) 2015年 com. All rights reserved.
//  类别的cell（图片和类别名称）

#import <UIKit/UIKit.h>

@interface StoreClassCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) UIImageView *classImageView;//类别的图片
@property (nonatomic, weak) UILabel *classLabel;//类别的名称

@end
