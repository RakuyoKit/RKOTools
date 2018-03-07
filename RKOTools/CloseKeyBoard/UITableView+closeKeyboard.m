//
//  UITableView+closeKeyboard.m
//  RKOTools
//
//  Created by Rakuyo on 2017/8/1.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import "UITableView+closeKeyboard.h"

@implementation UITableView (closeKeyboard)

// 点击空白处结束键盘响应。http://www.jianshu.com/p/9717b792599c
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    id view = [super hitTest:point withEvent:event];
    if (![view isKindOfClass:[UITextView class]]) {
        [self endEditing:YES];
    }
    
    return view;
}

@end
