//
//  RKOTabBarBtn.h
//  TabBarDemo
//
//  Created by Rakuyo on 2017/8/7.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 RKOTabBarBtn
 
 RKOTabBar上的自定义Btn。
 本类只负责设置Btn的图片和文字，及图片和文字的布局。不负责设置整个Btn的Frame。
 
 */
@interface RKOTabBarBtn : UIButton

/**
 暴露item的set方法用于设置。

 @param item Btn的item属性。
 */
- (void)setItem:(UITabBarItem *)item;

@end
