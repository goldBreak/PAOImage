//
//  PAOFilterModel.m
//  PAOImage
//
//  Created by xsd on 2018/3/7.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import "PAOFilterModel.h"

@implementation PAOFilterModel

- (id)copyWithZone:(NSZone *)zone {
    return [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];
}

@end
