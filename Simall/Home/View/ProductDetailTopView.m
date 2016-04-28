//
//  ProductDetailTopView.m
//  JCHProject
//
//  Created by 张浩 on 16/4/15.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "ProductDetailTopView.h"
@interface ProductDetailTopView()

@end
@implementation ProductDetailTopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithTitleImg:(NSString *)imgStr isRecommand:(NSInteger)recommandStatus titleStr:(NSString *)titleStr infoStr:(NSString *)infoStr{
    self = [super init];
    if (self) {
        [self addSubview:self.titleImgView];
        [self addSubview:self.titleLab];
        [self addSubview:self.infoLab];
        [self.titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(8);
            make.right.equalTo(self.mas_right).offset(-8);
            make.top.equalTo(self.mas_top);
            make.width.mas_equalTo((SCREEN_WIDTH - 16) * 0.5);
        }];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleImgView);
            make.top.equalTo(self.titleImgView.mas_bottom).offset(3);
        }];
        [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleImgView);
            make.top.equalTo(self.titleLab.mas_bottom).offset(3);
        }];
        if (recommandStatus == 1) {
            [self addSubview:self.recommandImgView];
            [self.recommandImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.titleImgView.mas_right);
                make.top.equalTo(self.titleImgView.mas_top).offset(8);
                make.width.height.equalTo(@40);
            }];
            [self.recommandImgView setImage:[UIImage imageNamed:@"tuijian.png"]];
        }
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.infoLab.mas_bottom).offset(8);
        }];
        [self.titleImgView setImage:[UIImage imageNamed:imgStr]];
        self.titleLab.text = titleStr;
        self.infoLab.text = infoStr;
    }
    return self;
}

#pragma mark getter and setter
-(UIImageView *)titleImgView{
    if (_titleImgView == nil) {
        _titleImgView = [[UIImageView alloc]init];
    }
    return _titleImgView;
}
-(UIImageView *)recommandImgView{
    if (_recommandImgView == nil) {
        _recommandImgView = [[UIImageView alloc]init];
    }
    return _recommandImgView;
}
-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [UIColor darkGrayColor];
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}
-(UILabel *)infoLab{
    if (_infoLab == nil) {
        _infoLab = [[UILabel alloc]init];
        _infoLab.textColor = [UIColor darkGrayColor];
        _infoLab.font = [UIFont systemFontOfSize:12];
        _infoLab.numberOfLines = 0;
    }
    return _infoLab;
}
@end
