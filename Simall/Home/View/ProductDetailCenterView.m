//
//  ProductDetailCenterView.m
//  JCHProject
//
//  Created by 张浩 on 16/4/15.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "ProductDetailCenterView.h"
@interface ProductDetailCenterView()

@end
@implementation ProductDetailCenterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithLabDicArr:(NSArray *)labArr{
    self = [super init];
    if (self) {
        [self addSubview:self.labBackView];
        [self addSubview:self.btnBackView];
        
        [self.labBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left).offset(8);
            make.right.equalTo(self.mas_right).offset(-8);
        }];
        [self.btnBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44);
            make.left.equalTo(self.mas_left).offset(8);
            make.right.equalTo(self.mas_right).offset(-8);
            make.top.equalTo(self.labBackView.mas_bottom).offset(1);
        }];
        UIView *lastView;
        for (int i = 0; i < labArr.count; i++) {
            
            NSDictionary *dic = [labArr objectAtIndex:i];
            NSString *titleStr = [dic objectForKey:@"title"];
            NSString *infoStr = [dic objectForKey:@"info"];
            UILabel *lab = [[UILabel alloc]init];
            lab.text = [NSString stringWithFormat:@"%@:%@",titleStr,infoStr];
            lab.textColor = [UIColor darkGrayColor];
            lab.font = [UIFont systemFontOfSize:12];
            lab.numberOfLines = 0;
            [self.labBackView addSubview:lab];
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastView) {
                    make.top.mas_equalTo(lastView.mas_bottom).offset(3);
                }else{
                    make.top.mas_equalTo(0);
                }
                make.left.equalTo(self.mas_left).offset(8);
                make.width.mas_equalTo(SCREEN_WIDTH-16);
                
            }];
            lastView = lab;
        }
        [self.labBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastView.mas_bottom);
        }];
        
        UILabel *countLab = [[UILabel alloc]init];
        NSInteger countNum = 1;
        countLab.text = [NSString stringWithFormat:@"已选中数量:%ld",(long)countNum];
        [self.btnBackView addSubview:countLab];
        UILabel *arrowLab = [[UILabel alloc]init];
        arrowLab.textColor = [UIColor darkGrayColor];
        arrowLab.text = @">";
        [self.btnBackView addSubview:arrowLab];
        [countLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.btnBackView);
        }];
        [arrowLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.btnBackView);
            make.right.equalTo(self.btnBackView.mas_right).offset(-8);
        }];
        self.btnBackView.userInteractionEnabled = YES;
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseNumClick)];
        [self.btnBackView addGestureRecognizer:click];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.btnBackView.mas_bottom).offset(8);
        }];

    }
    return self;
}
- (void)chooseNumClick{
    [self.delegate presentProductDetailChooseView];
}
#pragma mark getter and setter
-(UIView *)labBackView{
    if (_labBackView == nil) {
        _labBackView = [[UIView alloc]init];
        _labBackView.backgroundColor = [UIColor whiteColor];
    }
    return _labBackView;
}
-(UIView *)btnBackView{
    if (_btnBackView == nil) {
        _btnBackView = [[UIView alloc]init];
        _btnBackView.backgroundColor = [UIColor whiteColor];
    }
    return _btnBackView;
}
@end
