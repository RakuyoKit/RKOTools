//
//  UIView+Layout.h
//  test
//
//  Created by Rakuyo on 2017/8/21.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FastFrame)

#pragma mark - 上下左右间距
@property (assign, nonatomic) CGFloat top;
@property (assign, nonatomic) CGFloat bottom;
@property (assign, nonatomic) CGFloat left;
@property (assign, nonatomic) CGFloat right;

#pragma mark - 坐标
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGPoint origin;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;

#pragma mark - 尺寸
@property (assign, nonatomic) CGSize  size;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;

@end
