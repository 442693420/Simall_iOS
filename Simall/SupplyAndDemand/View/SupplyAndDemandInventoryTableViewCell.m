//
//  SupplyAndDemandInventoryTableViewCell.m
//  JCHProject
//
//  Created by 张浩 on 16/4/13.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "SupplyAndDemandInventoryTableViewCell.h"

@interface SupplyAndDemandInventoryTableViewCell()
@property (nonatomic , strong)UIImageView *imgView;
@property (nonatomic , strong)UILabel *titleLab;
@property (nonatomic , strong)UILabel *priceLab;
@property (nonatomic , strong)UILabel *countLab;
@property (nonatomic , strong)UILabel *brandLab;
@property (nonatomic , strong)UILabel *modelLab;
@property (nonatomic , strong)UILabel *timeLab;

@end
@implementation SupplyAndDemandInventoryTableViewCell

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
    NSString *imgStr = [self.dic objectForKey:@"image"];
    NSString *titleStr = [self.dic objectForKey:@"title"];
    NSString *priceStr = [self.dic objectForKey:@"price"];
    NSString *countStr = [self.dic objectForKey:@"count"];
    NSString *brandStr = [self.dic objectForKey:@"brand"];
    NSString *modelStr = [self.dic objectForKey:@"model"];
    NSString *timeStr = [self.dic objectForKey:@"time"];

    [self addSubview:self.imgView];
    [self addSubview:self.titleLab];
    [self addSubview:self.priceLab];
    [self addSubview:self.countLab];
    [self addSubview:self.brandLab];
    [self addSubview:self.modelLab];
    [self addSubview:self.timeLab];

    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(8);
        make.top.equalTo(self.mas_top).offset(8);
        make.width.height.equalTo(@60);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(5);
        make.top.equalTo(self.imgView.mas_top);
        make.height.equalTo(@21);
    }];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab.mas_left);
        make.top.equalTo(self.titleLab.mas_bottom);
        make.height.equalTo(@15);
    }];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab.mas_left);
        make.top.equalTo(self.priceLab.mas_bottom);
//        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@15);
    }];
    [self.brandLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_left).offset(8);
        make.top.equalTo(self.imgView.mas_bottom);
        make.height.equalTo(@21);
    }];
    [self.modelLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.brandLab.mas_left);
        make.top.equalTo(self.brandLab.mas_bottom);
        make.height.equalTo(@21);
    }];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.brandLab.mas_left);
        make.top.equalTo(self.modelLab.mas_bottom);
        make.height.equalTo(@21);
    }];
    
    self.imgView.image = [UIImage imageNamed:imgStr];
    self.titleLab.text = titleStr;
    self.priceLab.text = priceStr;
    self.countLab.text = countStr;
    self.brandLab.text = brandStr;
    self.modelLab.text = modelStr;
    self.timeLab.text = timeStr;
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
-(UILabel *)priceLab{
    if (_priceLab == nil) {
        _priceLab = [[UILabel alloc]init];
        _priceLab.textColor = [UIColor redColor];
        _priceLab.font = [UIFont systemFontOfSize:12];
    }
    return _priceLab;
}
-(UILabel *)countLab{
    if (_countLab == nil) {
        _countLab = [[UILabel alloc]init];
        _countLab.textColor = [UIColor darkGrayColor];
        _countLab.font = [UIFont systemFontOfSize:12];
    }
    return _countLab;
}
-(UILabel *)brandLab{
    if (_brandLab == nil) {
        _brandLab = [[UILabel alloc]init];
        _brandLab.textColor = [UIColor darkGrayColor];
        _brandLab.font = [UIFont systemFontOfSize:12];
    }
    return _brandLab;
}
-(UILabel *)modelLab{
    if (_modelLab == nil) {
        _modelLab = [[UILabel alloc]init];
        _modelLab.textColor = [UIColor darkGrayColor];
        _modelLab.font = [UIFont systemFontOfSize:12];
    }
    return _modelLab;
}
-(UILabel *)timeLab{
    if (_timeLab == nil) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.textColor = [UIColor darkGrayColor];
        _timeLab.font = [UIFont systemFontOfSize:12];
    }
    return _timeLab;
}

@end
