//
//  UIView+StoryBoard.h
//  RKOTools
//
//  Created by Rakuyo on 2017/9/16.
//  Copyright © 2017年 BBDTEK. All rights reserved.
//

#import <UIKit/UIKit.h>

//IB_DESIGNABLE // iOS 11 中OC依然没有修复这个宏的bug，所以还是注释掉吧

/** 方便在StoryBoard中为UIView设置样式属性。 */
@interface UIView (StoryBoard)

/** 圆角。 */
@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;

/** 边框宽度和颜色。 */
@property(nonatomic,assign) IBInspectable CGFloat borderWidth;
@property(nonatomic,strong) IBInspectable UIColor *borderColor;

/** 阴影。 */
@property(nonatomic,assign) IBInspectable float shadowOpacity;
@property(nonatomic,strong) IBInspectable UIColor *shadowColor;
@property(nonatomic,assign) IBInspectable CGFloat shadowRadius;
@property(nonatomic,assign) IBInspectable CGSize shadowOffset;

@end
