//
//  HomeUpdateView.m
//  Simall
//
//  Created by 张浩 on 16/4/26.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "HomeUpdateView.h"
@interface HomeUpdateView()
@property(nonatomic , strong)UIView *titleBackView;
@property(nonatomic , strong)UIView *centerBackView;
@property(nonatomic , strong)UIView *bottomBackView;
@property(nonatomic , strong)UILabel *titleLab;
@property(nonatomic , strong)UIImageView *titleImgView;
@property(nonatomic , strong)UILabel *centerLab;
@property(nonatomic , strong)UILabel *bottomLab;

@end
@implementation HomeUpdateView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithTitleStr:(NSString *)titleStr nowNumStr:(NSString *)nowNumStr allNumStr:(NSString *)allNumStr titleImgColor:(UIColor *)imgColor Tag:(NSInteger)tag
{
    self = [super init];
    if (self) {
        [self addSubview:self.titleBackView];
        [self addSubview:self.centerBackView];
        [self addSubview:self.bottomBackView];
        
        [self.titleBackView addSubview:self.titleImgView];
        [self.titleBackView addSubview:self.titleLab];
        
        [self.centerBackView addSubview:self.centerLab];
       
        [self.bottomBackView addSubview:self.bottomLab];
        
        [self.titleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.bottom.equalTo(self.centerBackView.mas_top);
        }];
        [self.centerBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@30);
            make.bottom.equalTo(self.bottomBackView.mas_top);
        }];
        [self.bottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@30);
        }];
        
        
        [self.titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.titleBackView.mas_centerX);
            make.centerY.equalTo(self.titleBackView.mas_centerY);
            make.height.width.mas_equalTo(SCREEN_WIDTH / 5);
        }];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.titleImgView);
        }];
        
        [self.centerLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.centerBackView);
        }];
        
        [self.bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.bottomBackView);
        }];
        
        self.titleLab.text = nowNumStr;
        self.titleImgView.backgroundColor = imgColor;
        self.centerLab.tag = tag;
        self.centerLab.text = allNumStr;
        self.bottomLab.text = titleStr;
        
        self.titleImgView.layer.masksToBounds = YES;
        NSLog(@"%f",self.titleImgView.frame.size.width);
        self.titleImgView.layer.cornerRadius = (SCREEN_WIDTH / 3 * 0.6)/2;
        
        self.titleImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick)];
        [self.titleImgView addGestureRecognizer:click];
        
        self.centerLab.textColor = imgColor;
    }
    return self;
}
- (void)imageClick{
    [self.delegate homeUpdateViewClickWithBtnTag:self.titleImgView.tag];
}
#pragma mark getter and setter
-(UIView *)titleBackView{
    if (_titleBackView == nil) {
        _titleBackView = [[UIView alloc]init];
    }
    return _titleBackView;
}
-(UIView *)centerBackView{
    if (_centerBackView == nil) {
        _centerBackView = [[UIView alloc]init];
    }
    return _centerBackView;
}
-(UIView *)bottomBackView{
    if (_bottomBackView == nil) {
        _bottomBackView = [[UIView alloc]init];
    }
    return _bottomBackView;
}
-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.font = [UIFont systemFontOfSize:16];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}
-(UIImageView *)titleImgView{
    if (_titleImgView == nil) {
        _titleImgView = [[UIImageView alloc]init];
    }
    return _titleImgView;
}
-(UILabel *)centerLab{
    if (_centerLab == nil) {
        _centerLab = [[UILabel alloc]init];
        _centerLab.textColor = [UIColor whiteColor];
        _centerLab.font = [UIFont systemFontOfSize:18];
        _centerLab.textAlignment = NSTextAlignmentCenter;
    }
    return _centerLab;
}
-(UILabel *)bottomLab{
    if (_bottomLab == nil) {
        _bottomLab = [[UILabel alloc]init];
        _bottomLab.textColor = [UIColor darkGrayColor];
        _bottomLab.font = [UIFont systemFontOfSize:12];
        _bottomLab.textAlignment = NSTextAlignmentCenter;
    }
    return _bottomLab;
}
@end
