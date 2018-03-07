//
//  UIView+RKOTools.m
//  RKOTools
//
//  Created by Rakuyo on 2018/1/19.
//  Copyright © 2018年 Rakuyo. All rights reserved.
//

#import "UIView+RKOTools.h"

@implementation UIView (RKOTools)

- (UIView *)findFirstResponder {
    if (self.isFirstResponder) {
        return self;
    }
    
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    
    return nil;
}

@end
