//
//  HomeProductRecommendTableViewCell.m
//  Simall
//
//  Created by 张浩 on 16/4/26.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "HomeProductRecommendTableViewCell.h"
@interface HomeProductRecommendTableViewCell()<HomeProductRecommendViewDelegate>
@property (nonatomic , strong)UIView *backView;
@end
@implementation HomeProductRecommendTableViewCell

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
    [self addSubview:self.backView];
    
    UIView *lastView;
    for (int i = 0; i < self.dataArr.count; i++) {
        int lie = i%2;
        NSDictionary *dic = [self.dataArr objectAtIndex:i];
        NSString *imgStr = [PublicObject convertNullString:[dic objectForKey:@"imgFilePath"]];
        NSString *isShowPrice = [NSString stringWithFormat:@"%@",[PublicObject convertNullNumber:[dic objectForKey:@"reportFlag"]]];
        NSString *priceStr;
        if ([isShowPrice isEqualToString:@"1"]) {
            priceStr = @"电联(400-158-8180)";
        }else{
            priceStr = [NSString stringWithFormat:@"￥%@",[PublicObject convertNullNumber:[dic objectForKey:@"stockPrice"]]];
        }
        NSString *infoStr = [NSString stringWithFormat:@"%@ %@",[PublicObject convertNullString:[dic objectForKey:@"brand"]],[PublicObject convertNullString:[dic objectForKey:@"model"]]];
        HomeProductRecommendView *recommendView = [[HomeProductRecommendView alloc]initWithImgStr:imgStr priceStr:priceStr infoStr:infoStr andTag:i];
        recommendView.delegate = self;
        [self.backView addSubview:recommendView];
        [recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastView) {
                if (lie == 0) {
                    make.top.mas_equalTo(lastView.mas_bottom);
                    make.left.mas_equalTo(0);
                }else{
                    make.top.mas_equalTo(lastView.mas_top);
                    make.left.mas_equalTo(lastView.mas_right);
                }
            }else{
                make.top.left.mas_equalTo(0);
            }
            make.width.mas_equalTo((SCREEN_WIDTH - 16)/2);
            make.height.mas_equalTo((SCREEN_WIDTH - 16)/2+30);
            
        }];
        lastView = recommendView;
    }
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.mas_left).offset(8);
        make.right.equalTo(self.mas_right).offset(-8);
        make.bottom.equalTo(lastView.mas_bottom);
    }];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)homeRecommendViewClickWithBtnTag:(NSInteger)btnTag{
    [self.delegate clickHomeProductRecommendTableViewCellWithIndex:btnTag];
}
#pragma  mark getter and setter
-(UIView *)backView{
    if(_backView == nil){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

@end
