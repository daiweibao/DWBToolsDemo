//
//  ScanViewController.m
//  ZQScanViewController
//
//  Created by 肖兆强 on 2018/1/26.
//  Copyright © 2018年 JWZT. All rights reserved.
//

//屏幕宽度、高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h> //声音提示

#define AUTH_ALERT_TAG (int)281821

@interface ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate,CAAnimationDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CAAnimationDelegate>
{
    AVCaptureSession * session;//输入输出的中间桥梁
    int line_tag;
    UIView *highlightView;
}
@end

@implementation ScanViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;

}

-(void)dealloc{
    NSLog(@"二维码扫码控制器走了dealloc");
    //只能放在这里移除
     [session removeObserver:self forKeyPath:@"running" context:nil];
}

/**
 *
 *  viewDidLoad
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self instanceDevice];
}

/**
 *
 *  配置相机属性
 */
- (void)instanceDevice{
    
    line_tag = 1872637;
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    if (input) {
        [session addInput:input];
    }
    if (output) {
        [session addOutput:output];
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        NSMutableArray *a = [[NSMutableArray alloc] init];
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
            [a addObject:AVMetadataObjectTypeQRCode];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN13Code]) {
            [a addObject:AVMetadataObjectTypeEAN13Code];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN8Code]) {
            [a addObject:AVMetadataObjectTypeEAN8Code];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode128Code]) {
            [a addObject:AVMetadataObjectTypeCode128Code];
        }
        output.metadataObjectTypes=a;
    }
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    
    [self setOverlayPickerView];
    
    [session addObserver:self forKeyPath:@"running" options:NSKeyValueObservingOptionNew context:nil];
    
    //开始捕获
    [session startRunning];
}

/**
 *
 *  监听扫码状态-修改扫描动画
 *
 */
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    if ([object isKindOfClass:[AVCaptureSession class]]) {
        BOOL isRunning = ((AVCaptureSession *)object).isRunning;
        if (isRunning) {
            [self addAnimation];
        }else{
            [self removeAnimation];
        }
    }
}

/**
 *
 *  获取扫码结果
 */
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        [session stopRunning];
//        NSURL *url=[[NSBundle mainBundle]URLForResource:@"scanSuccess.wav" withExtension:nil];
//            //2.加载音效文件，创建音效ID（SoundID,一个ID对应一个音效文件）
//             SystemSoundID soundID=8787;
//             AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
//             //3.播放音效文件
//             //下面的两个函数都可以用来播放音效文件，第一个函数伴随有震动效果
//             AudioServicesPlayAlertSound(soundID);
//
//        AudioServicesPlaySystemSound(8787);
        
        //播放扫描音效
        [self playAudio];

        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex :0];
        
        //输出扫描字符串
        NSString *dataStr = metadataObject.stringValue;
//        ScanResultViewController *resultVC = [[ScanResultViewController alloc] init];
//        resultVC.title = @"扫描结果";
//        resultVC.result = data;
//        [self.navigationController pushViewController:resultVC animated:YES];
        
        NSLog(@"二维码扫描结果：%@",dataStr);
        
//        [AlertCXView AlertCXAlertCenterAllWithController:self Title:@"扫描结果" Message:dataStr otherItemArrays:@[@"知道啦"] Type:-1 handler:^(NSInteger index) {
//
//
//        }];
        
    }
}


//播放扫描音效
-(void)playAudio{
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"scanSuccess.wav" withExtension:nil];
    //2.加载音效文件，创建音效ID（SoundID,一个ID对应一个音效文件）
    SystemSoundID soundID=8787;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    //3.播放音效文件
    //下面的两个函数都可以用来播放音效文件，第一个函数伴随有震动效果
    AudioServicesPlayAlertSound(soundID);
    
    AudioServicesPlaySystemSound(8787);
}




/**
 *
 *  创建扫码页面
 */
- (void)setOverlayPickerView
{
    //左侧的view
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, ScreenHeight)];
    leftView.alpha = 0.5;
    leftView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:leftView];
    //右侧的view
    UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-30, 0, 30, ScreenHeight)];
    rightView.alpha = 0.5;
    rightView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:rightView];
    
    //最上部view
    UIImageView* upView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, ScreenWidth - 60, (self.view.center.y-(ScreenWidth-60)/2))];
    upView.alpha = 0.5;
    upView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:upView];
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 20, 44, 44)];
    [cancleBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancleBtn];
    
    //相册按钮
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-44, 20, 44, 44)];
    [rightBtn setTitle:@"相册" forState:UIControlStateNormal];
    [rightBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
    
    
    
    //底部view
    UIImageView * downView = [[UIImageView alloc] initWithFrame:CGRectMake(30, (self.view.center.y+(ScreenWidth-60)/2), (ScreenWidth-60), (ScreenHeight-(self.view.center.y-(ScreenWidth-60)/2)))];
    downView.alpha = 0.5;
    downView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:downView];
    
    UIImageView *centerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-60, ScreenHeight-60)];
    centerView.center = self.view.center;
    centerView.image = [UIImage imageNamed:@"scan_circle"];
    centerView.contentMode = UIViewContentModeScaleAspectFit;
    centerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:centerView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(upView.frame), ScreenWidth-60, 2)];
    line.tag = line_tag;
    line.image = [UIImage imageNamed:@"scan_line"];
    line.contentMode = UIViewContentModeScaleAspectFill;
    line.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line];
    
    UILabel *msg = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMinY(downView.frame), ScreenWidth-60, 60)];
    msg.backgroundColor = [UIColor clearColor];
    msg.textColor = [UIColor whiteColor];
    msg.textAlignment = NSTextAlignmentCenter;
    msg.font = [UIFont systemFontOfSize:16];
    msg.text = @"将二维码放入框内,即可自动扫描";
    [self.view addSubview:msg];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenHeight-100, ScreenWidth, 100)];
//    label.backgroundColor = [UIColor clearColor];
//    label.textColor = [UIColor whiteColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = [UIFont systemFontOfSize:15];
//    label.text = @"";
//    [self.view addSubview:label];
    
    
    
    
    
    
    
}

/**
 *
 *  添加扫码动画
 */
- (void)addAnimation{
    UIView *line = [self.view viewWithTag:line_tag];
    line.hidden = NO;
    CABasicAnimation *animation = [ScanViewController moveYTime:2 fromY:[NSNumber numberWithFloat:0] toY:[NSNumber numberWithFloat:ScreenWidth-60-2] rep:OPEN_MAX];
    [line.layer addAnimation:animation forKey:@"LineAnimation"];
}

+ (CABasicAnimation *)moveYTime:(float)time fromY:(NSNumber *)fromY toY:(NSNumber *)toY rep:(int)rep
{
    CABasicAnimation *animationMove = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    [animationMove setFromValue:fromY];
    [animationMove setToValue:toY];
    animationMove.duration = time;
    animationMove.delegate = self;
    animationMove.repeatCount  = rep;
    animationMove.fillMode = kCAFillModeForwards;
    animationMove.removedOnCompletion = NO;
    animationMove.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return animationMove;
}


/**
 *  @author Whde
 *
 *  去除扫码动画
 */
- (void)removeAnimation{
    UIView *line = [self.view viewWithTag:line_tag];
    [line.layer removeAnimationForKey:@"LineAnimation"];
    line.hidden = YES;
}

- (void)cancleBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark ============== 从相册扫描二维码 S=============
-(void)rightBtnClick{
    //停止二维码扫描
    [session stopRunning];
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = true;
    [self presentViewController:picker animated:true completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    //再次开始捕获
    [session startRunning];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image){
        image = info[UIImagePickerControllerOriginalImage];
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        //注意相册二维码扫描不能加断点，否则会卡住
        NSString * resuls =  [self scanCodeContent:image];
        NSLog(@"照片二维码结果：%@",resuls);
        //播放扫描音效
        [self playAudio];

//        [AlertCXView AlertCXAlertCenterAllWithController:self Title:@"照片扫描结果" Message:resuls otherItemArrays:@[@"知道啦"]  Type:-1 handler:^(NSInteger index) {
//            if (index==0) {
//                //再次开始捕获
//                [session startRunning];
//            }
//            
//        }];
    }];
}


/**
 相册二维码识别类

 @param image 照片
 @return 二维码结果
 */
-(NSString*)scanCodeContent:(UIImage*)image
{
    NSData *imageData = UIImagePNGRepresentation(image);
    CIImage *ciImage = [CIImage imageWithData:imageData];
    
    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(false), kCIContextPriorityRequestLow : @(false)}];
    //创建探测器
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    //注意相册二维码扫描不能加断点，否则会卡住在这里
    NSArray *features = [detector featuresInImage:ciImage];
    CIQRCodeFeature *feature = [features firstObject];
    //   CIQRCodeFeature (二维码识别)
    //    除基本的信息位置之外，只有一个重要信息，messageString。
    return feature.messageString.length ? feature.messageString : @"未识别!";
}

#pragma mark ============== 从相册扫描二维码 E=============

@end
