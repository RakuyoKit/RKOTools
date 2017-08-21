//
//  RKOTabBarBtn.m
//  TabBarDemo
//
//  Created by Rakuyo on 2017/8/7.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import "RKOTabBarBtn.h"

@interface RKOTabBarBtn ()

// Btn的item属性。
@property (nonatomic, strong) UITabBarItem *item;

@end

@implementation RKOTabBarBtn

#pragma mark - init方法
- (instancetype)init {
    if (self = [super init]) {
        // 设置图片居中。
        self.imageView.contentMode = UIViewContentModeCenter;
        // 设置文字居中。
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

#pragma mark - item的set方法
- (void)setItem:(UITabBarItem *)item {
    _item = item;
    
    // 将item里的属性赋值给每个单独的btn。
    // 设置非高亮下btn的文字及文字颜色。
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 设置选中之前的图片。
    [self setImage:item.image forState:UIControlStateNormal];
    // 设置选中之后的图片。
    [self setImage:item.selectedImage forState:UIControlStateSelected];
}

#pragma mark - btn样式
// 设置btn的图片和文字的位置。
// 按钮是左右结构，不符合barItem的上下结构，因此要自定义按钮，重写返回rect的方法来设定图片和标题位置。
// 为了让二者居中，让按钮的图片水平铺满、竖直占据60%，标题也水平铺满，竖直占据40%，接着让内容居中即可。
#define myTabBarButtonImageRatio 0.6

// 图片部分
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    // 有字，就占60%的高度。
    if (self.titleLabel.text != nil) {
        return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * myTabBarButtonImageRatio);
    } else {
        // 没有字，就占全部的高度。
        return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height);
    }
}

// 文字部分
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * myTabBarButtonImageRatio;
    return CGRectMake(0, titleY, contentRect.size.width, contentRect.size.height - titleY);
}

// 高亮 —— 取消高亮功能，重写高亮方法，什么也不做
- (void)setHighlighted:(BOOL)highlighted{}

@end
