//
//  MenuView.m
//  Simall
//
//  Created by 张浩 on 16/4/27.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "MenuView.h"
@interface MenuView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)NSMutableArray *dataArr;
@property (nonatomic , strong)UITableView *tableView;
@end

static NSString *cellIdentifier = @"TableViewCell";
@implementation MenuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithDataSource:(NSArray *)dataArr{
    self = [super init];
    if (self) {
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
        self.dataArr = [[NSMutableArray alloc]initWithArray:dataArr];
        //cell加入缓存池
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];

    }
    return self;
}


#pragma tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    cell.delegate = self;
    cell.textLabel.text = [self.dataArr objectAtIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate menuViewClickWithIndex:indexPath.row tag:self.tag];
}
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
}
@end
