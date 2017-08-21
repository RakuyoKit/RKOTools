//
//  UIViewController+RKOTopViewController.m
//  Summary01_Rakuyo
//
//  Created by Rakuyo on 2017/8/17.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import "UIViewController+RKOTopViewController.h"

/**
 这个获取顶部视图的方法有问题。顶部视图如果是TabelView的话显示的不对。还需要再修改。
 */
@implementation UIViewController (RKOTopViewController)

+ (UIViewController *)topViewController {
    
    UIViewController *resultVC;

    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
