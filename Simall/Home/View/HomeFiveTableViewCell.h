//
//  HomeFiveTableViewCell.h
//  JCHProject
//
//  Created by 张浩 on 16/4/13.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeFiveTableViewCellDelegate
- (void)clickHomeFiveTableViewCellWithIndex:(NSInteger)index;
@end
@interface HomeFiveTableViewCell : UITableViewCell
@property (nonatomic , strong)NSArray *dataArr;
@property (nonatomic,assign)id <HomeFiveTableViewCellDelegate>delegate;
- (void)showView;
@end
