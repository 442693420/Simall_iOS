//
//  StoreClassTableViewCell.m
//  MushroomCloud
//
//  Created by konghui on 15/9/9.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import "StoreClassTableViewCell.h"

@implementation StoreClassTableViewCell
@synthesize classLabel;

- (void)awakeFromNib {
    // Initialization code
//	//名字label
//	UILabel *classLab = [[UILabel alloc]init];
//	[classLab setFont:[UIFont systemFontOfSize:14]];
//	[classLab setTextColor:RGB(50, 50, 50, 1.0)];
//	classLab.textAlignment = NSTextAlignmentLeft;
//	[self addSubview:classLab];
//	self.classLabel = classLab;
//	[self.classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.equalTo(self.left).with.offset(@20);
//		make.top.equalTo(self.top).with.offset(@10);
//	}];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
