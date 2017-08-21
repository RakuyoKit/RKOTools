# RKOTools

自己平时写的一个小工具库，上传到GitHub中且支持CocoaPods，方便自己使用。不断更新完善中。

<p align="center">
<a href=""><img src="https://img.shields.io/badge/pod-v1.0.1-brightgreen.svg"></a>
<a href=""><img src="https://img.shields.io/badge/ObjectiveC-compatible-orange.svg"></a>
<a href=""><img src="https://img.shields.io/badge/platform-iOS%208.0%2B-ff69b5152950834.svg"></a>
<a href="https://github.com/rakuyoMo/RKOTools/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat"></a>
</p>

## 目录

1. [RKOControl](https://github.com/rakuyoMo/RKOTools#RKOControl)
    1. [RKONetworkAlert](https://github.com/rakuyoMo/RKOTools#RKONetworkAlert)
    2. [RKOCell]([](https://github.com/rakuyoMo/RKOTools#RKOCell))
    3. [RKOTabBar](https://github.com/rakuyoMo/RKOTools#RKOTabBar)
2. [RKOTools](https://github.com/rakuyoMo/RKOTools#RKOTools)
    1. [NetWorkTool](https://github.com/rakuyoMo/RKOTools#NetWorkTool)
    2. [CloseKeyBoard](https://github.com/rakuyoMo/RKOTools#CloseKeyBoard)
    3. [CollecionLog](https://github.com/rakuyoMo/RKOTools#CollecionLog)
    4. [TopViewController](https://github.com/rakuyoMo/RKOTools#TopViewController)
    5. [CALayer+Additions](https://github.com/rakuyoMo/RKOTools#CALayer+Additions)

## RKOControl

下面几个都是封装的一些**小控件**。

### RKONetworkAlert

无网络时提醒的一个`Alert`小控件。

### RKOCell

从`xib`或者自定义`Cell`中快速获取`Cell`的一个小工具。

### RKOTabBar

封装的一个`TabBar`，但是效果并是很好....并不准备继续完善了。

## RKOTools

这里是一些平时使用的一些**工具类**。

### NetWorkTool

封装的`AFNetworking`。

### CloseKeyBoard

`UITableView`的分类，点击空白处关闭键盘的小工具。转载自简书：
[iOS利用响应链机制点击tableview空白处关闭键盘](http://www.jianshu.com/p/9717b792599c)**评论中**的**鱼鱼鱼四只鱼**提供的代码。

### CollecionLog

`NSDictionary`和`NSArray`的分类，拼接字符串，解决字典和数组中输出中文的时候是`unicode`编码的问题

### TopViewController

`UIViewController`的分类，用来获取当前界面真在显示的`ViewController`

### CALayer+Additions

`CALayer`的分类，方便在`StoryBoard`中**设置边框颜色**。