//
//  RKOTabBarController.h
//  TabBarDemo
//
//  Created by Rakuyo on 2017/8/7.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RKOTabBarController;

@protocol RKOTabBarControllerDelegate <NSObject>

/**
 代理方法，用于给extraBtn添加点击事件
 
 @param tabBarController TabBarController自身
 */
- (void)extraBtnClickedInTabBarController:(RKOTabBarController *)tabBarController;

@end

/**
 自定义TabBar的控制器
 
 本类负责暴露设置方法给外界，进而设置TabBar的各种属性。并且负责跳转逻辑。
 */
@interface RKOTabBarController : UITabBarController

// 设置delegate属性。
@property (nonatomic, weak) id<RKOTabBarControllerDelegate> RKOTabBarControllerDelegate;

/**
 单例方法
 
 @return RKOTabBar
 */
+ (instancetype)sharedManager;

/**
 将VC添加到TabBar中并设置对应的Btn的样式属性。

 @param viewController 被添加到TabBar的控制器。
 @param title 对应的TabBarButton标题。
 @param norImgName 普通状态下TabBarButton的图片。
 @param selImgName 被选中状态下TabBarButton的图片。
 @param selected 是否为初始进入的控制器。
 */
- (void)addViewController:(UIViewController *)viewController withTitle:(NSString *)title normalImageName:(NSString *)norImgName selectImageName:(NSString *)selImgName selected:(BOOL)selected;

/**
 设置TabBar样式的方法

 @param highligColor 被选中状态下TabBar标题文字的颜色。
 @param backgroundColor TabBar的背景颜色。
 @param imgName TabBar的背景图片。
 */
- (void)tabBarTitleHighlightedColor:(UIColor *)highligColor backgroundColor:(UIColor *)backgroundColor backgroundImgName:(NSString *)imgName;

/**
 隐藏TabBar
 */
- (void)hideTabView;

/**
 显示TabBar
 */
- (void)showTabView;

/**
 添加中间额外的button的方法

 @param btn 额外的button
 */
- (void)addExtraBtn:(UIButton *)btn;

@end
