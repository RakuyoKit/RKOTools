//
//  RKONetWorkTool.h
//  Summary01_Rakuyo
//
//  Created by Rakuyo on 2017/8/21.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RKONetWorkTool;

#pragma mark - macro
// 您可以按照需求随意修改下面的宏的值，也可以在您的.pch文件中重新定义下面的宏。使您的代码逻辑看起来更加易读。
// 请注意不要重名。

#ifndef MEMCAPA
// 内存缓存大小。
#define MEMCAPA 5
#endif

#ifndef DISKCAPA
// 磁盘缓存大小。
#define DISKCAPA MEMCAPA * 2
#endif

#ifndef TIMEOUT
// 超时时长，默认15秒。
#define TIMEOUT 15
#endif

// 缓存的文件夹名，请在您的ViewController.m中对该对象赋值。如：NSString * const diskPath = @"WebCache";
UIKIT_EXTERN NSString * const diskPath;
// 定义baseURL，请在您的ViewController.m中对该对象赋值。如：NSString * const baseURL = @"http://httpbin.org/";
UIKIT_EXTERN NSString * const baseURL;

#warning TODO
// 下面这两行是为了上传到pods不出错才写的，您的项目中最好删除下面两行，将该字符串的定义写到您的文件中。
NSString * const diskPath = @"WebCache";
NSString * const baseURL = @"http://httpbin.org/";

/**
 RKONetWorkToolDelegate 代理协议，用以提供设置无网络时候设置Alert的方法。
 
 之所以使用代理而不是直接把Alert写在本类中，是为了开放接口，方便使用者定义自己的Alert，而不用进到本类中修改代码。
 */
@protocol RKONetWorkToolDelegate <NSObject>

- (void)networkStaAlertWithNetWorkTool:(RKONetWorkTool *)netWorkTool;

@end

#pragma mark - NetworkMethod

@interface RKONetWorkTool : NSObject


/**
 单例方法 内配置了baseURL与超时时长，超时时长默认15s。
 
 @return RKONetWorkTool类对象。
 */
+ (instancetype)sharedManager;

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

/**
 代理属性
 */
@property (nonatomic, weak) id<RKONetWorkToolDelegate> networkToolDelegate;

@end
