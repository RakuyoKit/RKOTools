//
//  UIViewController+RKOTopViewController.m
//  Summary01_Rakuyo
//
//  Created by Rakuyo on 2017/8/17.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import "UIViewController+RKOTopViewController.h"

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
