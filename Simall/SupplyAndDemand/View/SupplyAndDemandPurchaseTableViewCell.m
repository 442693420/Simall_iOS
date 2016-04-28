//
//  SupplyAndDemandPurchaseTableViewCell.m
//  JCHProject
//
//  Created by 张浩 on 16/4/13.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "SupplyAndDemandPurchaseTableViewCell.h"
@interface SupplyAndDemandPurchaseTableViewCell()
@property (nonatomic , strong)UILabel *titleLab;
@property (nonatomic , strong)UILabel *timeLab;
@property (nonatomic , strong)UILabel *statusLab;
@property (nonatomic , strong)UIButton *priceBtn;

@end
@implementation SupplyAndDemandPurchaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}
-(void)showView{
    NSString *titleStr = [self.dic objectForKey:@"title"];
    NSString *timeStr = [self.dic objectForKey:@"time"];
    NSString *statusStr = [self.dic objectForKey:@"status"];
    
    [self addSubview:self.titleLab];
    [self addSubview:self.timeLab];
    [self addSubview:self.statusLab];
    [self addSubview:self.priceBtn];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(8);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@30);
    }];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab.mas_left);
        make.top.equalTo(self.titleLab.mas_bottom).offset(3);
        make.height.equalTo(@30);
    }];
    [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-38);
        make.centerY.equalTo(self.titleLab.mas_centerY);
        make.height.equalTo(@30);
    }];
    [self.priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.statusLab.mas_right);
        make.centerY.equalTo(self.timeLab.mas_centerY);
        make.height.equalTo(@30);
        make.width.equalTo(@60);
    }];
    
    if ([statusStr isEqualToString:@"0"]) {
        self.statusLab.text = @"[暂无报价]";
        self.statusLab.textColor = [UIColor orangeColor];
    }else if([statusStr isEqualToString:@"1"]){
        self.statusLab.text = @"[已有报价]";
        self.statusLab.textColor = [UIColor blueColor];
    }else{
        self.statusLab.text = @"[已中标]";
        self.statusLab.textColor = [UIColor redColor];
    }
    
    self.titleLab.text = titleStr;
    self.timeLab.text = timeStr;
}
- (void)responseBtnClick{
    //接单回复
}
#pragma mark getter and setter

-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.font = [UIFont systemFontOfSize:14];
    }
    return _titleLab;
}
-(UILabel *)timeLab{
    if (_timeLab == nil) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.textColor = [UIColor darkGrayColor];
        _timeLab.font = [UIFont systemFontOfSize:12];
    }
    return _timeLab;
}
-(UILabel *)statusLab{
    if (_statusLab == nil) {
        _statusLab = [[UILabel alloc]init];
        _statusLab.font = [UIFont systemFontOfSize:12];
    }
    return _statusLab;
}
-(UIButton *)priceBtn{
    if (_priceBtn == nil) {
        _priceBtn = [[UIButton alloc]init];
        _priceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_priceBtn setTitle:@"我要报价" forState:UIControlStateNormal];
        [_priceBtn setBackgroundColor:MainColor];
        [_priceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_priceBtn addTarget:self action:@selector(responseBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _priceBtn.layer.masksToBounds = YES;
        _priceBtn.layer.cornerRadius = 5;
    }
    return _priceBtn;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
