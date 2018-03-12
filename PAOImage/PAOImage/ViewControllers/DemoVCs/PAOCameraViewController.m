//
//  PAOCameraViewController.m
//  PAOImage
//
//  Created by xsd on 2018/3/8.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import "PAOCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PAOCameraViewController ()
<
AVCaptureVideoDataOutputSampleBufferDelegate
>


@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) AVCaptureDevice *backCaptionDive;
@property (nonatomic, strong) AVCaptureDevice *frontCaptionDive;
@property (nonatomic, strong) AVCaptureDevice *captionDive;

@property (nonatomic, strong) AVCaptureDeviceInput *backInputDevice;
@property (nonatomic, strong) AVCaptureDeviceInput *frontInputDevice;

@property (nonatomic, strong) CALayer *customerPreLayer;
//@property (nonatomic, strong) AVCaptureVideoDataOutput *captureOutput ;
@property (nonatomic, strong) AVCaptureStillImageOutput *captureOutput;
@property (nonatomic, assign) BOOL isReady;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL isBackCamrea;
@end

@implementation PAOCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    _isReady = YES;
    self.selected = NO;
    self.isBackCamrea = YES;
    
    [self initToolBar];
    [self initControl];
}


- (void)initControl {
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    NSError *error;
    for (AVCaptureDevice *device in devices) {
        if (device.position == AVCaptureDevicePositionBack) {
            _backCaptionDive = device;
            _backInputDevice = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        }
        if (device.position == AVCaptureDevicePositionFront) {
            _frontCaptionDive = device;
            _frontInputDevice = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        }
    }
    _captionDive = _frontCaptionDive;
    
    if (!_backInputDevice) {
        _isReady = NO;
        return;
    }
    
    _captureSession         = [[AVCaptureSession alloc] init];
    [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    
    _captureOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [_captureOutput setOutputSettings:outputSettings];
    
    [_captureSession addInput:_backInputDevice];
    [_captureSession addOutput:_captureOutput];

    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    [self.videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
    self.videoPreviewLayer.frame = CGRectMake(0, 0, kScreenWidth,kScreenHeight);
    [self.view.layer insertSublayer:self.videoPreviewLayer atIndex:0];
}

#pragma mark - local
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.captureSession) {
        [self.captureSession stopRunning];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_isReady) {
        return;
    }
    
    if (self.captureSession) {
        [self.captureSession startRunning];
    }
}

- (void)initToolBar {
    UIImage *flashImage = [UIImage imageNamed:@"flashlight"];
    UIImage *backImage = [UIImage imageNamed:@"whiteback"];
    
    CGRect frame    = self.navigationController.navigationBar.frame;
    frame.origin.y  = MAX([[UIApplication sharedApplication] statusBarFrame].size.height - 8, 20.);
    UILabel *titleLalbe = [[UILabel alloc] initWithFrame:frame];
    
    
    CGSize size = backImage.size;
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBack.frame = CGRectMake(15, 0, size.width, size.height);
    [buttonBack setBackgroundImage:backImage forState:UIControlStateNormal];
    
    buttonBack.center = CGPointMake(buttonBack.center.x, titleLalbe.center.y);
    [buttonBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBack];
    
    size = flashImage.size;
    UIButton *flashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    frame = CGRectZero;
    frame.size = size;
    frame.origin.x = kScreenWidth - 15 - frame.size.width;
    flashBtn.frame = frame;
    [flashBtn setBackgroundImage:flashImage forState:UIControlStateNormal];
    [flashBtn addTarget:self action:@selector(lightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    flashBtn.center = CGPointMake(flashBtn.center.x, titleLalbe.center.y);
    [self.view addSubview:flashBtn];// addSubview:flashBtn];
    
    UIImage *img = [UIImage imageNamed:@"camera_nomal"];
    UIButton *switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    switchBtn.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    [switchBtn setBackgroundImage:img forState:UIControlStateNormal];
    switchBtn.center = CGPointMake(titleLalbe.center.x, titleLalbe.center.y);
    [switchBtn addTarget:self action:@selector(switchCameraBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:switchBtn];
    
    UIImage *takePhoto = [UIImage imageNamed:@"cameraIcon"];
    UIButton *takePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    takePhotoBtn.frame = CGRectMake(0, 0, takePhoto.size.width, takePhoto.size.height);
    [takePhotoBtn setImage:takePhoto forState:UIControlStateNormal];
    [takePhotoBtn addTarget:self action:@selector(takePhotoBtnPressDown:) forControlEvents:UIControlEventTouchUpInside];
    takePhotoBtn.center = CGPointMake(kScreenWidth / 2.0, kScreenHeight - takePhotoBtn.bounds.size.height - 30.);
    [self.view addSubview:takePhotoBtn];
}

// 前后摄像头切换
- (void)switchCameraBtn:(UIButton *)button {
    
    self.isBackCamrea = !self.isBackCamrea;
    
    if (self.isBackCamrea) {
        
        [self.captureSession beginConfiguration];
        [self.captureSession removeInput:_frontInputDevice];
        [self.captureSession addInput:_backInputDevice];
        [self.captureSession commitConfiguration];
        
        _captionDive = _backCaptionDive;
        
    }else {
        [self.captureSession beginConfiguration];
        [self.captureSession removeInput:_backInputDevice];
        [self.captureSession addInput:_frontInputDevice];
        [self.captureSession commitConfiguration];
        
        _captionDive = _frontCaptionDive;
    }
    
}

- (void)lightBtnAction:(UIButton *)Btn {
    //普通开关模式
    self.selected = !self.selected;
    if(self.selected)
    {
        //打开闪光灯
        if([self.captionDive hasTorch] && [self.captionDive hasFlash])
        {
            if(self.captionDive.torchMode == AVCaptureTorchModeOff)
            {
                [self.captureSession beginConfiguration];
                [self.captionDive lockForConfiguration:nil];
                [self.captionDive setTorchMode:AVCaptureTorchModeOn];
                [self.captionDive setFlashMode:AVCaptureFlashModeOn];
                [self.captionDive unlockForConfiguration];
                [self.captureSession commitConfiguration];
            }
        }
    }
    else
    {
        //关闭闪光灯
        [self.captureSession beginConfiguration];
        [self.captionDive lockForConfiguration:nil];
        if(self.captionDive.torchMode == AVCaptureTorchModeOn)
        {
            [self.captionDive setTorchMode:AVCaptureTorchModeOff];
            [self.captionDive setFlashMode:AVCaptureFlashModeOff];
        }
        [self.captionDive unlockForConfiguration];
        [self.captureSession commitConfiguration];
    }
    
}


- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)takePhotoBtnPressDown:(UIButton *)button {
    
    //输出图像的时候需要用到AVCaptureConnection这个类，session通过AVCaptureConnection连接AVCaptureStillImageOutput进行图片输出，
    
    AVCaptureConnection *stillImageConnection = [self.captureOutput connectionWithMediaType:AVMediaTypeVideo];

    UIDeviceOrientation curDeviceOrientation = [[UIDevice currentDevice] orientation];

    AVCaptureVideoOrientation avcaptureOrientation = [self avOrientationForDeviceOrientation:curDeviceOrientation];

    [stillImageConnection setVideoOrientation:avcaptureOrientation];

    //这个方法是控制焦距用的暂时先固定为1，后边写手势缩放焦距的时候会修改这里
    AVCaptureConnection *myVideoConnection = nil;
    
    //从 AVCaptureStillImageOutput 中取得正确类型的 AVCaptureConnection
    for (AVCaptureConnection *connection in self.captureOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                
                myVideoConnection = connection;
                break;
            }
        }
    }
    [self.captureOutput captureStillImageAsynchronouslyFromConnection:myVideoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        if (self.delegate && imageData ) {
            [self.delegate cameraGetImage:[UIImage imageWithData:imageData]];
            [self.navigationController popViewControllerAnimated:NO];
        }

    }];
    
}



//设置方向,       照片写入相册之前需要进行旋转

-(AVCaptureVideoOrientation )avOrientationForDeviceOrientation:(UIDeviceOrientation)deviceOrientation

{
    
    AVCaptureVideoOrientation result = (AVCaptureVideoOrientation)deviceOrientation;
    
    if ( deviceOrientation ==UIDeviceOrientationLandscapeLeft ) {
        
        result = AVCaptureVideoOrientationLandscapeRight;
    } else if ( deviceOrientation == UIDeviceOrientationLandscapeRight ) {
    
        result = AVCaptureVideoOrientationLandscapeLeft;
    }
    
    return result;
}

@end
