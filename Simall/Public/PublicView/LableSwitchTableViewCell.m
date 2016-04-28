//
//  LableSwitchTableViewCell.m
//  JCHProject
//
//  Created by 张浩 on 16/4/22.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "LableSwitchTableViewCell.h"

@implementation LableSwitchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLab];
        [self addSubview:self.switchBtn];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(8);
            make.height.equalTo(@30);
            make.centerY.equalTo(self.mas_centerY);
        }];
        [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-8);
            make.height.equalTo(@30);
            make.width.equalTo(@60);
            make.centerY.equalTo(self.titleLab.mas_centerY);
        }];
    }
    return self;
}
-(void) switchAction:(id)sender
{
    UISwitch *switchBtn = (UISwitch *)sender;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [UIColor darkGrayColor];
        _titleLab.font = [UIFont systemFontOfSize:14];
    }
    return _titleLab;
}
-(UISwitch *)switchBtn{
    if (_switchBtn == nil) {
        _switchBtn = [[UISwitch alloc]init];
        _switchBtn.on = YES;//设置初始为ON的一边
        [_switchBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchBtn;
}
@end
