//
//  RKOTabBar.m
//  TabBarDemo
//
//  Created by Rakuyo on 2017/8/7.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import "RKOTabBar.h"
#import "RKOTabBarBtn.h"

@interface RKOTabBar ()

// 用以存储全部的tabBarBtn
@property (nonatomic, strong) NSMutableArray *btnMArr;

// 记录当前的按钮。
@property (nonatomic, strong) RKOTabBarBtn *currBtn;

@end

@implementation RKOTabBar

#pragma mark - 懒加载
- (NSMutableArray *)btnMArr {
    if (!_btnMArr) {
        // 设置可变数组数量
        _btnMArr = [NSMutableArray arrayWithCapacity:2];
    }
    return _btnMArr;
}

#pragma mark - 初始化
- (void)addTabBarItem:(UITabBarItem *)item {
    
    // 初始化一个自定义的btn
    RKOTabBarBtn *tabBarBtn = [[RKOTabBarBtn alloc] init];
    
    // 设置自定义btn的itme。
    [tabBarBtn setItem:item];
    
    // 设置btn的tag及选中状态
    [self tagWithTabBarBtn:tabBarBtn];
    
    // 给按钮添加点击事件，用来切换按钮的选中状态。
    [tabBarBtn addTarget:self action:@selector(clickTabBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    // 将按钮添加到视图中
    [self addSubview:tabBarBtn];
}

// 封装设置Btn的tag的代码。
- (void)tagWithTabBarBtn:(RKOTabBarBtn *)btn {

    // 按照按钮的数量设置按钮的tag。
    btn.tag = self.btnMArr.count;
    // 将按钮存储到数组中，用以记录按钮数量
    [self.btnMArr addObject:btn];
    // 设置第一个按钮为选中状态。
    if (self.selected) [self clickTabBarBtn:btn];
}

#pragma mark - 点击事件
// 改变btn的选中状态。
- (void)clickTabBarBtn:(RKOTabBarBtn *)btn{
    // 先取消跳转前那个控制器对应的按钮的选中状态
    self.currBtn.selected = NO;
    
    // 将被点击的按钮的选中状态设为YES
    btn.selected = YES;
    
    // 检测代理是否设置，并实现了跳转方法
    if (self.tabBarDelegate && [self.tabBarDelegate respondsToSelector:@selector(tabBar:selectBtnFromCurrentTo:)]) {
        // 当控制器数量不为1的时候。
        if (self.btnMArr.count != 1) {
            // 执行代理方法，用btn的tag区分btn，实现跳转。
            [self.tabBarDelegate tabBar:self selectBtnFromCurrentTo:btn.tag];
        }
    }
    
    // 将当前控制器的按钮设置“当前按钮”
    self.currBtn = btn;
    
    // 设置当前按钮的颜色
    [self.currBtn setTitleColor:self.titleColor forState:UIControlStateSelected];
}

#pragma mark - 样式
// 设置btn的frame
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    
    for (int index = 0; index < self.subviews.count; index ++) {
#warning TODO 
// 如果想把额外的btn放在最后,例如算上exBtn有偶数个图标的时候，把下面的if块注释掉就可以了。
        // 如果设置了额外的btn
        if (self.extraBtn) {
            // 交换元素
            if (self.subviews.count == 3 && index == 1) {
                [self exchangeSubviewAtIndex:index withSubviewAtIndex:(index + 1)];

            } else if (self.subviews.count == 5 && index == 2) {
                [self exchangeSubviewAtIndex:index withSubviewAtIndex:(index + 2)];
                [self exchangeSubviewAtIndex:(index + 1) withSubviewAtIndex:(index + 2)];
            }
        }
        
        CGFloat buttonX = buttonW * index;
        UIButton *btn = self.subviews[index];
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}

// 重写backgroundImage的set方法。设置背景图片。
- (void)setBackgroundImg:(UIImage *)backgroundImg {
    _backgroundImg = backgroundImg;
    
    self.layer.contents = (id)backgroundImg.CGImage;
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
}

// 重写backgroundColor的set方法。设置背景颜色。
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    
    self.layer.backgroundColor = backgroundColor.CGColor;
}

@end
