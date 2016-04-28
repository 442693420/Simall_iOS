//
//  HomeBottomPopView.m
//  JCHProject
//
//  Created by 张浩 on 16/4/14.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "HomeBottomPopView.h"
#import "HomeTabBtnView.h"
@interface HomeBottomPopView()
@property (nonatomic , strong)UIView *btnBackView;
@end
@implementation HomeBottomPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithBtnArr:(NSArray *)dataArr{
    self = [super init];
    if (self) {
        self.backgroundColor = RGB(97, 99, 104, 0.5);
        [self addSubview:self.btnBackView];
        [self.btnBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
        }];
        
        UIView *lastView;
        for (int i = 0; i < dataArr.count; i++) {
            int lie = i%3;
            NSDictionary *dic = [dataArr objectAtIndex:i];
            UIImage *img = [UIImage imageNamed:[dic objectForKey:@"image"]];
            NSString *title = [dic objectForKey:@"title"];
            HomeTabBtnView *btnView = [[HomeTabBtnView alloc]initWithTag:i+10 Image:img title:title actionBlock:^(NSInteger tag) {
                [self.delegate clickHomeBottomPopViewWithIndex:tag];
            }];
            //        btnView.backgroundColor = [UIColor yellowColor];
            [self.btnBackView addSubview:btnView];
            [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastView) {
                    if (lie == 0) {
                        make.top.mas_equalTo(lastView.mas_bottom).offset(1);
                        make.left.mas_equalTo(0);
                    }else{
                        make.top.mas_equalTo(lastView.mas_top);
                        make.left.mas_equalTo(lastView.mas_right).offset(1);
                    }
                }else{
                    make.top.left.mas_equalTo(0);
                }
                make.width.mas_equalTo(SCREEN_WIDTH/3);
                make.height.mas_equalTo(SCREEN_WIDTH/3 - 30);
                
            }];
            lastView = btnView;
        }
        [self.btnBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            NSInteger row = (dataArr.count + 3 - 1) / 3;//除法向上取整
            make.height.mas_equalTo((SCREEN_WIDTH/3 - 30) * row);
        }];
        
        //给模糊背景加点击事件
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidenBottomView)];
        [self addGestureRecognizer:click];
    }
    return self;
}
- (void)hidenBottomView{
    [self.delegate hidenHomeBottomPopView];
}
#pragma mark getter and setter
-(UIView *)btnBackView{
    if (_btnBackView == nil) {
        _btnBackView = [[UIView alloc]init];
        _btnBackView.backgroundColor = [UIColor whiteColor];
    }
    return _btnBackView;
}
@end
