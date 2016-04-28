//
//  SupplyAndDemandDemandTableViewCell.m
//  JCHProject
//
//  Created by 张浩 on 16/4/13.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "SupplyAndDemandDemandTableViewCell.h"
@interface SupplyAndDemandDemandTableViewCell()
@property (nonatomic , strong)UIImageView *imgView;
@property (nonatomic , strong)UILabel *titleLab;
@property (nonatomic , strong)UILabel *infoLab;
@property (nonatomic , strong)UILabel *otherLab;
@property (nonatomic , strong)UIButton *statusBtn;

@end
@implementation SupplyAndDemandDemandTableViewCell

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
-(void)showView{
    NSString *status = [self.dic objectForKey:@"status"];
    NSString *imgStr = [self.dic objectForKey:@"image"];
    NSString *titleStr = [self.dic objectForKey:@"title"];
    NSString *infoStr = [self.dic objectForKey:@"info"];
    NSString *otherStr = [self.dic objectForKey:@"other"];
    
    [self addSubview:self.imgView];
    [self addSubview:self.titleLab];
    [self addSubview:self.infoLab];
    [self addSubview:self.otherLab];
    [self addSubview:self.statusBtn];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(8);
        make.top.equalTo(self.mas_top).offset(8);
        make.width.height.equalTo(@60);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(3);
        make.top.equalTo(self.imgView.mas_top);
        make.height.equalTo(@21);
    }];
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab.mas_left);
        make.top.equalTo(self.titleLab.mas_bottom).offset(3);
        make.height.equalTo(@15);
    }];
    [self.otherLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab.mas_left);
        make.top.equalTo(self.infoLab.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.statusBtn.mas_right);
    }];
    [self.statusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@25);
        make.right.equalTo(self.mas_right).offset(-38);
        make.top.equalTo(self.titleLab.mas_top);
    }];
    
    if ([status isEqualToString:@"0"]) {
        [self.statusBtn setTitle:@"接单回复" forState:UIControlStateNormal];
        [self.statusBtn setBackgroundColor:MainColor];
        [self.statusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.statusBtn addTarget:self action:@selector(responseBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.statusBtn.layer.masksToBounds = YES;
        self.statusBtn.layer.cornerRadius = 5;
    }else{
        [self.statusBtn setTitle:@"[已中标]" forState:UIControlStateNormal];
        [self.statusBtn setBackgroundColor:[UIColor clearColor]];
        [self.statusBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    
    self.imgView.image = [UIImage imageNamed:imgStr];
    self.titleLab.text = titleStr;
    self.infoLab.text = infoStr;
    self.otherLab.text = otherStr;
}
- (void)responseBtnClick{
    //接单回复
}
#pragma mark getter and setter
-(UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc]init];
    }
    return _imgView;
}
-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.font = [UIFont systemFontOfSize:14];
    }
    return _titleLab;
}
-(UILabel *)infoLab{
    if (_infoLab == nil) {
        _infoLab = [[UILabel alloc]init];
        _infoLab.textColor = [UIColor darkGrayColor];
        _infoLab.font = [UIFont systemFontOfSize:12];
    }
    return _infoLab;
}
-(UILabel *)otherLab{
    if (_otherLab == nil) {
        _otherLab = [[UILabel alloc]init];
        _otherLab.textColor = [UIColor darkGrayColor];
        _otherLab.font = [UIFont systemFontOfSize:12];
        _otherLab.numberOfLines = 0;
    }
    return _otherLab;
}
-(UIButton *)statusBtn{
    if (_statusBtn == nil) {
        _statusBtn = [[UIButton alloc]init];
        _statusBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        //                [_responseBtn setTitle:@"接单回复" forState:UIControlStateNormal];
        //                [_responseBtn setBackgroundColor:[UIColor greenColor]];
        //                [_responseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //                [_responseBtn addTarget:self action:@selector(responseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _statusBtn;
}
@end
