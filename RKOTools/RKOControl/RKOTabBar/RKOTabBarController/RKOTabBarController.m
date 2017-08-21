//
//  RKOTabBarController.m
//  TabBarDemo
//
//  Created by Rakuyo on 2017/8/7.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import "RKOTabBarController.h"
#import "RKOTabBar.h"

@interface RKOTabBarController () <RKOTabBarDelegate>

// 定义一个全局的TabBar属性。
@property (nonatomic, strong) RKOTabBar *RKOTabBar;

@end

@implementation RKOTabBarController

// 单例方法，返回对象
+ (instancetype)sharedManager {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    创建RKOTabBar并取代原有TabBar
    [self createRKOTabBar];
}

// 创建RKOTabBar并取代原有TabBar
- (void)createRKOTabBar {
//    初始化一个自定义TabBar
    RKOTabBar *tabBar = [[RKOTabBar alloc] init];
    
//    设置tabBar的frame
    tabBar.frame = self.tabBar.frame;
    
//    设置代理
    tabBar.tabBarDelegate = self;
//    添加视图
    [self.view addSubview:tabBar];
    
    self.RKOTabBar = tabBar;
    
//    隐藏自带的tabBar
//    self.tabBar.hidden = YES;
}

// 添加控制器的方法
- (void)addViewController:(UIViewController *)viewController withTitle:(NSString *)title normalImageName:(NSString *)norImgName selectImageName:(NSString *)selImgName selected:(BOOL)selected {
    
//    设置VC对应的tabBar的属性参数。
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:norImgName];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selImgName] imageWithRenderingMode:YES];
//    是否初始显示
    self.RKOTabBar.selected = selected;
    
//    定义一个Navigation，然后将视图添加到Navigation中。
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:navi];
    
//    给自定义TabBar添加Item
    [self.RKOTabBar addTabBarItem:viewController.tabBarItem];
}

// 设置TabBar样式的方法
- (void)tabBarTitleHighlightedColor:(UIColor *)highligColor backgroundColor:(UIColor *)backgroundColor backgroundImgName:(NSString *)imgName {
    // 高亮状态下的文字颜色
    self.RKOTabBar.titleColor = highligColor;
    
    if (backgroundColor) {
        // TabBAR的背景颜色
        self.RKOTabBar.backgroundColor = backgroundColor;
    } else {
        // TabBar的背景图片
        self.RKOTabBar.backgroundImg = [UIImage imageNamed:imgName];
    }
}

#pragma mark - 隐藏与显示
// 隐藏TabBar
- (void)hideTabView {
    self.RKOTabBar.hidden = YES;
}

// 显示TabBar
- (void)showTabView {
    self.RKOTabBar.hidden = NO;
}

// 添加中间的btn
- (void)addExtraBtn:(UIButton *)btn {

    // 中间的btn
    self.RKOTabBar.extraBtn = btn;
    btn.backgroundColor =  [UIColor redColor];
    [self.RKOTabBar addSubview:btn];
    
    if (self.RKOTabBar.extraBtn) {
        [self.RKOTabBar.extraBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)click{
//    [self.tabBarControllerDelegate extraBtnClickedInTabBarController:self];
    [self.RKOTabBarControllerDelegate extraBtnClickedInTabBarController:self];
    NSLog(@"string");
}

#pragma mark - 代理方法
- (void)tabBar:(RKOTabBar *)tabBar selectBtnFromCurrentTo:(NSInteger)to {
//    切换控制器。
    self.selectedIndex = to;
}

@end
