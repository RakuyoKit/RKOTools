# RKOTools

自己平时写的一个小工具库，上传到GitHub中且支持CocoaPods，方便自己使用。不断更新完善中。

<p align="center">
<a href=""><img src="https://img.shields.io/badge/pod-v1.0.5-brightgreen.svg"></a>
<a href=""><img src="https://img.shields.io/badge/ObjectiveC-compatible-orange.svg"></a>
<a href=""><img src="https://img.shields.io/badge/platform-iOS%208.0%2B-ff69b5152950834.svg"></a>
<a href="https://github.com/rakuyoMo/RKOTools/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat"></a>
</p>

## 目录

1. [RKOControl](#rkocontrol)
    1. [RKONetworkAlert](#rkonetworkalert)
    2. [RKOCell](#rkocell)
    3. [RKOTabBar](#rkotabbar)
2. [RKOTools](#rkotools-1)
    1. [NetWorkTool](#networktool)
    2. [CloseKeyBoard](#closekeyboard)
    3. [CollecionLog](#collecionlog)
    4. [TopViewController](#topviewcontroller)
    5. [CALayer+Additions](#calayeradditions)
3. [BLOG](#blog)

## RKOControl

下面几个都是封装的一些**小控件**。

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

### RKOTabBar

封装的一个`TabBar`，但是效果并是很好....并不准备继续完善了。

## RKOTools

这里是一些平时使用的一些**工具类**。

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


### CloseKeyBoard

`UITableView`的分类，点击空白处关闭键盘的小工具。在需要的地方引入头文件即可
<br><br>转载自简书：<br>
[iOS利用响应链机制点击tableview空白处关闭键盘](http://www.jianshu.com/p/9717b792599c)**评论中**的**鱼鱼鱼四只鱼**提供的代码。

### CollecionLog

`NSDictionary`和`NSArray`的分类，拼接字符串，解决字典和数组中输出中文的时候是`unicode`编码的问题

### TopViewController

`UIViewController`的分类，用来获取当前界面真在显示的`ViewController`，接口部分如下所示：

```objc
@interface UIViewController (RKOTopViewController)

+ (UIViewController *)topViewController;

@end
```

在需要的地方导入头文件，调用`topViewController`方法即可。

### CALayer+Additions

`CALayer`的分类，方便在`StoryBoard`中**设置边框颜色**。如下所示提供一个属性`borderUIColor`：

```objc
@interface CALayer (Additions)

@property (nonatomic, strong)UIColor *borderUIColor;

@end
```

使用时在`StroyBoard`中添加`borderUIColor`属性即可设置边框颜色。

## BLOG

本人课余时间利用`HEXO`在GitHub上搭建的博客。未来部分工具会有对应的blog文章对应。在这里也把blog的地址贴出来吧：<br><br>
<a href="https://rakuyomo.github.io" target="_blank">喵喵喵</a>