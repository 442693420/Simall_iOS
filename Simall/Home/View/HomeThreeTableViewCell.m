//
//  HomeThreeTableViewCell.m
//  JCHProject
//
//  Created by 张浩 on 16/4/13.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "HomeThreeTableViewCell.h"
@interface HomeThreeTableViewCell ()
@property (nonatomic , strong)UIView *titleBackView;
@property (nonatomic , strong)UIView *infoBackView;
@end

@implementation HomeThreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
            }
    return self;
}
- (void)showViewWithTitle:(NSString *)title labArr:(NSArray *)labAarr{
    [self addSubview:self.titleBackView];
    [self addSubview:self.infoBackView];
    
    [self.titleBackView addSubview:self.titleLab];
    [self.infoBackView addSubview:self.labScrollView];
    
    [self.titleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.right.equalTo(self.titleLab.mas_right);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.titleBackView);
        make.left.equalTo(self.titleBackView.mas_left).offset(8);
    }];
    [self.infoBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleBackView.mas_right);
        make.top.right.bottom.equalTo(self);
    }];

    self.labScrollView.frame = CGRectMake(self.titleBackView.frame.size.width, 0, SCREEN_WIDTH-self.titleBackView.frame.size.width, 44);

    self.titleLab.text = title;
    [self.labScrollView configViewsWithLabArr:labAarr];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark getter and setter
-(UIView *)titleBackView{
    if (_titleBackView == nil) {
        _titleBackView = [[UIView alloc]init];
        _titleBackView.backgroundColor = [UIColor whiteColor];
    }
    return _titleBackView;
}
-(UIView *)infoBackView{
    if (_infoBackView == nil) {
        _infoBackView = [[UIView alloc]init];
        _infoBackView.backgroundColor = [UIColor whiteColor];
    }
    return _infoBackView;
}
-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [UIColor darkGrayColor];
        _titleLab.font = [UIFont systemFontOfSize:16];
    }
    return _titleLab;
}
-(UILableScrollerView *)labScrollView{
    if (_labScrollView == nil) {
        NSLog(@"%f",self.titleBackView.frame.size.width);
        _labScrollView = [[UILableScrollerView alloc]init];
    }
    return _labScrollView;
}
@end
