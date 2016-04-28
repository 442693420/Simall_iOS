//
//  HomeTitleLabCenterBtnInfoLabView.m
//  JCHProject
//
//  Created by 张浩 on 16/4/13.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "HomeTitleLabCenterBtnInfoLabView.h"

@interface HomeTitleLabCenterBtnInfoLabView()
@property(nonatomic , strong)UIView *titleBackView;
@property(nonatomic , strong)UIView *centerBackView;
@property(nonatomic , strong)UIView *bottomBackView;
@property(nonatomic , strong)UILabel *titleLab;
@property(nonatomic , strong)UILabel *centerLeftLab;
@property(nonatomic , strong)UILabel *centerRightLab;
@property(nonatomic , strong)UILabel *centerLab;
@property(nonatomic , strong)UIImageView *centerImgView;
@property(nonatomic , strong)UILabel *bottomLab;
@property(nonatomic , strong)UILabel *bottomLeftLab;
@property(nonatomic , strong)UILabel *bottomRightLab;

@end
@implementation HomeTitleLabCenterBtnInfoLabView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (id)initWithTitleStr:(NSString *)titleStr centerStr:(NSString *)centerStr bottomStr:(NSString *)bottomStr andCenterColor:(UIColor *)color andTag:(NSInteger)tag{
    self = [super init];
    if (self) {
        [self addSubview:self.titleBackView];
        [self addSubview:self.centerBackView];
        [self addSubview:self.bottomBackView];
        
        [self.titleBackView addSubview:self.titleLab];
        [self.centerBackView addSubview:self.centerImgView];
        [self.centerBackView addSubview:self.centerLab];
        [self.centerBackView addSubview:self.centerLeftLab];
        [self.centerBackView addSubview:self.centerRightLab];
        [self.bottomBackView addSubview:self.bottomLab];
        [self.bottomBackView addSubview:self.bottomLeftLab];
        [self.bottomBackView addSubview:self.bottomRightLab];
        
        [self.titleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.equalTo(@21);
        }];
        [self.centerBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.titleBackView.mas_bottom);
            make.bottom.equalTo(self.bottomBackView.mas_top);
        }];
        [self.bottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@21);
        }];

        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.titleBackView.mas_centerX);
            make.centerY.equalTo(self.titleBackView.mas_centerY);
            make.height.equalTo(@21);
        }];
        [self.centerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.centerBackView.mas_centerX);
            make.centerY.equalTo(self.centerBackView.mas_centerY);
            make.height.width.mas_equalTo(SCREEN_WIDTH / 3* 0.6);
        }];
        [self.centerLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.centerImgView);
        }];
        [self.centerLeftLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.centerImgView.mas_left);
            make.bottom.equalTo(self.centerImgView.mas_bottom);
            make.height.equalTo(@10);
        }];
        [self.centerRightLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.centerImgView.mas_right);
            make.bottom.equalTo(self.centerImgView.mas_bottom);
            make.height.equalTo(@10);
        }];
        [self.bottomLeftLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bottomLab.mas_left);
            make.bottom.equalTo(self.bottomBackView.mas_bottom);
            make.height.equalTo(@21);
        }];
        [self.bottomRightLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomLab.mas_right);
            make.bottom.equalTo(self.bottomBackView.mas_bottom);
            make.height.equalTo(@21);
        }];
        [self.bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bottomBackView.mas_centerX);
            make.height.equalTo(@21);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        self.titleLab.text = titleStr;
        self.centerImgView.backgroundColor = color;
        self.centerImgView.tag = tag;
        self.centerLab.text = centerStr;
        self.bottomLab.text = bottomStr;
        
        self.centerImgView.layer.masksToBounds = YES;
        NSLog(@"%f",self.centerImgView.frame.size.width);
        self.centerImgView.layer.cornerRadius = (SCREEN_WIDTH / 3 * 0.6)/2;
        
        self.centerImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick)];
        [self.centerImgView addGestureRecognizer:click];
        
        self.bottomLab.textColor = color;
    }
    return self;
}
- (void)imageClick{
    [self.delegate homeTitleLabCenterBtnInfoLabViewClickWithBtnTag:self.centerImgView.tag];
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
        _titleLab.textColor = [UIColor darkGrayColor];
        _titleLab.font = [UIFont systemFontOfSize:14];
    }
    return _titleLab;
}
-(UIImageView *)centerImgView{
    if (_centerImgView == nil) {
        _centerImgView = [[UIImageView alloc]init];
    }
    return _centerImgView;
}
-(UILabel *)centerLab{
    if (_centerLab == nil) {
        _centerLab = [[UILabel alloc]init];
        _centerLab.textColor = [UIColor whiteColor];
        _centerLab.font = [UIFont systemFontOfSize:16];
        _centerLab.textAlignment = NSTextAlignmentCenter;
    }
    return _centerLab;
}
-(UILabel *)centerLeftLab{
    if (_centerLeftLab == nil) {
        _centerLeftLab = [[UILabel alloc]init];
        _centerLeftLab.textColor = [UIColor darkGrayColor];
        _centerLeftLab.font = [UIFont systemFontOfSize:10];
        _centerLeftLab.text = @"+";
    }
    return _centerLeftLab;
}
-(UILabel *)centerRightLab{
    if (_centerRightLab == nil) {
        _centerRightLab = [[UILabel alloc]init];
        _centerRightLab.textColor = [UIColor darkGrayColor];
        _centerRightLab.font = [UIFont systemFontOfSize:10];
        _centerRightLab.text = @"条";
    }
    return _centerRightLab;
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
-(UILabel *)bottomLeftLab{
    if (_bottomLeftLab == nil) {
        _bottomLeftLab = [[UILabel alloc]init];
        _bottomLeftLab.textColor = [UIColor darkGrayColor];
        _bottomLeftLab.font = [UIFont systemFontOfSize:12];
        _bottomLeftLab.text = @"累计";
    }
    return _bottomLeftLab;
}
-(UILabel *)bottomRightLab{
    if (_bottomRightLab == nil) {
        _bottomRightLab = [[UILabel alloc]init];
        _bottomRightLab.textColor = [UIColor darkGrayColor];
        _bottomRightLab.font = [UIFont systemFontOfSize:12];
        _bottomRightLab.text = @"条";
    }
    return _bottomRightLab;
}
@end
