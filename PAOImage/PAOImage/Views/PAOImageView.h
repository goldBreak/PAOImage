//
//  PAOImageView.h
//  test
//
//  Created by xsd on 2018/3/21.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PAOImageView : UIView


@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) NSInteger pix;

- (instancetype)initWithImage:(UIImage *)image;



@end
