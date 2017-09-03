# RKOTools

自己平时写的一个小工具库，上传到GitHub中且支持CocoaPods，方便自己使用。不断更新完善中。

<p align="center">
<a href=""><img src="https://img.shields.io/badge/pod-v1.3.2-brightgreen.svg"></a>
<a href=""><img src="https://img.shields.io/badge/ObjectiveC-compatible-orange.svg"></a>
<a href=""><img src="https://img.shields.io/badge/platform-iOS%208.0%2B-ff69b5152950834.svg"></a>
<a href="https://github.com/rakuyoMo/RKOTools/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat"></a>
</p>

## 目录

1. [RKOControl](#rkocontrol)
    1. [RKONetworkAlert](#rkonetworkalert)
    2. [RKOCell](#rkocell)
    3. [RKOTextView](#rkotextview) 
    4. [RKOTopAlert](#rkotopalert)
    5. [~~RKOTabBar~~](#rkotabbar)
2. [RKOTools](#rkotools-1)
    1. [NetWorkTool](#networktool)
    2. [CloseKeyBoard](#closekeyboard)
    3. [CollecionLog](#collecionlog)
    4. [TopViewController](#topviewcontroller)
    5. [CALayer+Additions](#calayeradditions)
    6. [~~FastFrame~~](#fastframe)
3. [BLOG](#blog)

## RKOControl

下面几个都是封装的一些**小控件**。

---------------------------------------------------------------------

### RKONetworkAlert

无网络时提醒的一个`Alert`小控件。接口部分非常简单，提供7个**宏定义**，用以修改`Alert`的尺寸以及持续时间。

```objc
// Alert尺寸对应的宏。

#define ALTERSTR    @"无网络连接"    // 显示的文字
#define ALPHA       0.95           // 透明度
#define ALERTW      150            // 宽度
#define ALERTH      60             // 高度
#define RADIUS      5              // 圆角
#define DURATION    2              // 持续时间
#define OVERTIME    0.5f           // 过度时间
```

仅需下面一个方法，便可弹出`Alert`弹窗：

```objc
/**
 弹出提示弹窗。
 */
+ (void)popAlert;
```

方法内部采用`UIButton`实现，并使用**单例模式**设计。

---------------------------------------------------------------------

### RKOCell

从`xib`或者自定义`Cell`中快速获取`Cell`的一个小工具。接口如下所示：

```objc
@interface RKOCell : UITableViewCell

/**
 快速获取 cell

 @param tableView 当前的tableView
 @return 一个普通的cell
 */
+ (instancetype)cell:(UITableView *)tableView;

/**
 从xib中获取cell

 @param tableView 当前的tableView
 @return 从xib中获取到的cell
 */
+ (instancetype)xibCell:(UITableView *)tableView;

/**
 获取一个空白的cell

 @param tableView 当前的tableView
 @return 一个空白的cell
 */
+ (id)blankCell:(UITableView *)tableView;

@end
```

---------------------------------------------------------------------

### RKOTextView

一个**近乎完美**的`UITextView`封装~~（肯定还有会有一些bug）~~

提供以下功能，几乎涵盖目前市面上的基本需求：
 1. 兼容`stroyboard/xib`以及纯代码。
 2. 根据内容自适应高度。
 3. 自定义占位符文字。
 4. 可以监听输入。
 5. 可以限制`TextView`显示的最大行数，在达到最大行数后滚动显示。
 6. 可以设置限制最大输入长度，并可以在达到最大字数时设置提醒。
 7. 在右侧提供一个清除按钮，可以设置显示时机，始终对于`TextView`垂直居中。
 8. 设置文字颜色和背景色的方法和原生`UITextView`没有区别。

未来预计实现的功能如下：
1. 限制输入的范围。

#### 使用

**基本使用方法如下所示：**

```objc
[self.textView textViewStyleWithplaceholder:@"请输入待办内容..." maxLimitNumber:40 maxNumberOfLines:3 clearBtnMode:RKOTextFieldViewModeWhileEditing];
```

#### 接口

**提供如下几个便利的构造方法，以及样式设置方法**

```objc
/**
 提供以下几个便捷方法，快速创建对象并设置其样式。
 
 @param frame 视图大小及位置
 @param placeholder 占位符文字
 @param maxLimitNumber 最大的限制字数
 @param maxNumberOfLines 最大的限制行数
 @param clearBtnMode 清除按钮的样式
 @return RKOTextView
 */
+ (RKOTextView *)textViewWithFrame:(CGRect)frame placeholder:(NSString *)placeholder maxLimitNumber:(NSInteger)maxLimitNumber maxNumberOfLines:(NSInteger)maxNumberOfLines clearBtnMode:(RKOTextFieldViewMode)clearBtnMode;
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder maxLimitNumber:(NSInteger)maxLimitNumber;
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder maxLimitNumber:(NSInteger)maxLimitNumber clearBtnMode:(RKOTextFieldViewMode)clearBtnMode;

- (void)textViewStyleWithplaceholder:(NSString *)placeholder maxLimitNumber:(NSInteger)maxLimitNumber maxNumberOfLines:(NSInteger)maxNumberOfLines clearBtnMode:(RKOTextFieldViewMode)clearBtnMode;
```

如果您需要**监听输入**，或者**在达到字数限制的时候提醒用户**，那您可以根据需要实现`RKOTextViewDelegate`协议中的**可选**方法。

```objc
@protocol RKOTextViewDelegate <NSObject>

@optional
/**
 如果您需要监听输入，请实现该方法。
 */
- (void)textViewDidChange:(UITextView *)textView;

/**
 如果您需要当达到最大字数时弹出提示窗，请将弹出提示窗的代码写在该方法中
 */
- (void)textViewPopAlertWhenMaxNumber:(UITextView *)textView;

@end
```

除此之外，我们还暴露一些属性，方便单独设置：

```objc
/** 占位符文字。 */
@property(nonatomic,copy) NSString *myPlaceholder;

/** 限定输入的字符数。
 
 注意：该属性优先于最大行数，即在达到最大字数却没有达到最大行数的情况下，无法继续输入。 */
@property (nonatomic, assign) NSInteger maxLimitNums;

/** TextView显示的最大行数。 */
@property (nonatomic, assign) NSUInteger maxNumberOfLines;

/** 清除按钮的显示时机 */
@property (nonatomic) RKOTextFieldViewMode clearBtnMode;
```

清除按钮的**显示时机**参照`UITextField`设计：

```objc
/** 定义ClearButton显示的时机 */
typedef NS_ENUM(NSInteger, RKOTextFieldViewMode) {
    RKOTextFieldViewModeNever = 0,
    RKOTextFieldViewModeWhileEditing,
    RKOTextFieldViewModeUnlessEditing,
    RKOTextFieldViewModeAlways
};
```

---------------------------------------------------------------------

### RKOTopAlert

自定义一个顶端的`Alert`提示窗。弹出时从顶端向下移动。

可以设置**提示文字**、**文字颜色**、**背景颜色**。

**高度**为`Status` + `NavigationBar`的高度。（不论您的`ViewController`是否添加到`NavigationController`中）

注意：该控件有以下几点**未进行测试**：
1. 编写时考虑到了自定义`NavigationBar`，但因为时间原因未进行测试。
2. 自定义`NavigationBar`，但自定义`NavigationBar`隐藏时的效果。
3. 原生`NavigationBar`隐藏时的情况。
3. 隐藏`Status`时的效果。

如果在您的项目中用到了以上几点未测试的功能，请将您的结果告诉我，帮助我完善该控件。

#### 使用

在需要弹出该提示窗的地方调用下面的方法

```objc
[RKOTopAlert popAlertViewWithText:@"已达最大字数限制" textColor:[UIColor colorWithRed:0.89 green:0.94 blue:0.95 alpha:1.00] ackgroundColor:[UIColor colorWithRed:0.88 green:0.25 blue:0.35 alpha:1.00] duration:2.5];
```

#### 接口

该提示窗提供一个方法用于设置样式并弹出提示窗。

```objc
/**
 设置提示窗的样式

 @param text 提示窗显示文字，不能为nil。为空则设置无效。
 @param textColor 文字颜色
 @param backgroundColor 提示窗背景颜色
 @param duration 横幅持续显示的时间
 */
+ (void)popAlertViewWithText:(NSString *)text
                   textColor:(UIColor *)textColor
              ackgroundColor:(UIColor *)backgroundColor
                    duration:(CGFloat)duration;
```

---------------------------------------------------------------------

### RKOTabBar

封装的一个`TabBar`，但是效果并是很好....想了想还是不放在这里了，几乎用不到，每次都要删除怪麻烦的。

---------------------------------------------------------------------

## RKOTools

这里是一些平时使用的一些**工具类**。

---------------------------------------------------------------------

### NetWorkTool

自定义封装的`AFNetworking`。初学乍道还不是很完善。

<br>接口提供如下几个**宏定义**：

```objc
// 您可以按照需求随意修改下面的宏的值，也可以在您的.pch文件中重新定义下面的宏。使您的代码逻辑看起来更加易读。
// 请注意不要重名。

// 内存缓存大小。
#define MEMCAPA 5

// 磁盘缓存大小。
#define DISKCAPA MEMCAPA * 2

// 超时时长，默认15秒。
#define TIMEOUT 15

// 缓存的文件夹名，请在您的ViewController.m中对该对象赋值。如：NSString * const diskPath = @"WebCache";
UIKIT_EXTERN NSString * const diskPath;
// 定义baseURL，请在您的ViewController.m中对该对象赋值。如：NSString * const baseURL = @"http://httpbin.org/";
UIKIT_EXTERN NSString * const baseURL;
```

- 注意：在`RKONetWorkTool.h`文件中，为了避免添加到CocoaPods不通过，对`diskPath`和`baseURL`进行了定义。在您使用的时候建议进行删除，将定义写在您的代码中。

<br>`RKONetWorkTool`提供7个方法，声明如下：

**POST方法：**
```objc
/**
 POST 网络请求
 
 @param url 请求地址（不需要包含baseURL）
 @param param 请求参数 (没有参数, 传 nil 即可)
 @param success 成功回调
 @param failure 请求错误回调
 */
+ (void)POSTWithPath:(NSString *)url
               param:(id)param
             success:(void (^)(id dataObject))success
             failure:(void (^)(NSError *error))failure;
```

**GET方法：**

```objc
/**
 GET 网络请求 获取JSON （自动JSON序列化）
 
 @param url 请求地址（不需要包含baseURL）
 @param param 请求参数 (没有参数, 传 nil 即可)
 @param success 成功回调
 @param failure 请求错误回调
 */
+ (void)GETJSONWithPath:(NSString *)url
                  param:(id)param
                success:(void (^)(id dataObject))success
                failure:(void (^)(NSError *error))failure;

/**
 GET 网络请求 获取HTTP （内部不进行JSON序列化）
 
 @param url 请求地址（不需要包含baseURL）
 @param param 请求参数 (没有参数, 传 nil 即可)
 @param success 成功回调
 @param failure 请求错误回调
 */
+ (void)GETHTTPWithPath:(NSString *)url
                  param:(id)param
                success:(void (^)(id dataObject))success
                failure:(void (^)(NSError *error))failure;
```

**download方法**

```objc
/**
 download 网络请求 自定义文件路径
 
 @param url 请求地址（不需要包含baseURL）
 @param filePath 文件下载路径（如果传nil则存入Caches）
 @param progress 下载进度回调，第一个参数为未处理的进度，第二个参数为带%的进度字符串。（block在主线程中执行）
 @param success 成功回调
 @param failure 请求错误回调
 */
+ (void)downloadWithPath:(NSString *)url
                filePath:(NSString *)filePath
                progress:(void (^)(double_t fractionCompleted, NSString *progressStr))progress
                 success:(void (^)(id dataObject))success
                 failure:(void (^)(NSError *error))failure;

/**
 download 网络请求 默认保存到Caches
 
 @param url 请求地址（不需要包含baseURL）
 @param progress 下载进度回调，第一个参数为未处理的进度，第二个参数为带%的进度字符串。（block在主线程中执行）
 @param success 成功回调
 @param failure 请求错误回调
 */
+ (void)downloadWithPath:(NSString *)url
                progress:(void (^)(double_t fractionCompleted, NSString *progressStr))progress
                 success:(void (^)(id dataObject))success
                 failure:(void (^)(NSError *error))failure;

```

**upload方法：**

```objc
/**
 upload 网络请求 （同步）
 
 @param url 请求地址（不需要包含baseURL）
 @param fileName 要上传的文件名
 @param progress 下载进度回调，第一个参数为未处理的进度，第二个参数为带%的进度字符串。（block在主线程中执行）
 @param success 成功回调
 @param failure 请求错误回调
 */
+ (void)uploadSynWithPath:(NSString *)url
                 fileName:(NSString *)fileName
                 progress:(void (^)(double_t fractionCompleted, NSString *progressStr))progress
                  success:(void (^)(id dataObject))success
                  failure:(void (^)(NSError *error))failure;

/**
 upload 网络请求 （异步）
 
 @param url 请求地址 (必须包含baseURL在内的使用全地址)
 @param fileName 要上传的文件名
 @param assocName 与指定数据进行关联的名称
 @param progress 下载进度回调，第一个参数为未处理的进度，第二个参数为带%的进度字符串。（block在主线程中执行）
 @param success 成功回调
 @param failure 请求错误回调
 */
+ (void)uploadAsynWithPath:(NSString *)url
                  fileName:(NSString *)fileName
            associatedName:(NSString *)assocName
                  progress:(void (^)(double_t, NSString *))progress
                   success:(void (^)(id))success
                   failure:(void (^)(NSError *))failure;
```

另外还额外提供了一个**单例方法**：

```objc
/**
 单例方法 内配置了baseURL与超时时长，超时时长默认15s。
 
 @return RKONetWorkTool类对象。
 */
+ (instancetype)sharedManager;
```

提供一个协议`RKONetWorkToolDelegate`，协议声明如下：

```objc
/**
 RKONetWorkToolDelegate 代理协议，用以提供设置无网络时候设置Alert的方法。
 
 之所以使用代理而不是直接把Alert写在本类中，是为了开放接口，方便使用者定义自己的Alert，而不用进到本类中修改代码。
 */
@protocol RKONetWorkToolDelegate <NSObject>

- (void)networkStaAlertWithNetWorkTool:(RKONetWorkTool *)netWorkTool;

@end
```

遵守该协议并实现`networkStaAlertWithNetWorkTool:`方法，即可设置在无网络时的弹窗提示。

---------------------------------------------------------------------

### CloseKeyBoard

`UITableView`的分类，点击空白处关闭键盘的小工具。在需要的地方引入头文件即可
<br><br>转载自简书：<br>
[iOS利用响应链机制点击tableview空白处关闭键盘](http://www.jianshu.com/p/9717b792599c)**评论中**的**鱼鱼鱼四只鱼**提供的代码。

---------------------------------------------------------------------

### CollecionLog

`NSDictionary`和`NSArray`的分类，拼接字符串，解决字典和数组中输出中文的时候是`unicode`编码的问题

---------------------------------------------------------------------

### TopViewController

`UIViewController`的分类，用来获取当前界面真在显示的`ViewController`，接口部分如下所示：

```objc
@interface UIViewController (RKOTopViewController)

+ (UIViewController *)topViewController;

@end
```

在需要的地方导入头文件，调用`topViewController`方法即可。

---------------------------------------------------------------------

### CALayer+Additions

`CALayer`的分类，方便在`StoryBoard`中**设置边框颜色**。如下所示提供一个属性`borderUIColor`：

```objc
@interface CALayer (Additions)

@property (nonatomic, strong)UIColor *borderUIColor;

@end
```

使用时在`StroyBoard`中添加`borderUIColor`属性即可设置边框颜色。

---------------------------------------------------------------------

### FastFrame

**因其与**`Masonry`**冲突，故从库中删除**。如果您有需要，可查找`1.1.0`版本的历史记录，查看相关代码与记录在`README`文件中的API说明。

---------------------------------------------------------------------

## BLOG

本人课余时间利用`HEXO`在GitHub上搭建的博客。未来部分工具会有对应的blog文章对应。在这里也把blog的地址贴出来吧：<br><br>
<a href="https://rakuyomo.github.io" target="_blank">喵喵喵</a>