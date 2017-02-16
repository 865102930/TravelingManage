//
//  NetWorkManager.h
//  AFN的封装
//
//  Created by 肖锋 on 2017/1/13.
//  Copyright © 2017年 肖锋. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

/*
    网络请求的类型
 */
typedef NS_ENUM(NSUInteger, HttpRequestType) {
    HttpRequestTypeGet = 0,
    HttpRequestTypePost
};

/*
    请求成功的回调block
 */
typedef void(^requestSuccess)(id object);

/*
    请求失败的回调block
 */
typedef void(^requestFailure)(NSError *error);

/*
    上传的进度block
 */
typedef void(^uploadProgress)(float progress);

/*
    下载进度block
 */
typedef void(^downloadProgress)(float progress);


@interface NetWorkManager : AFHTTPSessionManager

/**
 *  networkError
 */
@property(nonatomic, assign)BOOL networkError;

/*
 *  单利
 *  return          返回创建好的实例对象
 */
+ (instancetype)shareManager;

/*
 *  网络请求的实例方法(GET OR POST)
 *  type            请求类型
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
               progress:(downloadProgress)progress;

/**
 *  上传图片
 *  operations      上传图片预留参数---(视具体情况而定 可移除)
 *  imageArray      上传的图片数组
 *  width           图片要被压缩到的宽度
 *  urlString       上传的url
 *  successBlock    上传成功的回调
 *  failureBlock    上传失败的回调
 *  progress        上传进度
 */
- (void)uploadImageWithOperations:(NSDictionary *)operations
                  withImageArray:(NSArray *)imageArray
                 withtargetWidth:(CGFloat)width
                   withUrlString:(NSString *)urlString
                withSuccessBlock:(requestSuccess)successBlock
                 withFailurBlock:(requestFailure)failureBlock
              withUpLoadProgress:(uploadProgress)progress;

/**
 *  视频上传
 *  operations      上传视频预留参数---视具体情况而定 可移除
 *  videoPath       上传视频的本地沙河路径
 *  urlString       上传的url
 *  successBlock    成功的回调
 *  failureBlock    失败的回调
 *  progress        上传的进度
 */
- (void)uploadVideoWithOperaitons:(NSDictionary *)operations
                   withVideoPath:(NSString *)videoPath
                   withUrlString:(NSString *)urlString
                withSuccessBlock:(requestSuccess)successBlock
                withFailureBlock:(requestFailure)failureBlock
              withUploadProgress:(uploadProgress)progress;

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
             withDownLoadProgress:(downloadProgress)progress;

/**
 *  取消所有的网络请求
 */
- (void)cancelAllRequest;

/**
 *  取消指定的url请求
 *  requestType     该请求的请求类型
 *  string          该请求的url
 */
- (void)cancelHttpRequestWithRequestType:(NSString *)requestType
                        requestUrlString:(NSString *)string;

/**
 *  监听网络状态的变化
 */
+ (void)startMonitoringWithNetwork;

/**
 *  后台返回的数据转中文显示
 *  jsonData    传入的json数据
 */
- (NSString *)returnChaneseWithJson:(id)jsonData;



@end
