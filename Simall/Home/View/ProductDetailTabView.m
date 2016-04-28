//
//  ProductDetailTabView.m
//  JCHProject
//
//  Created by 张浩 on 16/4/15.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "ProductDetailTabView.h"
@interface ProductDetailTabView()
@property (nonatomic , strong)UIView *showView;
@property (nonatomic , strong)UIView *addView;
@end
@implementation ProductDetailTabView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithShoppingCarCount:(NSString *)carCount{
    self = [super init];
    if (self) {
        [self addSubview:self.showView];
        [self addSubview:self.addView];
        
        [self.showView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
        }];
        [self.addView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self);
            make.width.equalTo(self.showView.mas_width);
            make.left.equalTo(self.showView.mas_right);
        }];
        
        UIImageView *showCarImgView = [[UIImageView alloc]init];
        [showCarImgView setImage:[UIImage imageNamed:@"car.png"]];
        [self.showView addSubview:showCarImgView];
        UILabel *showCarCountLab = [[UILabel alloc]init];
        showCarCountLab.text = carCount;
        showCarCountLab.textColor = [UIColor whiteColor];
        showCarCountLab.backgroundColor = [UIColor orangeColor];
        showCarCountLab.font = [UIFont systemFontOfSize:10];
        showCarCountLab.layer.masksToBounds = YES;
        showCarCountLab.layer.cornerRadius = 7.5;
        showCarCountLab.textAlignment = NSTextAlignmentCenter;
        [self.showView addSubview:showCarCountLab];
        UILabel *showCarTitleLab = [[UILabel alloc]init];
        showCarTitleLab.text = @"购物车";
        showCarTitleLab.textColor = [UIColor whiteColor];
        showCarTitleLab.font = [UIFont systemFontOfSize:14];
        [self.showView addSubview:showCarTitleLab];
        [showCarImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@30);
            make.centerX.equalTo(self.showView.mas_centerX);
            make.centerY.equalTo(self.showView.mas_centerY).offset(-10);
        }];
        [showCarTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@21);
            make.bottom.equalTo(self.showView.mas_bottom);
            make.centerX.equalTo(showCarImgView.mas_centerX);
        }];
        [showCarCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.showView.mas_top);
            make.height.equalTo(@15);
            if (carCount.length == 1) {
                make.width.equalTo(@15);
            }
            make.left.equalTo(showCarImgView.mas_right);
        }];
        
        UILabel *addCarLab = [[UILabel alloc]init];
        addCarLab.text = @"加入购物车";
        addCarLab.textColor = [UIColor whiteColor];
        [self.addView addSubview:addCarLab];
        [addCarLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@21);
            make.centerX.centerY.equalTo(self.addView);
        }];
        
        self.showView.userInteractionEnabled = YES;
        UITapGestureRecognizer *click1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showCarClick)];
        [self.showView addGestureRecognizer:click1];
        
        self.addView.userInteractionEnabled = YES;
        UITapGestureRecognizer *click2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addCarClick)];
        [self.addView addGestureRecognizer:click2];
    }
    return self;
}
- (void)showCarClick{

}
- (void)addCarClick{

}
#pragma mark getter and setter
-(UIView *)showView{
    if (_showView == nil) {
        _showView = [[UIView alloc]init];
        _showView.backgroundColor = [UIColor grayColor];
    }
    return _showView;
}
-(UIView *)addView{
    if (_addView == nil) {
        _addView = [[UIView alloc]init];
        _addView.backgroundColor = MainColor;
    }
    return _addView;
}
@end
