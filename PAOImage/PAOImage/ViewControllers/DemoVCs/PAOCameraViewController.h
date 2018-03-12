//
//  PAOCameraViewController.h
//  PAOImage
//
//  Created by xsd on 2018/3/8.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import "PAOBasicViewController.h"
@protocol PAOCameraVCDelegate

- (void)cameraGetImage:(UIImage *)image;

@end

@interface PAOCameraViewController : PAOBasicViewController

@property (nonatomic, weak) id<PAOCameraVCDelegate> delegate;

@end
