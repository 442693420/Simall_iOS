//
//  HomeTitleLabMoreBtnInfoImgView.m
//  JCHProject
//
//  Created by 张浩 on 16/4/12.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "HomeTitleLabMoreBtnInfoImgView.h"

@interface HomeTitleLabMoreBtnInfoImgView()
@property (nonatomic , strong)UILabel *titleLab;
@property (nonatomic , strong)UIButton *moreBtn;
@property (nonatomic , strong)UIImageView *infoImg;

@end
@implementation HomeTitleLabMoreBtnInfoImgView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithTitleStr:(NSString *)titleStr infoImg:(NSString *)imgStr btnTag:(NSInteger)btnTag{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UIView *titleBackView = [[UIView alloc]init];
        titleBackView.backgroundColor = [UIColor whiteColor];
        [self addSubview:titleBackView];
        UIView *bottomBackView = [[UIView alloc]init];
        bottomBackView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bottomBackView];
        [titleBackView addSubview:self.titleLab];
        [titleBackView addSubview:self.moreBtn];
        [bottomBackView addSubview:self.infoImg];
        
        [titleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(@21);
        }];
        [bottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(titleBackView.mas_bottom).offset(1);
            make.bottom.equalTo(self.mas_bottom).offset(-1);
        }];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleBackView.mas_left).offset(8);
            make.centerY.equalTo(titleBackView.mas_centerY);
            make.height.equalTo(titleBackView.mas_height);
        }];
        [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(titleBackView.mas_right).offset(-3);
            make.centerY.equalTo(titleBackView.mas_centerY);
            make.height.equalTo(titleBackView.mas_height);
        }];
        [self.infoImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomBackView.mas_left);
            make.top.bottom.equalTo(bottomBackView);
            make.right.equalTo(bottomBackView.mas_right);
        }];
        
        //加载数据
        self.titleLab.text = titleStr;
        self.infoImg.image = [UIImage imageNamed:imgStr];
        self.tag = btnTag;
    }
    return self;
}
- (void)moreBtnClick{
    [self.delegate homeTitleLabMoreBtnInfoImgViewClickWithBtnTag:self.tag];
}
-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [UIColor darkGrayColor];
        _titleLab.font = [UIFont systemFontOfSize:14];
    }
    return _titleLab;
}
-(UIButton *)moreBtn{
    if (_moreBtn == nil) {
        _moreBtn = [[UIButton alloc]init];
        [_moreBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_moreBtn setTitle:@"更多>" forState:UIControlStateNormal];
        [_moreBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}
-(UIImageView *)infoImg{
    if (_infoImg == nil) {
        _infoImg = [[UIImageView alloc]init];
    }
    return _infoImg;
}
@end
