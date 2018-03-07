//
//  UIButton+Storyboard.m
//  RKOTools
//
//  Created by Rakuyo on 2017/12/4.
//  Copyright © 2017年 BBDTEK. All rights reserved.
//

#import "UIButton+Storyboard.h"

@implementation UIButton (Storyboard)

#pragma mark - 防止多点触控
- (void)setExclusiveTouch_rko:(BOOL)exclusiveTouch_rko {
    self.exclusiveTouch = exclusiveTouch_rko;}

- (BOOL)exclusiveTouch_rko {return self.isExclusiveTouch;}

@end
