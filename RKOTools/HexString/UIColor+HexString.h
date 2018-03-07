//
//  UIColor+HexString.h
//  RKOTools
//
//  Created by Rakuyo on 2018/1/25.
//  Copyright © 2018年 Rakuyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)

// 十六进制字符串转数字
+ (NSInteger)colorWithHexString:(NSString *)hexString;

@end
