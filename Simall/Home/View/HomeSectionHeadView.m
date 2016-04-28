//
//  HomeSectionHeadView.m
//  Simall
//
//  Created by 张浩 on 16/4/26.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "HomeSectionHeadView.h"

@implementation HomeSectionHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleView];
        [self addSubview:self.titleLab];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.left.equalTo(self);
            make.height.equalTo(@3);
        }];
        
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(8);
            make.top.equalTo(self.mas_top).offset(8);
            make.bottom.equalTo(self.mas_bottom).offset(-8);
            make.width.equalTo(@5);
        }];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleView.mas_right).offset(8);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return self;
}
#pragma mark getter and setter
-(UIView *)titleView{
    if (_titleView == nil) {
        _titleView = [[UIView alloc]init];
    }
    return _titleView;
}
-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [UIColor darkGrayColor];
        _titleLab.font = [UIFont systemFontOfSize:14];
    }
    return _titleLab;
}
@end
