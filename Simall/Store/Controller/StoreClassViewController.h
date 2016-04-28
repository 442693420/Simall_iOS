//
//  StoreClassViewController.h
//  Simall
//
//  Created by 张浩 on 16/4/27.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreClassViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) UITableView *typeTableView;
@property (nonatomic, weak) UICollectionView *classCollectionView;
@property (nonatomic, strong) NSMutableArray *typeArray;//左侧分类列表
@property (nonatomic, strong) NSMutableArray *classArray;//右侧详细分类
@property (nonatomic ,strong) NSIndexPath *selectIndex;//选中大的分类
@end
