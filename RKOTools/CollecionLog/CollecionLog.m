//
//  NSDictionary+Log.m
//  RKOTools
//
//  Created by Rakuyo on 2017/8/15.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import "CollecionLog.h"
#import <objc/runtime.h>

static inline void rko_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector) {
    
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(theClass,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(theClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation NSDictionary (Log)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rko_swizzleSelector([self class], @selector(descriptionWithLocale:indent:), @selector(rko_descriptionWithLocale:indent:));
    });
}

- (NSString *)rko_descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    return [self stringByReplaceUnicode:[self rko_descriptionWithLocale:locale indent:level]];
}

- (NSString *)stringByReplaceUnicode:(NSString *)unicodeString {
    
    NSMutableString *convertedString = [unicodeString mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U" withString:@"\\u" options:0 range:NSMakeRange(0, convertedString.length)];
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    
    return convertedString;
}

@end

@implementation NSArray (Log)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rko_swizzleSelector([self class], @selector(descriptionWithLocale:indent:), @selector(rko_descriptionWithLocale:indent:));
    });
}

- (NSString *)zx_descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    return [self stringByReplaceUnicode:[self zx_descriptionWithLocale:locale indent:level]];
}

- (NSString *)stringByReplaceUnicode:(NSString *)unicodeString {
    
    NSMutableString *convertedString = [unicodeString mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U" withString:@"\\u" options:0 range:NSMakeRange(0, convertedString.length)];
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    
    return convertedString;
}

@end

@implementation NSSet (Log)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rko_swizzleSelector([self class], @selector(descriptionWithLocale:indent:), @selector(rko_descriptionWithLocale:indent:));
    });
}

- (NSString *)zx_descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    return [self stringByReplaceUnicode:[self zx_descriptionWithLocale:locale indent:level]];
}

- (NSString *)stringByReplaceUnicode:(NSString *)unicodeString {
    
    NSMutableString *convertedString = [unicodeString mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U" withString:@"\\u" options:0 range:NSMakeRange(0, convertedString.length)];
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    
    return convertedString;
}

@end
