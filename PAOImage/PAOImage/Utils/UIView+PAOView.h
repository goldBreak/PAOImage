//
//  UIView+PAOView.h
//  PAOImage
//
//  Created by xsd on 2018/3/6.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (PAOView)

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat originX;
@property (nonatomic) CGFloat originY;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGSize  size;


- (CGFloat)maxX;
- (CGFloat)maxY;

@end
