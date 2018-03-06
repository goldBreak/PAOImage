//
//  UIView+PAOView.m
//  PAOImage
//
//  Created by xsd on 2018/3/6.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import "UIView+PAOView.h"

@implementation UIView (PAOView)

- (CGFloat)width {
    
    return CGRectGetWidth(self.frame);
}

- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

- (CGFloat)originX {
    return CGRectGetMinX(self.frame);
}

- (CGFloat)originY {
    return CGRectGetMinY(self.frame);
}

- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}

@end
