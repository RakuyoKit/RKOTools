//
//  NSDictionary+Log.m
//  Tools
//
//  Created by Rakuyo on 2017/8/15.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import "CollecionLog.h"

@implementation NSDictionary (Log)

/**
 拼接字符串，解决字典输出中文的时候是unicode编码的问题
 */
- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString string];
    [strM appendString:@"(\r\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [strM appendFormat:@"\t%@ = %@,\r\n", key, obj];
    }];
    
    [strM appendString:@")"];
    return strM.copy;
}

@end

@implementation NSArray (Log)

/**
 拼接字符串，解决数组输出中文的时候是unicode编码的问题
 */
- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString string];
    [strM appendString:@"(\r\n"];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [strM appendFormat:@"\t%@,\r\n",obj];
    }];
    
    [strM appendString:@")"];
    return strM.copy;
}

@end
