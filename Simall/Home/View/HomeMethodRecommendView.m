//
//  HomeMethodRecommendView.m
//  Simall
//
//  Created by 张浩 on 16/4/27.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "HomeMethodRecommendView.h"
@interface  HomeMethodRecommendView ()
@property (nonatomic , strong)UIView *backView;
@property (nonatomic , strong)UIImageView *titleImgView;
@property (nonatomic , strong)UILabel *titleLab;
@end
@implementation HomeMethodRecommendView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithTitleImg:(NSString *)img titleStr:(NSString *)title tag:(NSInteger)tag
{
    self = [super init];
    if (self) {
        [self addSubview:self.backView];
        
        [self.backView addSubview:self.titleImgView];
        [self.backView addSubview:self.titleLab];
        
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(self);
        }];
        [self.titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backView.mas_left).offset(8);
            make.top.equalTo(self.backView.mas_top).offset(8);
            make.right.equalTo(self.backView.mas_right).offset(-8);
            make.height.equalTo(self.titleImgView.mas_width);
        }];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@30);
            make.top.equalTo(self.titleImgView.mas_bottom).offset(8);
        }];
        NSURL *url = [NSURL URLWithString:img];
        [self.titleImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default"]];
        self.titleLab.text = title;
        self.tag = tag;
    }
    return self;
}

#pragma mark getter and setter
-(UIView *)backView{
    if (_backView == nil) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _backView;
}
-(UIImageView *)titleImgView{
    if (_titleImgView == nil) {
        _titleImgView = [[UIImageView alloc]init];
    }
    return _titleImgView;
}
-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [UIColor darkGrayColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:12];
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}
@end
