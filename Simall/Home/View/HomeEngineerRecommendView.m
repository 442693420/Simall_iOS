//
//  HomeEngineerRecommendView.m
//  Simall
//
//  Created by 张浩 on 16/4/26.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "HomeEngineerRecommendView.h"
@interface  HomeEngineerRecommendView ()
@property (nonatomic , strong)UIView *backView;
@property (nonatomic , strong)UIImageView *titleImgView;
@property (nonatomic , strong)UILabel *nameLab;
@property (nonatomic , strong)UIView *starBackView;
@end
@implementation HomeEngineerRecommendView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (id)initWithTitleImg:(NSString *)img nameStr:(NSString *)name recommendNum:(NSInteger)recommendNum tag:(NSInteger)tag
{
    self = [super init];
    if (self) {
        [self addSubview:self.backView];
        
        [self.backView addSubview:self.titleImgView];
        [self.backView addSubview:self.nameLab];
        [self.backView addSubview:self.starBackView];
        
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(self);
        }];
        [self.titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backView.mas_left).offset(8);
            make.top.equalTo(self.backView.mas_top).offset(8);
            make.right.equalTo(self.backView.mas_right).offset(-8);
            make.bottom.equalTo(self.nameLab.mas_top);
        }];
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.height.equalTo(@21);
            make.bottom.equalTo(self.starBackView.mas_top);
        }];
        [self.starBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom);
            make.width.mas_equalTo(recommendNum * 10 + recommendNum - 1);
            make.height.equalTo(@20);
        }];
        UIView *lastView;
        for (int i = 0; i < recommendNum; i++) {
            UIImageView *img = [[UIImageView alloc]init];
            img.image = [UIImage imageNamed:@"star"];
            [self.starBackView addSubview:img];
            
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastView) {
                    make.top.mas_equalTo(lastView.mas_top);
                    make.left.mas_equalTo(lastView.mas_right).offset(1);
                }else{
                    make.top.left.mas_equalTo(0);
                }
                
                make.width.height.mas_equalTo(@10);
            }];
            lastView = img;
        }
        NSURL *url = [NSURL URLWithString:img];
        [self.titleImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default"]];
        self.nameLab.text = name;
        self.tag = tag;
        self.delegate = self;
    }
    return self;
}

#pragma mark getter and setter
-(UIView *)backView{
    if (_backView == nil) {
        _backView = [[UIView alloc]init];
    }
    return _backView;
}
-(UIImageView *)titleImgView{
    if (_titleImgView == nil) {
        _titleImgView = [[UIImageView alloc]init];
    }
    return _titleImgView;
}
-(UILabel *)nameLab{
    if (_nameLab == nil) {
        _nameLab = [[UILabel alloc]init];
        _nameLab.textColor = [UIColor darkGrayColor];
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.font = [UIFont systemFontOfSize:14];
    }
    return _nameLab;
}
-(UIView *)starBackView{
    if (_starBackView == nil) {
        _starBackView = [[UIView alloc]init];
    }
    return _starBackView;
}
@end
