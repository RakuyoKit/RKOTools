//
//  UIView+StoryBoard.m
//  RKOTools
//
//  Created by Rakuyo on 2017/9/16.
//  Copyright © 2017年 BBDTEK. All rights reserved.
//

#import "UIView+StoryBoard.h"

@implementation UIView (StoryBoard)

#pragma mark - 圆角
- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;}

- (CGFloat)cornerRadius {return self.layer.cornerRadius;}

#pragma mark - 边框
- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;}
- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;}

- (CGFloat)borderWidth {return self.layer.borderWidth;}
- (UIColor *)borderColor {return [UIColor colorWithCGColor:self.layer.borderColor];}

#pragma mark - 阴影
- (void)setShadowOpacity:(float)shadowOpacity {
    self.layer.shadowOpacity = shadowOpacity;}
- (void)setShadowColor:(UIColor *)shadowColor {
    self.layer.shadowColor = shadowColor.CGColor;}
- (void)setShadowRadius:(CGFloat)shadowRadius {
    self.layer.shadowRadius = shadowRadius;}
- (void)setShadowOffset:(CGSize)shadowOffset {
    self.layer.shadowOffset = shadowOffset;}

- (float)shadowOpacity {return self.layer.shadowOpacity;}
- (UIColor *)shadowColor {return [UIColor colorWithCGColor:self.layer.shadowColor];}
- (CGFloat)shadowRadius {return self.layer.shadowRadius;}
- (CGSize)shadowOffset {return self.layer.shadowOffset;}

@end
