//
//  HomeProductRecommendView.m
//  Simall
//
//  Created by 张浩 on 16/4/26.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "HomeProductRecommendView.h"
@interface HomeProductRecommendView()
@property (nonatomic , strong)UIView *titleBackView;
@property (nonatomic , strong)UIView *bottomBackView;
@property (nonatomic , strong)UIImageView *recommendImgView;
@property (nonatomic , strong)UIImageView *contentImgView;
@property (nonatomic , strong)UILabel *priceLab;
@property (nonatomic , strong)UILabel *infoLab;
@end
@implementation HomeProductRecommendView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithImgStr:(NSString *)imgStr priceStr:(NSString *)priceStr infoStr:(NSString *)infoStr andTag:(NSInteger)tag
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [self addSubview:self.titleBackView];
        [self addSubview:self.bottomBackView];
        
        [self.titleBackView addSubview:self.contentImgView];
        [self.titleBackView addSubview:self.recommendImgView];
        [self.titleBackView addSubview:self.priceLab];
        [self.bottomBackView addSubview:self.infoLab];
        
        [self.titleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self.mas_left).offset(4);
            make.right.equalTo(self.mas_right).offset(-4);
            make.bottom.equalTo(self.bottomBackView.mas_top);
        }];
        [self.bottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self.mas_left).offset(4);
            make.right.equalTo(self.mas_right).offset(-4);
            make.height.equalTo(@44);
        }];
        
        [self.contentImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.titleBackView);
            make.bottom.equalTo(self.priceLab.mas_top);
        }];
        [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.titleBackView);
            make.height.equalTo(@21);
        }];
        [self.recommendImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.titleBackView.mas_right).offset(-8);
            make.top.equalTo(self.titleBackView.mas_top);
            make.width.height.equalTo(@30);
        }];
        [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.bottomBackView);
        }];
        
        NSURL *url = [NSURL URLWithString:imgStr];
        [self.contentImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default"]];
        self.priceLab.text = priceStr;
        self.infoLab.text = infoStr;
        self.contentImgView.tag = tag;
        
        self.contentImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick)];
        [self.contentImgView addGestureRecognizer:click];
    }
    return self;
}
- (void)imageClick{
    [self.delegate homeProductRecommendViewClickWithBtnTag:self.contentImgView.tag];
}
#pragma mark getter and setter
-(UIView *)titleBackView{
    if (_titleBackView == nil) {
        _titleBackView = [[UIView alloc]init];
        _titleBackView.backgroundColor = [UIColor whiteColor];
    }
    return _titleBackView;
}
-(UIView *)bottomBackView{
    if (_bottomBackView == nil) {
        _bottomBackView = [[UIView alloc]init];
        _bottomBackView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _bottomBackView;
}
-(UIImageView *)recommendImgView{
    if (_recommendImgView == nil) {
        _recommendImgView = [[UIImageView alloc]init];
        [_recommendImgView setImage:[UIImage imageNamed:@"tuijian.png"]];
    }
    return _recommendImgView;
}
-(UIImageView *)contentImgView{
    if (_contentImgView == nil) {
        _contentImgView = [[UIImageView alloc]init];
    }
    return _contentImgView;
}
-(UILabel *)priceLab{
    if (_priceLab == nil) {
        _priceLab = [[UILabel alloc]init];
        _priceLab.textColor = [UIColor redColor];
        _priceLab.font = [UIFont systemFontOfSize:12];
    }
    return _priceLab;
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
