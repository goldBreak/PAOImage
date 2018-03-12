//
//  PAODemoView.h
//  PAOImage
//
//  Created by xsd on 2018/3/8.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import "PAOBaiscView.h"


@interface PAODemoView : PAOBaiscView

@property (nonatomic, weak) id delegate;

- (void)missLeftItemView;

- (void)insertImageView:(UIImageView *)imageView;

@end
