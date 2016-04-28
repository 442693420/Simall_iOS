//
//  StoreClassCollectionViewCell.m
//  MushroomCloud
//
//  Created by konghui on 15/9/14.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import "StoreClassCollectionViewCell.h"

@implementation StoreClassCollectionViewCell
@synthesize classImageView;
@synthesize classLabel;

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		//图标
		UIImageView *classImageV = UIImageView.new;
        [classImageV setImage:[UIImage imageNamed:@"attention"]];
		[self addSubview:classImageV];
		self.classImageView = classImageV;
		
		//类名
		UILabel *classLab = UILabel.new;
		[classLab setFont:[UIFont systemFontOfSize:13]];
		[classLab setTextColor:RGB(118,118,118, 1)];
		classLab.textAlignment = NSTextAlignmentCenter;
		[classLab setText:@"果蔬专区"];
		[self addSubview:classLab];
		self.classLabel = classLab;
		
		[self.classImageView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(self.mas_left).mas_offset(5);
			make.right.equalTo(self.mas_right).mas_offset(-5);
			make.top.equalTo(self.mas_top).mas_offset(5);
            make.height.width.mas_equalTo(frame.size.width-10);
		}];

		[self.classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(self.mas_left).mas_offset(5);
			make.right.equalTo(self.mas_right).mas_offset(-5);
			make.top.equalTo(self.classImageView.mas_bottom).with.offset(5);
			make.bottom.equalTo(self.mas_bottom).with.offset(-5);
			make.height.equalTo(@15);
		}];
	}
	return self;
}

@end
