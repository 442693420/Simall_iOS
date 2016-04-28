//
//  ScanViewController.m
//  JCHProject
//
//  Created by 张浩 on 16/4/14.
//  Copyright © 2016年 张浩. All rights reserved.
//

#import "ScanViewController.h"

@interface ScanViewController ()

@end

@implementation ScanViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor blackColor];
    [self.navigationController.navigationBar setHidden:NO];
    self.title = @"扫一扫";
    
    //返回按钮
    UIButton* leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,60,30)];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    //    [leftButton setImage:[UIImage imageNamed:@"arrow_white_left.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem= leftItem;

    
    //    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    [scanButton setTitle:@"取消" forState:UIControlStateNormal];
    //    [scanButton setBackgroundColor:[UIColor colorWithRed:0.147 green:0.713 blue:0.551 alpha:1.000]];
    //    [scanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    scanButton.frame = CGRectMake((self.view.frame.size.width-120)/2, 420, 120, 40);
    //    [scanButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:scanButton];
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(20, 360, SCREEN_WIDTH-40, 50)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    [labIntroudction setTextAlignment:NSTextAlignmentCenter];
    [labIntroudction setFont:[UIFont systemFontOfSize:13]];
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"将二维码、条码图像置于矩形方框内可自动识别";
    [self.view addSubview:labIntroudction];
    
    //    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 300, 300)];
    //    imageView.image = [UIImage imageNamed:@"pick_bg"];
    //    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(30,100,self.view.bounds.size.width-60,2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    MaskLayerView *newView = [[MaskLayerView alloc]initWithFrame:self.view.bounds];
    [newView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:newView];
    [self.view setNeedsDisplay];
    [self.view drawRect:self.view.bounds];
    
}

-(IBAction)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(30, 100+2*num, self.view.bounds.size.width-60, 2);
        if (2*num == self.view.bounds.size.width-60) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(30, 100+2*num, self.view.bounds.size.width-60, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}

-(void)backAction
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        [timer invalidate];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setupCamera];
}
- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,nil];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = self.view.bounds;//CGRectMake(20,50,SCREEN_WIDTH-40,SCREEN_WIDTH-40);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    // Start
    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    [self dismissViewControllerAnimated:YES completion:^
     {
         [timer invalidate];
         NSLog(@"%@",stringValue);
         self.scanResult(stringValue);
     }];
}
-(void)backClick{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end

@implementation MaskLayerView

- (void)drawRect:(CGRect)rect
{
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(con, [UIColor colorWithWhite:0 alpha:0.6].CGColor);
    
    CGContextFillRect(con, rect);
    
    CGContextClearRect(con, CGRectMake(30,100,rect.size.width-60,rect.size.width-60));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
