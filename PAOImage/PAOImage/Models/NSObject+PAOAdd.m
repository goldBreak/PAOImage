//
//  NSObject+PAOAdd.m
//  PAOImage
//
//  Created by xsd on 2018/3/7.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import "NSObject+PAOAdd.h"

@implementation NSObject (PAOAdd)

+ (NSDictionary *)dictWithData:(id)jsonData {
    
    if (!jsonData || jsonData == (id)kCFNull) {
        return nil;
    }
    
    NSDictionary *dict = nil;
    NSData *realJsonData = nil;
    
    if ([jsonData isKindOfClass:[NSDictionary class]]) {
        dict = jsonData;
    } else if ([jsonData isKindOfClass:[NSString class]]) {
        realJsonData = [(NSString *)jsonData dataUsingEncoding:NSUTF8StringEncoding];
    } else if ([jsonData isKindOfClass:[NSData class]]) {
        realJsonData = jsonData;
    }
    
    if (jsonData) {
        dict = [NSJSONSerialization JSONObjectWithData:realJsonData options:NSJSONReadingAllowFragments error:NULL];
        if (![dict isKindOfClass:[NSDictionary class]]) {
            dict = nil;
        }
    }
    return dict;
}

+ (instancetype)modelInJson:(id)jsonData {
    
    NSDictionary *dict = [self dictWithData:jsonData];
    
    return nil;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    if (!dict || ![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
//    Class cls = [self class];
    
    return nil;
}

@end
