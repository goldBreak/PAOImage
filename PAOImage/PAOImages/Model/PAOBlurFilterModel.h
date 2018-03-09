//
//  PAOBlurFilterModel.h
//  PAOImage
//
//  Created by xsd on 2018/3/7.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import "PAOFilterModel.h"

@interface PAOBlurFilterModel : PAOFilterModel

//动态模糊需要模糊角度
@property (nonatomic, assign) CGFloat angle;

//模糊程度
@property (nonatomic, assign) CGFloat blurLevel;

//模糊用的浮层图片
@property (nonatomic, strong) UIImage *maskImage;



//扩展字段，目前没有用到这个字段
@property (nonatomic) id externData;

@end
