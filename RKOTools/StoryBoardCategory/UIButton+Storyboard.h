//
//  UIButton+Storyboard.h
//  RKOTools
//
//  Created by Rakuyo on 2017/12/4.
//  Copyright © 2017年 BBDTEK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Storyboard)

/** 防止多点触控 (后缀是为了防止 storyboard 中属性名太长导致看不全属性名) */
@property (nonatomic, assign) IBInspectable BOOL exclusiveTouch_rko;

@end
