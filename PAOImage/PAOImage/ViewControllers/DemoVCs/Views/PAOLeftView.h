//
//  PAOLeftView.h
//  PAOImage
//
//  Created by xsd on 2018/3/8.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import "PAOBaiscView.h"
#import "PAODemoLeftViewProtocol.h"

@interface PAOLeftView : PAOBaiscView

@property (nonatomic, weak) id<PAODemoLeftViewProtocol> delegate;


@end
