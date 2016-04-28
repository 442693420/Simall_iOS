//
//  JCWebViewController.m
//  JCHProject
//
//  Created by 张浩 on 16/4/14.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "JCWebViewController.h"

@interface JCWebViewController ()<UIWebViewDelegate>
@property (nonatomic , strong)UIWebView *webView;
@end

@implementation JCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"智慧集城";
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    NSString *urlStr = @"http://simall.com.cn/htm/login.htm";
    NSLog(@"%@",urlStr);
    NSURL *url = [NSURL URLWithString:urlStr];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}
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
-(UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc]init];
    }
    return _webView;
}
@end
