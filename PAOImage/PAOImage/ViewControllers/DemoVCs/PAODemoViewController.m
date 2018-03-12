//
//  PAODemoViewController.m
//  PAOImage
//
//  Created by xsd on 2018/3/6.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import "PAODemoViewController.h"
#import "PAODemoView.h"
#import "PAODemoLeftViewProtocol.h"
//camera
#import "PAOCameraViewController.h"

#import "PAOItemsModel.h"

@interface PAODemoViewController ()
<
    PAODemoLeftViewProtocol,
    PAOCameraVCDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
>

@property (nonatomic, strong) PAODemoView *demoView;
@property (nonatomic, strong) NSMutableArray *imageViewList;
@property (nonatomic, assign) NSInteger selectedImageVCIndex;
@property (nonatomic, strong) UIImagePickerController *imageLibraryVC;

@end

@implementation PAODemoViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectedImageVCIndex = -1;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    [self.view addSubview:self.demoView];
}

#pragma mark - PAOCameraVCDelegate
- (void)cameraGetImage:(UIImage *)image {
    //psd instance
    if (self.selectedImageVCIndex == -1) {
#warning TODO -暂时用imageview直接创建，以后自定义一个可以编辑，并且释放位置的！
        //创建个imageView
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 50, kScreenWidth - 60, kScreenHeight - 50 * 3)];
        imageView.image = image;
        imageView.contentMode = UIViewContentModeScaleToFill;
        [self.demoView  insertImageView:imageView];
        [self.imageViewList addObject:imageView];
        self.selectedImageVCIndex = self.imageViewList.count - 1;
    } else {
        if (self.selectedImageVCIndex >= self.imageViewList.count) {
            NSLog(@"什么鬼！！！越界了");
            return;
        }
        UIImageView *imageView = self.imageViewList[self.selectedImageVCIndex];
        imageView.image = image;
    }
}

#pragma mark - PAODemoLeftViewProtocol
- (void)itemDidSelcted:(PAOItemsModel *)model {
    //做处理！
    [self.demoView missLeftItemView];
    if ([model.itemName isEqualToString:@"摄像机"]) {
        //跳转到相机界面
        PAOCameraViewController *camera = [[PAOCameraViewController alloc] init];
        camera.delegate = self;
        [self.navigationController pushViewController:camera animated:NO];
        
    } else if ([model.itemName isEqualToString:@"相册"]) {
        //跳转到相册
        [self presentViewController:self.imageLibraryVC animated:YES completion:nil];// pushViewController:self.imageLibraryVC animated:YES];
    } else if ([model.itemName isEqualToString:@"滤镜"]) {
        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        if (self.selectedImageVCIndex == -1) {
#warning TODO -暂时用imageview直接创建，以后自定义一个可以编辑，并且释放位置的！
            //创建个imageView
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 50, kScreenWidth - 60, kScreenHeight - 50 * 3)];
            imageView.image = image;
            imageView.contentMode = UIViewContentModeScaleToFill;
            [self.demoView  insertImageView:imageView];
            [self.imageViewList addObject:imageView];
            self.selectedImageVCIndex = self.imageViewList.count - 1;
        } else {
            if (self.selectedImageVCIndex >= self.imageViewList.count) {
                NSLog(@"什么鬼！！！越界了");
                return;
            }
            UIImageView *imageView = self.imageViewList[self.selectedImageVCIndex];
            imageView.image = image;
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - lazy
- (PAODemoView *)demoView {
    if (!_demoView) {
        _demoView = [[PAODemoView alloc] initWithFrame:self.view.frame];
        _demoView.delegate = self;
    }
    return _demoView;
}

- (NSMutableArray *)imageViewList {
    
    if (!_imageViewList) {
        
        _imageViewList = [NSMutableArray array];
    }
    return _imageViewList;
}

- (UIImagePickerController *)imageLibraryVC {
    if (!_imageLibraryVC) {
        _imageLibraryVC = [[UIImagePickerController alloc] init];
        _imageLibraryVC.delegate = self;
        _imageLibraryVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    return _imageLibraryVC;
}
@end
