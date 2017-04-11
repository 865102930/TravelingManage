//
//  NetWorkManager.m
//  AFN的封装
//
//  Created by 肖锋 on 2017/1/13.
//  Copyright © 2017年 肖锋. All rights reserved.
//

#import "NetWorkManager.h"
#import "UIImage+compressIMG.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetExportSession.h>
#import <AVFoundation/AVMediaFormat.h>

#define BaseUrl @"http://118.178.224.151/teammgmtback"

//#define BaseUrl @"http://192.168.0.124:8080/teammgmtback"

@implementation NetWorkManager

/*
 *  获取全局网络请求唯一的单利对象
 *
 *  return 返回创建好的网络实例
 */
+ (instancetype)shareManager
{
    static NetWorkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:BaseUrl]];
    });
    return manager;
}

/*
 *  重写父类的方法
 *  reture 返回创建好的实例
 */
- (instancetype)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url]) {
        
#warning 此部分可以根据需求设置
        NSAssert(url, @"您需要为您的请求设置baseUrl");
        
        [NetWorkManager startMonitoringWithNetwork];
        
        /*设置请求超时时间*/
        self.requestSerializer.timeoutInterval = 3;
        
        /*设置相应的缓存策略*/
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
        
        /*设置请求以及相应的序列化器*/
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
        
//        response.removesKeysWithNullValues = YES;
        
        self.responseSerializer = response;
        
        /*复杂的参数类型 需要使用json传值-设置请求内容的类型*/
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        /*设置接受的类型*/
        [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html", nil]];
    }
    return self;
}

#pragma mark - 普通网络请求
/*
 *  网络请求的实例方法(GET OR POST)
 *  type            请求类型(GET OR POST)
 *  urlString       请求的地址
 *  paraments       请求需要传入的参数
 *  successBlock    请求成功的回调
 *  failureBlock    请求失败的回调
 *  progress        进度回调
 */
- (void)requestWithType:(HttpRequestType)type
          withUrlString:(NSString *)urlString
          withParaments:(id)paraments
       withSuccessBlock:(requestSuccess)successBlock
       withFailureBlock:(requestFailure)failureBlock
               progress:(downloadProgress)progress
{
    if (!urlString || urlString.length <=0) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    switch (type) {
        case HttpRequestTypeGet:
        {
            [[NetWorkManager shareManager] GET:urlString parameters:paraments progress:^(NSProgress * _Nonnull downloadProgress) {
                progress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
            }];
            break;
        }
        case HttpRequestTypePost:
        {
            [[NetWorkManager shareManager] POST:urlString parameters:paraments progress:^(NSProgress * _Nonnull uploadProgress) {
                progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
            }];
        }
    }
}

#pragma mark - 上传图片
/**
 *  上传图片
 *  operations   上传图片等预留参数---(视具体情况而定 可移除)
 *  imageArray   上传的图片数组
 *  width        图片要被压缩到的宽度
 *  urlString    上传的url---请填写完整的url
 *  successBlock 上传成功的回调
 *  failureBlock 上传失败的回调
 *  progress     上传进度
 *
 */
- (void)uploadImageWithOperations:(NSDictionary *)operations
                  withImageArray:(NSArray *)imageArray
                 withtargetWidth:(CGFloat)width
                   withUrlString:(NSString *)urlString
                withSuccessBlock:(requestSuccess)successBlock
                 withFailurBlock:(requestFailure)failureBlock
              withUpLoadProgress:(uploadProgress)progress;
{
    if (!urlString || urlString.length <=0) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:urlString parameters:operations constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSUInteger i = 0 ;
        /**出于性能考虑,将上传图片进行压缩*/
        for (UIImage * image in imageArray) {
            //image的分类方法
            UIImage *  resizedImage =  [UIImage IMGCompressed:image targetWidth:width];
            NSData * imgData = UIImageJPEGRepresentation(resizedImage, .5);
            //拼接data
            [formData appendPartWithFileData:imgData name:[NSString stringWithFormat:@"picflie%ld",(long)i] fileName:@"image.png" mimeType:@" image/jpeg"];
            i++;
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

#pragma mark - 视频上传

/**
 *  视频上传
 *
 *  @param operations   上传视频预留参数---视具体情况而定 可移除
 *  @param videoPath    上传视频的本地沙河路径
 *  @param urlString     上传的url
 *  @param successBlock 成功的回调
 *  @param failureBlock 失败的回调
 *  @param progress     上传的进度
 */

- (void)uploadVideoWithOperaitons:(NSDictionary *)operations
                   withVideoPath:(NSString *)videoPath
                   withUrlString:(NSString *)urlString
                withSuccessBlock:(requestSuccess)successBlock
                withFailureBlock:(requestFailure)failureBlock
              withUploadProgress:(uploadProgress)progress
{
    if (!urlString || urlString.length <=0) {
        return;
    }
    /**获得视频资源*/
    AVURLAsset * avAsset = [AVURLAsset assetWithURL:[NSURL URLWithString:videoPath]];
    /**压缩*/
    //    NSString *const AVAssetExportPreset640x480;
    //    NSString *const AVAssetExportPreset960x540;
    //    NSString *const AVAssetExportPreset1280x720;
    //    NSString *const AVAssetExportPreset1920x1080;
    //    NSString *const AVAssetExportPreset3840x2160;
    AVAssetExportSession  *  avAssetExport = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPreset640x480];
    /**创建日期格式化器*/
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    /**转化后直接写入Library---caches*/
    NSString *  videoWritePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"/output-%@.mp4",[formatter stringFromDate:[NSDate date]]]];
    avAssetExport.outputURL = [NSURL URLWithString:videoWritePath];
    avAssetExport.outputFileType =  AVFileTypeMPEG4;
    __weak typeof(self) weakSelf = self;
    [avAssetExport exportAsynchronouslyWithCompletionHandler:^{
        switch ([avAssetExport status]) {
            case AVAssetExportSessionStatusCompleted:
            {
                AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
                [manager POST:urlString parameters:operations constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    //获得沙盒中的视频内容
                    [formData appendPartWithFileURL:[NSURL fileURLWithPath:videoWritePath] name:@"write you want to writre" fileName:videoWritePath mimeType:@"video/mpeg4" error:nil];
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
                } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
                    successBlock(responseObject);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    failureBlock(error);
                }];
                break;
            }
            default:
                break;
        }
    }];
}

#pragma mark - 文件下载
/**
 *  文件下载
 *  operations      文件下载预留参数---视具体情况而定 可移除
 *  savePath        下载文件保存路径
 *  urlString       请求的url
 *  successBlock    下载文件成功的回调
 *  failureBlock    下载文件失败的回调
 *  progress        下载文件的进度显示
 */

- (void)downLoadFileWithOperations:(NSDictionary *)operations
                     withSavaPath:(NSString *)savePath
                    withUrlString:(NSString *)urlString
                 withSuccessBlock:(requestSuccess)successBlock
                 withFailureBlock:(requestFailure)failureBlock
             withDownLoadProgress:(downloadProgress)progress
{
    if (!urlString || urlString.length <=0) {
        return;
    }
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return  [NSURL URLWithString:savePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        }
    }];
}

#pragma mark -  取消所有的网络请求
/**
 *  取消所有的网络请求
 *  a finished (or canceled) operation is still given a chance to execute its completion block before it iremoved from the queue.
 */
- (void)cancelAllRequest
{
    [[NetWorkManager shareManager].operationQueue cancelAllOperations];
}

#pragma mark -  取消指定的url请求
/**
 *  取消指定的url请求
 *  requestType     该请求的请求类型
 *  string          该请求的完整url
 */

- (void)cancelHttpRequestWithRequestType:(NSString *)requestType
                        requestUrlString:(NSString *)string
{
    NSError * error;
    /**根据请求的类型 以及 请求的url创建一个NSMutableURLRequest---通过该url去匹配请求队列中是否有该url,如果有的话 那么就取消该请求*/
    NSString * urlToPeCanced = [[[[NetWorkManager shareManager].requestSerializer requestWithMethod:requestType URLString:string parameters:nil error:&error] URL] path];
    for (NSOperation * operation in [NetWorkManager shareManager].operationQueue.operations) {
        //如果是请求队列
        if ([operation isKindOfClass:[NSURLSessionTask class]]) {
            //请求的类型匹配
            BOOL hasMatchRequestType = [requestType isEqualToString:[[(NSURLSessionTask *)operation currentRequest] HTTPMethod]];
            //请求的url匹配
            BOOL hasMatchRequestUrlString = [urlToPeCanced isEqualToString:[[[(NSURLSessionTask *)operation currentRequest] URL] path]];
            //两项都匹配的话  取消该请求
            if (hasMatchRequestType&&hasMatchRequestUrlString) {
                [operation cancel];
            }
        }
    }
}

/**
 *  监听网络状态的变化
 */
+ (void)startMonitoringWithNetwork
{
    //1.获得网络监控的管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //2.设置网络状态改变后的处理
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    //3.当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                [NetWorkManager shareManager].networkError = NO;
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络");
                [NetWorkManager shareManager].networkError = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                [NetWorkManager shareManager].networkError = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                NSLog(@"WIFI");
                [NetWorkManager shareManager].networkError = NO;
                break;
        }
    }];
    [manager startMonitoring];
}

/**
 *  返回处理好的json中文
 *  jsonData    传入的json数据
 */
- (NSString *)returnChaneseWithJson:(id)jsonData
{
    NSData *json = [NSJSONSerialization dataWithJSONObject:jsonData options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    return jsonStr;
}



@end
