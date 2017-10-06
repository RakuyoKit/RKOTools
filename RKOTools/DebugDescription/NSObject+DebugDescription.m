//
//  NSObject+DebugDescription.m
//  DebugDescription
//
//  Created by Rakuyo on 2017/10/6.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import "NSObject+DebugDescription.h"
#import <objc/runtime.h>

@implementation NSObject (DebugDescription)

- (NSString *)debugDescription {
    if ([self isKindOfClass:[NSArray class]]
        || [self isKindOfClass:[NSDictionary class]]
        || [self isKindOfClass:[NSNumber class]]
        || [self isKindOfClass:[NSString class]]
        || [self isKindOfClass:[NSError class]]
        || [self isKindOfClass:[NSURL class]]
        || [self isKindOfClass:[UIApplication class]]) {
        return self.debugDescription;
    }
    
    // 初始化一个字典
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    // 得到当前 Class 的所有属性
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class],  &count);
    
    // 利用KVC获取属性值
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        
        // 设置一个默认值。
        id value = [self valueForKey:name]?:@"nil";
        
        [dic setObject:value forKey:name];
    }
    
    free(properties);
    
    return [NSString stringWithFormat:@"<%@: %p> -- %@", [self class], self, dic];
}

@end

