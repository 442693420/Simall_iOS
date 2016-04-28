//
//  HomeTitleLabMoreBtnInfoLabView.m
//  JCHProject
//
//  Created by 张浩 on 16/4/12.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "HomeTitleLabMoreBtnInfoLabView.h"
@interface HomeTitleLabMoreBtnInfoLabView()
@property (nonatomic , strong)UILabel *titleLab;
@property (nonatomic , strong)UIButton *moreBtn;
@property (nonatomic , strong)UILabel *infoLab;

@end
@implementation HomeTitleLabMoreBtnInfoLabView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithTitleStr:(NSString *)titleStr infoStr:(NSString *)infoStr btnTag:(NSInteger)btnTag{
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
        [bottomBackView addSubview:self.infoLab];
        
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
        [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomBackView.mas_left).offset(8);
            make.top.bottom.equalTo(bottomBackView);
            make.right.equalTo(bottomBackView.mas_right).offset(-8);
        }];
        
        //加载数据
        self.titleLab.text = titleStr;
        self.infoLab.text = infoStr;
        self.tag = btnTag;
    }
    return self;
}
- (void)moreBtnClick{
    [self.delegate homeTitleLabMoreBtnInfoLabViewClickWithBtnTag:self.tag];
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
