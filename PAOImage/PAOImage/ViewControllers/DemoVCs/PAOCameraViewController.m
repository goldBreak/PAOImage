//
//  PAOCameraViewController.m
//  PAOImage
//
//  Created by xsd on 2018/3/8.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import "PAOCameraViewController.h"
#import <AVFoundation/AVFoundation.h>

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

@property (nonatomic, strong) AVCaptureVideoDataOutput *captureOutput ;

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
    [_captureSession setSessionPreset:AVCaptureSessionPresetPhoto];
    
    dispatch_queue_t dispatchQueue = dispatch_queue_create("myQueue", NULL);
    
    _captureOutput = [[AVCaptureVideoDataOutput alloc] init];
    _captureOutput.alwaysDiscardsLateVideoFrames = YES;
    
    [_captureOutput setSampleBufferDelegate:self queue:dispatchQueue];
    
    [_captureSession addInput:_backInputDevice];
    [_captureSession addOutput:_captureOutput];
    
    _customerPreLayer = [CALayer layer];
    
    _customerPreLayer.frame = CGRectMake(0, 0, kScreenWidth,kScreenHeight);
    
    [self.view.layer insertSublayer:_customerPreLayer atIndex:0];
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
    frame.origin.y  = 20;
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

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
