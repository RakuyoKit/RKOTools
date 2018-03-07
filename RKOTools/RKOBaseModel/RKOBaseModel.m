//
//  RKOBaseModel.m
//  RKOTools
//
//  Created by Rakuyo on 2018/1/17.
//  Copyright © 2018年 Rakuyo. All rights reserved.
//

#import "RKOBaseModel.h"

@implementation RKOBaseModel

+ (instancetype)model {
    return [[self alloc] init];
}

- (NSString *)description {
    unsigned int count;
    const char *clasName = object_getClassName(self);
    
    NSMutableString *string = [NSMutableString stringWithFormat:@"<%s: %p>:[ \n",clasName, self];
    
    Class clas = NSClassFromString([NSString stringWithCString:clasName encoding:NSUTF8StringEncoding]);
    Ivar *ivars = class_copyIvarList(clas, &count);
    
    for (int i = 0; i < count; i++) {
        @autoreleasepool {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            
            // 得到类型
            NSString *type = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
            NSString *key = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            id value = [self valueForKey:key];
            
            // 确保BOOL 值输出的是YES 或 NO。
            if ([type isEqualToString:@"B"]) {
                value = (value == 0 ? @"NO" : @"YES");
            }
            [string appendFormat:@"\t%@: %@\n",[self delLine:key], value];
        }
    }
    [string appendFormat:@"]"];
    return string;
}

- (NSString *)delLine:(NSString *)string {
    if ([string hasPrefix:@"_"]) {
        return [string substringFromIndex:1];
    }
    return string;
}


#pragma mark - Coding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

#pragma mark - Copying
- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}

#pragma mark - hash
- (NSUInteger)hash {
    return [self yy_modelHash];
}

#pragma mark - equal
- (BOOL)isEqual:(id)object {
    return [self yy_modelIsEqual:object];
}

@end
