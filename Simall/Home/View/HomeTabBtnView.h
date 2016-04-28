//
//  HomeTabBtnView.h
//  PSBProject
//
//  Created by 张浩 on 16/2/24.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^HomeTabBtnBlock)(NSInteger tag);

@interface HomeTabBtnView : UIView
@property (nonatomic, strong)HomeTabBtnBlock actionBlock;
@property (nonatomic , strong)UIButton *btn;
@property (nonatomic , strong)UILabel *lab;

- (id)initWithTag:(int)tag Image:(UIImage *)img title:(NSString *)title actionBlock:(HomeTabBtnBlock)actionBlock;

@end
