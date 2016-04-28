//
//  TitleInfoLableTableViewCell.m
//  JCHProject
//
//  Created by 张浩 on 16/4/22.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "TitleInfoLableTableViewCell.h"

@implementation TitleInfoLableTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLab];
        [self addSubview:self.infoLab];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(8);
            make.height.equalTo(@30);
            make.centerY.equalTo(self.mas_centerY);
        }];
        [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-8);
            make.height.equalTo(@30);
            make.centerY.equalTo(self.titleLab.mas_centerY);
        }];
    }
    return self;
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
-(UILabel *)infoLab{
    if (_infoLab == nil) {
        _infoLab = [[UILabel alloc]init];
        _infoLab.textColor = [UIColor grayColor];
        _infoLab.font = [UIFont systemFontOfSize:12];
        _infoLab.textAlignment = NSTextAlignmentRight;
    }
    return _infoLab;

}
@end
