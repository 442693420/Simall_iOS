//
//  HomeOneTableViewCell.m
//  JCHProject
//
//  Created by 张浩 on 16/4/12.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "HomeOneTableViewCell.h"
@interface HomeOneTableViewCell ()

@end

@implementation HomeOneTableViewCell

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
- (void)showView{
    [self addSubview:self.oneView];
    [self addSubview:self.twoView];
    
    [self.oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH / 2 - 0.5);
    }];
    [self.twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH / 2 - 0.5);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
