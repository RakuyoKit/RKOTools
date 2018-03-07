//
//  UIImage+Rotate.h
//  RKOTools
//
//  Created by Rakuyo on 2017/11/14.
//  Copyright © 2017年 BBDTEK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Rotate)

// 将图片旋转degrees角度
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

// 将图片旋转radians弧度
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

@end
