//
//  HomeLeftView.m
//  JCHProject
//
//  Created by 张浩 on 16/4/12.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "HomeLeftView.h"
@interface HomeLeftView ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)UIView *tabBackView;
@property (nonatomic , strong)UIView *setUpView;
@property (nonatomic , strong)UIView *modelView;

@property (nonatomic , strong)NSMutableArray *dataArr;
@end
static NSString *CellIdentifier = @"TableViewCell";
@implementation HomeLeftView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithTableViewArr:(NSArray *)dataArr{
    self = [super init];
    if (self) {
        self.backgroundColor = RGB(97, 99, 104, 0.5);
        [self addSubview:self.tableView];
        [self addSubview:self.tabBackView];
        [self.tabBackView addSubview:self.setUpView];
        [self.tabBackView addSubview:self.modelView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.bottom.equalTo(self.tabBackView.mas_top);
            make.width.mas_equalTo(SCREEN_WIDTH * 0.65);
        }];
        [self.tabBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCREEN_WIDTH * 0.65);
            make.left.bottom.equalTo(self);
            make.height.equalTo(@44);
        }];
        [self.setUpView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(self.tabBackView);
        }];
        [self.modelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.setUpView.mas_width);
            make.left.equalTo(self.setUpView.mas_right);
            make.right.equalTo(self.tabBackView.mas_right);
            make.top.bottom.equalTo(self.tabBackView);
        }];
        //cell加入缓存池
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
        
        self.dataArr = [[NSMutableArray alloc]initWithArray:dataArr];
    
        //给模糊背景加点击事件
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidenLeftView)];
        click.delegate = self;
        [self addGestureRecognizer:click];
        //给setupView添加点击事件
        self.setUpView.userInteractionEnabled = YES;
        UITapGestureRecognizer *click1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToSetUpViewController)];
        click1.delegate = self;
        [self.setUpView addGestureRecognizer:click1];
        //给modelView添加点击事件
        self.modelView.userInteractionEnabled = YES;
        UITapGestureRecognizer *click2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeDayOrNight)];
        click2.delegate = self;
        [self.modelView addGestureRecognizer:click2];
        
        
    }
    return self;
}
- (void)hidenLeftView{
    [self.delegate hidenHomeLeftView];
}
- (void)pushToSetUpViewController{
    [self.delegate clickHomeLeftViewSetUpView];
}
- (void)changeDayOrNight{
    [self.delegate clickHomeLeftViewModelView];
}
#pragma tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.加载xib
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDictionary *dic = [self.dataArr objectAtIndex:indexPath.row];
    cell.textLabel.text = dic[@"title"];
    
    UIImage *icon = [UIImage imageNamed:dic[@"image"]];
    CGSize itemSize = CGSizeMake(23, 20);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [icon drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate clickHomeLeftViewWithIndex:indexPath.row];
}
//click事件冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CFShow((__bridge CFTypeRef)(self.subviews));
    NSLog(@"%@",NSStringFromClass([touch.view class]));
    if ([touch.view isKindOfClass:[UIView class]]){
        return YES;
    }
//    else if([touch.view isKindOfClass:[PopoverView class]]){
//        return NO;
//    }
    else if([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//!!!!!注意，这个UITableViewCellContentView是固定的，就是代表cell
        return NO;
    }
    return YES;
}

#pragma mark getter and setter
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView setTableFooterView:[[UIView alloc]init]];
    }
    return _tableView;
}
-(UIView *)tabBackView{
    if (_tabBackView == nil) {
        _tabBackView = [[UIView alloc]init];
        _tabBackView.backgroundColor = [UIColor whiteColor];
    }
    return _tabBackView;
}
-(UIView *)setUpView{
    if (_setUpView == nil) {
        _setUpView = [[UIView alloc]init];
        _setUpView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.image = [UIImage imageNamed:@"home_left_sz"];
        [_setUpView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_setUpView.mas_left).offset(8);
            make.height.width.equalTo(@20);
            make.centerY.equalTo(_setUpView.mas_centerY);
        }];
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"设置";
        lab.font = [UIFont systemFontOfSize:12];
        lab.textColor = [UIColor darkGrayColor];
        [_setUpView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.centerY.equalTo(imgView.mas_centerY);
            make.centerX.equalTo(_setUpView.mas_centerX);
        }];
    }
    return _setUpView;
}
-(UIView *)modelView{
    if (_modelView == nil) {
        _modelView = [[UIView alloc]init];
        _modelView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.image = [UIImage imageNamed:@"home_left_ms"];
        [_modelView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_modelView.mas_left).offset(8);
            make.height.width.equalTo(@20);
            make.centerY.equalTo(_modelView.mas_centerY);
        }];

        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"夜间模式";
        lab.font = [UIFont systemFontOfSize:12];
        lab.textColor = [UIColor darkGrayColor];
        [_modelView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.centerY.equalTo(imgView.mas_centerY);
            make.centerX.equalTo(_modelView.mas_centerX);
        }];
    }
    return _modelView;
}
@end
