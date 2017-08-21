//
//  RKOTabBar.h
//  TabBarDemo
//
//  Created by Rakuyo on 2017/8/7.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RKOTabBar;
@class RKOTabBarBtn;

/**
 RKOTabBarDelegate
 
 用于处理视图之间的跳转。
 
 */
@protocol RKOTabBarDelegate <NSObject>

/**
 代理方法，用以切换控制器。

 @param tabBar TabBar自身
 @param to 目标控制器的tag值
 */
- (void)tabBar:(RKOTabBar *)tabBar selectBtnFromCurrentTo:(NSInteger)to;

@end

/**
 RKOTabBar
 
 自定义TabBar。
 本类用于将ViewController自身的item属性添加到自定义TabBar中。
 以及设置包括背景图片、背景颜色、选中状态下的文字颜色、子视图的位置在内的TabBar自身属性。
 
 */
@interface RKOTabBar : UIView

// 额外的按钮。
@property (nonatomic, strong) UIButton *extraBtn;

// 背景图片。
@property (nonatomic, weak) UIImage *backgroundImg;
// 背景颜色
@property (nonatomic, strong) UIColor *backgroundColor;
// 文字颜色。
@property (nonatomic, strong) UIColor *titleColor;
// 是否刚进入就显示
@property (nonatomic, assign) BOOL selected;

// 设置delegate属性。
@property (nonatomic, weak) id<RKOTabBarDelegate> tabBarDelegate;

/**
 将VC的item信息添加到TabBar中。

 @param item 目标VC的item属性。
 */
- (void)addTabBarItem:(UITabBarItem *)item;

@end
