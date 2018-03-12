//
//  PAODemoLeftViewProtocol.h
//  PAOImage
//
//  Created by xsd on 2018/3/12.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PAOItemsModel;

@protocol PAODemoLeftViewProtocol <NSObject>

- (void)itemDidSelcted:(PAOItemsModel *)model;

@end
