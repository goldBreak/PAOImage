//
//  PAOImageHandle.h
//  PAOImage
//
//  Created by xsd on 2018/3/7.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAOFilterModel.h"

@interface PAOImageHandle : NSObject

- (void)applyImage:(UIImage *)inputImage model:(PAOFilterModel *)model block:(void (^)(UIImage *outImage))blcok;

@end
