//
//  SearchTableViewCell.m
//  JCHProject
//
//  Created by 张浩 on 16/4/14.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.keywordLab=[UILabel new];
        [self.keywordLab setTextAlignment:NSTextAlignmentLeft];
        [self.keywordLab setFont:[UIFont systemFontOfSize:13]];
        
        self.zaiLab=[UILabel new];
        [self.zaiLab setTextAlignment:NSTextAlignmentLeft];
        [self.zaiLab setFont:[UIFont systemFontOfSize:13]];
        [self.zaiLab setText:@"在"];
        
        self.classLab=[UILabel new];
        [self.classLab setTextAlignment:NSTextAlignmentLeft];
        [self.classLab setTextColor:MainColor];
        [self.classLab setFont:[UIFont systemFontOfSize:13]];
        
        self.searchLab=[UILabel new];
        [self.searchLab setTextAlignment:NSTextAlignmentLeft];
        [self.searchLab setFont:[UIFont systemFontOfSize:13]];
        [self.searchLab setText:@"中搜索"];
        
        [self.contentView addSubview:self.keywordLab];
        [self.contentView addSubview:self.zaiLab];
        [self.contentView addSubview:self.classLab];
        [self.contentView addSubview:self.searchLab];
        
        
        [self.keywordLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.left.equalTo(self.contentView.mas_left).with.offset(8);
        }];
        
        [_zaiLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.left.equalTo(self.keywordLab.mas_right).with.offset(5);
        }];
        
        [self.classLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.left.equalTo(_zaiLab.mas_right).with.offset(5);
        }];
        
        [_searchLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.left.equalTo(self.classLab.mas_right).with.offset(5);
        }];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
