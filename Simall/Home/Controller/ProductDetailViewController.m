//
//  ProductDetailViewController.m
//  JCHProject
//
//  Created by 张浩 on 16/4/15.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductDetailChooseViewController.h"
#import "HYBModalTransition.h"

#import "ProductDetailTopView.h"
#import "ProductDetailCenterView.h"
#import "ProductDetailTabView.h"
@interface ProductDetailViewController ()<UIWebViewDelegate,ProductDetailCenterViewDelegate>

@property (nonatomic , strong)UIScrollView *scrollView;
@property (nonatomic , strong)UIView *scrollBackView;
@property (nonatomic , strong)ProductDetailTabView *tabView;

@property (nonatomic , strong)ProductDetailTopView *topBackView;
@property (nonatomic , strong)ProductDetailCenterView *centerBackView;
@property (nonatomic , strong)UIView *bottomBackView;

@property (nonatomic , strong)UIWebView *webView;
@property (nonatomic, strong) HYBModalTransition *transition;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"商品详情";
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.tabView];
    
    [self.scrollView addSubview:self.scrollBackView];
    [self.scrollBackView addSubview:self.topBackView];
    [self.scrollBackView addSubview:self.centerBackView];
    [self.scrollBackView addSubview:self.bottomBackView];
    
    [self.bottomBackView addSubview:self.webView];
    
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@60);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.tabView.mas_top);
    }];
    [self.scrollBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(self.scrollView);
    }];
    [self.topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.scrollBackView);
        //bottom在自定义view设置
    }];
    [self.centerBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scrollBackView);
        make.top.equalTo(self.topBackView.mas_bottom).offset(1);
        //bottom在自定义view设置
    }];
    [self.bottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scrollBackView);
        make.top.equalTo(self.centerBackView.mas_bottom).offset(1);
        make.height.equalTo(@560);///////linshi
    }];
    [self.scrollBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomBackView.mas_bottom).offset(8);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.scrollBackView.mas_bottom);
    }];
    
    UILabel *webTitleLab = [[UILabel alloc]init];
    webTitleLab.text = @"商品简介:";
    webTitleLab.textColor = [UIColor darkGrayColor];
    [self.bottomBackView addSubview:webTitleLab];
    [webTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.bottomBackView);
        make.left.equalTo(self.bottomBackView.mas_left).offset(8);
        make.height.equalTo(@30);
    }];
    
    //临时参数
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.bottomBackView);
    }];
}

#pragma mark delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *str = [NSString stringWithFormat:@"var script = document.createElement('script');"
                     "script.type = 'text/javascript';"
                     "script.text = \"function ResizeImages() { "
                     "var myimg,oldwidth,oldheight;"
                     "var maxwidth=%f;"
                     "for(i=0;i <document.images.length;i++){"
                     "myimg = document.images[i];"
                     "if(myimg.width > maxwidth){"
                     "oldwidth = myimg.width;"
                     "oldheight = myimg.height;"
                     "myimg.width = maxwidth;"
                     "myimg.height = maxwidth * (oldheight/oldwidth);"
                     "}"
                     "}"
                     "}\";"
                     "document.getElementsByTagName('head')[0].appendChild(script);",SCREEN_WIDTH-30];
    [webView stringByEvaluatingJavaScriptFromString:str];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
}

-(void)presentProductDetailChooseView{
    ProductDetailChooseViewController *vc = [[ProductDetailChooseViewController alloc] init];
    
    self.transition = [[HYBModalTransition alloc] initWithPresented:^(UIViewController *presented, UIViewController *presenting, UIViewController *source, HYBBaseTransition *transition) {
        HYBModalTransition *modal = (HYBModalTransition *)transition;
        modal.scale = (CGPoint){0.95, 0.95};
        
        // If you don't specify, it will use default value
        //    modal.presentedHeight = 350.0;
        
        // If you don't want to, set to YES or do no set.
        modal.shouldDismissOnTap = YES;
        
        // Default is NO, if set to YES, it will use spring animation.
        modal.animatedWithSpring = YES;
        
        // Default is YES. including navigation bar when take snapshots.
        // When has navigation bar, if set to NO, it looks not so good.
        //    modal.scapshotIncludingNavigationBar = NO;
    } dismissed:^(UIViewController *dismissed, HYBBaseTransition *transition) {
        // do nothing
        transition.transitionMode = kHYBTransitionDismiss;
    }];
    
    vc.transitioningDelegate = self.transition;
    vc.textField.text = @"1";
    [self presentViewController:vc animated:YES completion:NULL];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark getter and setter
-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}
-(UIView *)scrollBackView{
    if (_scrollBackView == nil) {
        _scrollBackView = [[UIView alloc]init];
        _scrollBackView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _scrollBackView;
}
-(ProductDetailTabView *)tabView{
    if (_tabView == nil) {
        _tabView = [[ProductDetailTabView alloc]initWithShoppingCarCount:@"0"];
        _tabView.backgroundColor = [UIColor whiteColor];
    }
    return _tabView;
}
-(ProductDetailTopView *)topBackView{
    if (_topBackView == nil) {
        _topBackView = [[ProductDetailTopView alloc]initWithTitleImg:@"re1.png" isRecommand:1 titleStr:@"Motivity(动力)M-10线阵音响" infoStr:@"行业产品领导者，销量冠军产品，所有销售产品连起来可绕地球两圈，还多一个中国+一个美国，是不是很多!?"];
        _topBackView.backgroundColor = [UIColor whiteColor];
    }
    return _topBackView;
}
-(ProductDetailCenterView *)centerBackView{
    if (_centerBackView == nil) {
        NSDictionary *dic1 = @{@"title":@"价格",@"info":@"￥1200.00"};
        NSDictionary *dic2 = @{@"title":@"是否报备",@"info":@"是"};
        NSDictionary *dic3 = @{@"title":@"品牌",@"info":@"Motivity(动力)"};
        NSDictionary *dic4 = @{@"title":@"型号",@"info":@"M-10"};
        NSDictionary *dic5 = @{@"title":@"单元尺寸",@"info":@"2*10低频驱动器;2*3高频驱动器,1.5高频波导号角"};
        NSDictionary *dic6 = @{@"title":@"频率响应",@"info":@"65Hz-18Hz"};
        NSDictionary *dic7 = @{@"title":@"功率/阻抗",@"info":@"700W/4Ω"};
        NSDictionary *dic8 = @{@"title":@"灵敏度/对大声压级",@"info":@"107dB/135dB"};
        NSDictionary *dic9 = @{@"title":@"音响尺寸",@"info":@"H305mm(344mm)*W748mm*D454mm"};
        NSArray *arr = @[dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8,dic9];
        _centerBackView = [[ProductDetailCenterView alloc]initWithLabDicArr:arr];
        _centerBackView.backgroundColor = [UIColor whiteColor];
        _centerBackView.delegate = self;
    }
    return _centerBackView;
}
-(UIView *)bottomBackView{
    if (_bottomBackView == nil) {
        _bottomBackView = [[UIView alloc]init];
        _bottomBackView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomBackView;
}
-(UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc]init];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
    }
    return _webView;
}
@end
