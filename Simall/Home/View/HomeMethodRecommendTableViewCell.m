//
//  HomeMethodRecommendTableViewCell.m
//  Simall
//
//  Created by 张浩 on 16/4/27.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "HomeMethodRecommendTableViewCell.h"
@interface HomeMethodRecommendTableViewCell ()
@property (nonatomic , strong)UIScrollView *scrollView;
@property (nonatomic , strong)UIView *scrollBackView;

@end

@implementation HomeMethodRecommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}
- (void)showView{
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.scrollBackView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    [self.scrollBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.scrollView.mas_left);
    }];
    UIView *lastView;
    for (int i = 0; i < self.dataArr.count; i++) {
        NSDictionary *dic = [self.dataArr objectAtIndex:i];
        NSString *imgStr = [PublicObject convertNullString:[dic objectForKey:@"masterpla"]];
        NSString *titleStr = [PublicObject convertNullString:[dic objectForKey:@"dname"]];
        HomeMethodRecommendView *recommendView = [[HomeMethodRecommendView alloc]initWithTitleImg:imgStr titleStr:titleStr tag:i];
        //        recommendView.delegate = self;
        [self.scrollBackView addSubview:recommendView];
        [recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastView) {
                make.top.mas_equalTo(lastView.mas_top);
                make.left.mas_equalTo(lastView.mas_right).offset(1);
            }else{
                make.top.left.mas_equalTo(0);
            }
            make.width.mas_equalTo((SCREEN_WIDTH - 16)/3);
            make.height.mas_equalTo((SCREEN_WIDTH - 16)/3+30);
            
        }];
        lastView = recommendView;
    }
    [self.scrollBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastView.mas_right).offset(8);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.scrollBackView.mas_right);
    }];
}
#pragma mark getter and setter
-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _scrollView;
}
-(UIView *)scrollBackView{
    if (_scrollBackView == nil) {
        _scrollBackView = [[UIView alloc]init];
        _scrollBackView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _scrollBackView;
}

@end
