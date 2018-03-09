//
//  PAOFilterModel.h
//  PAOImage
//
//  Created by xsd on 2018/3/7.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef NS_ENUM(NSUInteger, PAOFilterType) {
    PAOFilterType_blur = 0,
    PAOFilterType_colorChange,
    PAOFilterType_imageCompound,
};

typedef NS_ENUM(NSUInteger, PAOBlurType) {
    PAOBlurType_box = PAOFilterType_imageCompound + 1,  /*均值模糊*/
    PAOBlurType_gauess,             /*高斯模糊*/
    PAOBlurType_disc,               /*圈内模糊*/
    PAOBlurType_maskImage,          /*浮层图片模糊*/
    PAOBlurType_median,             /*median模糊*/
    PAOBlurType_motion,             /*动态模糊*/
    PAOBlurType_noiseReduction,     /*噪音模糊*/
    PAOBlurType_zoom,               /*快速移动带来的模糊*/
    
    PAOBlurType_last,
};


typedef NS_ENUM(NSUInteger, PAOColorType) {
    PAOColorType_clamp = PAOBlurType_last + 1,
    
    PAOColorType_last,
};

typedef NS_ENUM(NSUInteger, PAOImageType) {
    PAOImageType_addition = PAOColorType_last,
    
};

@interface PAOFilterModel : NSObject<NSCopying>

@property (nonatomic, assign) PAOFilterType filterType;

//精确的模型，根据这个判断到底是什么算法
@property (nonatomic, assign) int           elaborateType;

@property (nonatomic, copy)   NSString      *filterName;

@end
