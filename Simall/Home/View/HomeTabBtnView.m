//
//  HomeTabBtnView.m
//  PSBProject
//
//  Created by 张浩 on 16/2/24.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "HomeTabBtnView.h"
@implementation HomeTabBtnView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithTag:(int)tag Image:(UIImage *)img title:(NSString *)title actionBlock:(HomeTabBtnBlock)actionBlock{
    self = [super init];
    if (self) {
        self.actionBlock = actionBlock;
        self.btn.tag = tag;
        [self addSubview:self.btn];
        self.lab = [[UILabel alloc]init];
//        [self.lab setBackgroundColor:RGB(243, 243, 243, 1)];
        self.lab.textColor = [UIColor darkGrayColor];
        self.lab.textAlignment = NSTextAlignmentCenter;
        self.lab.font = [UIFont systemFontOfSize:12];
        self.lab.text = title;
        [self addSubview:self.lab];
        [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@50);
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top).offset(8);
        }];
        
        [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@30);
            make.top.equalTo(self.btn.mas_bottom);
        }];
        
        [self.btn setImage:img forState:UIControlStateNormal
         ];
    }
    return self;
}

- (void)click1:(id)sender{
    self.actionBlock(self.btn.tag);
}
-(UIButton *)btn{
    if (_btn == nil) {
        _btn = [[UIButton alloc]init];
//        [_btn setBackgroundColor:[UIColor cyanColor]];
        [_btn addTarget:self action:@selector(click1:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}
@end
