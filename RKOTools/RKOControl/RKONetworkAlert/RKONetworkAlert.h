//
//  RKONetworkAlert.h
//  Summary01_Rakuyo
//
//  Created by Rakuyo on 2017/8/17.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import <UIKit/UIKit.h>

// Alert尺寸对应的宏。

#define ALERTW 150
#define ALERTH 60
#define DURATION 2

@interface RKONetworkAlert : UIButton

/**
 弹出提示弹窗。
 */
+ (void)popAlert;

@end
