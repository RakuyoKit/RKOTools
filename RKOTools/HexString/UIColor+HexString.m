//
//  UIColor+HexString.m
//  RKOTools
//
//  Created by Rakuyo on 2018/1/25.
//  Copyright © 2018年 Rakuyo. All rights reserved.
//

#import "UIColor+HexString.h"

@implementation UIColor (HexString)

+ (NSInteger)colorWithHexString:(NSString *)hexString {
    
    const char *hexChar = [hexString cStringUsingEncoding:NSUTF8StringEncoding];
    
    int hexNumber;
    
    sscanf(hexChar, "%x", &hexNumber);
    
    return (NSInteger)hexNumber;
}

@end
