//
//  RKONetWorkTool.m
//  RKOTools
//
//  Created by Rakuyo on 2017/8/21.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import "RKONetWorkTool.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

typedef NS_ENUM(NSUInteger, RKOURLError) {
    RKOURLErrorEmptyURL     = -10000,
    RKOURLErrorURLIsNil     = -9000,
    RKOURLErrorServerError  = -8000,
    RKOURLErrorFileNotExist = -7000,
    RKOURLErrorNotReachable = -6000
};

@interface RKONetWorkTool ()

@property (nonatomic, strong) AFHTTPSessionManager *AFManager;

@end

@implementation RKONetWorkTool

#pragma mark - sharedManager
+ (instancetype)sharedManager {
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 配置baseURL
        NSURL *baseUrl = [NSURL URLWithString:baseURL];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        // 配置超时时长
        config.timeoutIntervalForRequest = TIMEOUT;
        
        // 初始化自身的AFManager属性。
        RKONetWorkTool *workTool = [[self alloc] init];
        workTool.AFManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl sessionConfiguration:config];
        
        instance = workTool;
        
        // 显示加载网络的指示符,需要导入AFNetworkActivityIndicatorManager.h。
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        
        // 设置缓存
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:MEMCAPA * 1024 * 1024 diskCapacity:DISKCAPA * 1024 * 1024 diskPath:diskPath];
        [NSURLCache setSharedURLCache:cache];
        
        // 开始监听网络变化。
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        
        // 根据网络状态弹出Alert。
        [self networkStatusWithAlert];
    });
    
    return instance;
}

#pragma mark - POST
+ (void)POSTWithPath:(NSString *)url param:(id)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    // 如果检查url出错，则返回error，跳出函数。
    if (![self checkURL:url domain:NSStringFromSelector(_cmd) failure:failure]) {
        return;
    }
    
    [[RKONetWorkTool sharedManager].AFManager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 判断是否正常接收到服务器的数据。
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        if (httpResponse.statusCode == 200 || httpResponse.statusCode == 304) {
            // responseObject 已经做好了反序列化
            // 调用成功的block，返回得到的对象。
            success(responseObject);
        } else {
            NSError *error = [NSError errorWithDomain:NSStringFromSelector(_cmd) code:RKOURLErrorServerError userInfo:@{@"reason":@"服务器错误"}];
            failure(error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 如果错误是无网络链接的话
        if (![AFNetworkReachabilityManager sharedManager].reachable) {
            
            RKONetWorkTool *tool = [self sharedManager];
            [tool.networkToolDelegate networkStaAlertWithNetWorkTool:tool];
            
            NSError *error = [NSError errorWithDomain:NSStringFromSelector(_cmd) code:RKOURLErrorNotReachable userInfo:@{@"reason":@"无网络连接"}];
            failure(error);
            
            return;
        }
        failure(error);
    }];
}

#pragma mark - GET
// 基方法
+ (void)GETWithSessionManager:(AFHTTPSessionManager *)sessionManager Path:(NSString *)url param:(id)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    // 如果检查url出错，则返回error，跳出函数。
    if (![self checkURL:url domain:NSStringFromSelector(_cmd) failure:failure]) {
        return;
    }
    
    [sessionManager GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 判断是否正常接收到服务器的数据。
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        if (httpResponse.statusCode == 200 || httpResponse.statusCode == 304) {
            // responseObject 已经做好了反序列化
            // 调用成功的block，返回得到的对象。
            success(responseObject);
        } else {
            NSError *error = [NSError errorWithDomain:NSStringFromSelector(_cmd) code:RKOURLErrorServerError userInfo:@{@"reason":@"服务器错误"}];
            failure(error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 如果错误是无网络链接的话
        if (![AFNetworkReachabilityManager sharedManager].reachable) {
            
            RKONetWorkTool *tool = [self sharedManager];
            [tool.networkToolDelegate networkStaAlertWithNetWorkTool:tool];
            
            NSError *error = [NSError errorWithDomain:NSStringFromSelector(_cmd) code:RKOURLErrorNotReachable userInfo:@{@"reason":@"无网络连接"}];
            failure(error);
            
            return;
        }
        failure(error);
    }];
}

// 获取JSON，进行JSON的序列化
+ (void)GETJSONWithPath:(NSString *)url param:(id)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    //调用基方法
    [self GETWithSessionManager:[RKONetWorkTool sharedManager].AFManager
                           Path:url
                          param:param
                        success:success
                        failure:failure];
}

// 获取HTTP,例如网页。不进行JSON序列化。
+ (void)GETHTTPWithPath:(NSString *)url param:(id)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *sesMag = [RKONetWorkTool sharedManager].AFManager;
    sesMag.responseSerializer = [AFHTTPResponseSerializer serializer];;
    
    //调用基方法
    [self GETWithSessionManager:sesMag
                           Path:url
                          param:param
                        success:success
                        failure:failure];
}

#pragma mark - DOWNLOAD
#define BASEURL [NSURL URLWithString:baseURL]
// downloadTask 自定义保存文件的路径。
+ (void)downloadWithPath:(NSString *)url filePath:(NSString *)filePath progress:(void (^)(double_t, NSString *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    // 如果检查url出错，则返回error，跳出函数。
    if (![self checkURL:url domain:NSStringFromSelector(_cmd) failure:failure]) {
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url relativeToURL:BASEURL]];
    
    [[[RKONetWorkTool sharedManager].AFManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        // 封装函数，返回进度。
        [self progress:progress fractionCompleted:downloadProgress.fractionCompleted];
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // targetPath是tmp文件的路径。
        
        // 转换成URL，本地文件的URL不能用urlWithString。
        NSURL *fileURL = nil;
        
        if (!filePath) {
            // 拼接文件路径，保存到Caches。该路径为文件保存的位置。
            NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
            fileURL = [NSURL URLWithString:filePath];
        } else {
            fileURL = [[NSURL alloc] initFileURLWithPath:filePath];
        }
        
        // 返回的url为文件保存的路径。
        return fileURL;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            // 如果错误是无网络链接的话
            if (![AFNetworkReachabilityManager sharedManager].reachable) {
                
                RKONetWorkTool *tool = [self sharedManager];
                [tool.networkToolDelegate networkStaAlertWithNetWorkTool:tool];
                
                NSError *error = [NSError errorWithDomain:NSStringFromSelector(_cmd) code:RKOURLErrorNotReachable userInfo:@{@"reason":@"无网络连接"}];
                failure(error);
                
                return;
            }
            failure(error);
            
        } else {
            // 判断是否正常接收到服务器的数据。
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200 || httpResponse.statusCode == 304) {
                // filePath 文件被保存到的路径。
#warning If you do not need to output, you can delete it
                NSLog(@"%@",filePath);
                // 调用成功的block，返回得到的对象。
                success(response);
            } else {
                NSError *error = [NSError errorWithDomain:NSStringFromSelector(_cmd) code:RKOURLErrorServerError userInfo:@{@"reason":@"服务器错误"}];
                failure(error);
            }
        }
        
    }] resume]; // Task类型的AFN方法，不会自己调用resume
}

// downloadTask 默认保存catch
+ (void)downloadWithPath:(NSString *)url progress:(void (^)(double_t, NSString *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    [self downloadWithPath:url
                  filePath:nil
                  progress:progress
                   success:success
                   failure:failure];
}

#pragma mark - UPLOAD
// 基方法
+ (void)uploadWithRequest:(id)request path:(NSString *)url fileName:(NSString *)fileName progress:(void (^)(double_t, NSString *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    if (![self checkURL:url domain:NSStringFromSelector(_cmd) failure:failure]) {
        return;
    }
    
    NSURL *fileURL = [self isFileExist:fileName];
    
    if (!fileURL) {
        NSError *error = [NSError errorWithDomain:NSStringFromSelector(_cmd) code:RKOURLErrorFileNotExist userInfo:@{@"reason":@"文件不存在"}];
        failure(error);
        return;
    }
    
    [[[RKONetWorkTool sharedManager].AFManager uploadTaskWithRequest:request fromFile:fileURL progress:^(NSProgress * _Nonnull uploadProgress) {
        
        // 封装函数，返回进度。
        [self progress:progress fractionCompleted:uploadProgress.fractionCompleted];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            // 如果错误是无网络链接的话
            if (![AFNetworkReachabilityManager sharedManager].reachable) {
                
                RKONetWorkTool *tool = [self sharedManager];
                [tool.networkToolDelegate networkStaAlertWithNetWorkTool:tool];
                
                NSError *error = [NSError errorWithDomain:NSStringFromSelector(_cmd) code:RKOURLErrorNotReachable userInfo:@{@"reason":@"无网络连接"}];
                failure(error);
                
                return;
            }
            failure(error);
            
        } else {
            // 判断是否正常接收到服务器的数据。
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200 || httpResponse.statusCode == 304){
                
                success(responseObject);
            } else {
                NSError *error = [NSError errorWithDomain:NSStringFromSelector(_cmd) code:RKOURLErrorServerError userInfo:@{@"reason":@"服务器错误"}];
                failure(error);
            }
        }
    }] resume];
}

// 同步上传文件
+ (void)uploadSynWithPath:(NSString *)url fileName:(NSString *)fileName progress:(void (^)(double_t, NSString *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url relativeToURL:BASEURL]];
    
    // 调用基方法
    [self uploadWithRequest:request path:url fileName:fileName progress:progress success:success failure:failure];
    
}

// 异步上传文件
+ (void)uploadAsynWithPath:(NSString *)url fileName:(NSString *)fileName associatedName:(NSString *)assocName progress:(void (^)(double_t, NSString *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[baseURL stringByAppendingString:url] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 上传文件。
        [formData appendPartWithFileURL:[self isFileExist:fileName] name:assocName error:nil];
    } error:nil];
    
    // 调用基方法
    [self uploadWithRequest:request path:url fileName:fileName progress:progress success:success failure:failure];
}

#pragma mark - NetWorktatus
// 监听网络状态。
+ (void)networkStatusWithAlert {
    
    // 每当网络状态改变，调用这个block。方法调用的时候也会走一遍这个block
    // 只调用block，不会再次调用方法。block在主线程中调用，可以直接绘制UI。
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            // 调用代理，显示提示视图
            RKONetWorkTool *tool = [self sharedManager];
            [tool.networkToolDelegate networkStaAlertWithNetWorkTool:tool];
        }
    }];
}

#pragma mark - TOOLS
// 检查url是否为空，防止调用AFN的方法使程序崩溃
+ (BOOL)checkURL:(NSString *)url domain:(NSErrorDomain)domain failure:(void (^)(NSError *error))failure {
    
    if ([url isEqualToString:@""] || url.length == 0) {
        NSError *error = [NSError errorWithDomain:domain code:RKOURLErrorEmptyURL userInfo:@{@"reason":@"URL不能为空"}];
        if (!url) {
            error = [NSError errorWithDomain:domain code:RKOURLErrorURLIsNil userInfo:@{@"reason":@"URL不能为nil"}];
        }
        failure(error);
        return NO;
    }
    
    return YES;
}

// 返回进度
+ (void)progress:(void (^)(double_t, NSString *))progress fractionCompleted:(double_t)fractionCompleted  {
    
    // downloadProgress.fractionCompleted 是double类型，是进度。
    NSString *progressStr = [NSString stringWithFormat:@"%.0f%%",fractionCompleted * 100];
    
    // 返回主线程调用进度block，方便更新UI。
    dispatch_async(dispatch_get_main_queue(), ^{
        // 调用进度的block，返回downloadProgress.fractionCompleted和转换成的带%的字符串。
        progress(fractionCompleted, progressStr);
    });
}

// 从沙盒中查询文件
+ (NSURL *)isFileExist:(NSString *)fileName {
    
    // 从沙盒中寻找文件
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    
    if (filePath) {
        return [NSURL fileURLWithPath:filePath];
    } else {
        return nil;
    }
}

@end
