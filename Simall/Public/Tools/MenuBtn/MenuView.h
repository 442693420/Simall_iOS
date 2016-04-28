//
//  MenuView.h
//  Simall
//
//  Created by 张浩 on 16/4/27.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MenuViewDelegate
- (void)menuViewClickWithIndex:(NSInteger)index tag:(NSInteger) tag;
@end
@interface MenuView : UIView
@property (nonatomic, assign)id <MenuViewDelegate>delegate;
- (id)initWithDataSource:(NSArray *)dataArr;
@end
