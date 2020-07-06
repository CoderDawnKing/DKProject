//
//  DKNetworkManager.h
//  GardenManager
//
//  Created by 王 on 2019/6/13.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "DKNetworkHttpUrl.h"

NS_ASSUME_NONNULL_BEGIN

/**定义请求类型的枚举*/

typedef NS_ENUM(NSUInteger,HttpRequestType)
{
    ///Get请求
    HttpRequestTypeGet = 0,
    ///Post请求
    HttpRequestTypePost,
    ///Delect请求
    HttpRequestTypeDelect,
    ///Put请求
    HttpRequestTypePut,
    ///Patch请求
    HttpRequestTypePatch,
    ///Head请求
    HttpRequestTypeHead,
    ///Upload请求
    HttpRequestTypeUploadImage,
    ///Upload请求
    HttpRequestTypeUploadVideo,
    ///Download请求
    HttpRequestTypeDownloadFile,
};

typedef NS_ENUM(NSUInteger, HttpErrorCodeType) {
    ///成功
    DKRequestRetcodeSuccess = 1,
    ///未登录
    DKRequestRetcodeNotLoggedIn = 201,
    ///参数错误
    DKRequestRetcodeErrorParameter = -1,
    ///禁止访问
    DKRequestRetcodeBlockingAccess = -100,
};

@interface DKNetworkBaseModel : NSObject

@end

@interface DKNetworkResultModel : DKNetworkBaseModel

@property (nonatomic, strong) NSNumber * current;
@property (nonatomic, strong) id         records;
@property (nonatomic, strong) NSNumber * retcode;
@property (nonatomic, strong) NSNumber * size;
@property (nonatomic, strong) NSNumber * total;

@end

@interface DKNetworkResponeModel : DKNetworkBaseModel
@property (nonatomic, strong) NSString *des;
@property (nonatomic, strong) id        result;
@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, strong) DKNetworkResultModel *resultModel;
@end


@interface DKNetworkRequestModel : DKNetworkBaseModel

- (instancetype)initWithRequest:(NSURLRequest *)request withParameters:(NSDictionary *)parameters;
@property (nullable, readonly, copy) NSURLRequest  *request;
@property (nullable, readonly, copy) NSURL *url;
@property (nullable, readonly, copy) NSDictionary *httpParameters;
@property (nullable, readonly, copy) NSDictionary *httpBodyJsonString;
@property (nullable, readonly, copy) NSDictionary<NSString *, NSString *> *allHTTPHeaderFields;
@property (nonatomic, strong) id responseObject;
@end


typedef void(^RequestBlock)(DKNetworkResponeModel *respone, NSError *error, DKNetworkRequestModel *request);

/**定义上传进度block*/
typedef void(^UploadProgress)(float progress);

/**定义下载进度block*/
typedef void(^DownloadProgress)(float progress);

    
    
@interface DKNetworkManager : AFHTTPSessionManager

@property (nonatomic, strong) NSMutableArray <NSURLSessionDataTask *> *dataTaskArray;

@property (nonatomic, strong) NSMutableDictionary <NSURLSessionDataTask *, NSNumber *> *dataTaskIsShowLoding;

@property (nonatomic, strong) NSMutableURLRequest *request;

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@property (nonatomic, strong) NSString *urlNoHost;

@property (nonatomic, assign, getter=isShowLoading) BOOL showLoading;

@property (nonatomic, assign, getter=isShowError) BOOL showError;


/**
 *  单例方法
 *
 *  @return 实例对象
 */
+ (instancetype)shareManager;

/**
 网络请求Get的实例方法
 */
- (void)getWithUrlString:(NSString *)urlString
            withParameters:(nullable NSDictionary *)parameters
        withRequestBlock:(nullable RequestBlock)requestBlock;

/**
 网络请求GetLoading的实例方法
 */
- (void)getWithUrlString:(NSString *)urlString
            withParameters:(nullable NSDictionary *)parameters
            isShowLoading:(BOOL)showLoading
         withRequestBlock:(nullable RequestBlock)requestBlock;

/**
 网络请求GetLoading的实例方法 是否传 header
 */
- (void)getWithUrlString:(NSString *)urlString
           withParameters:(nullable NSDictionary *)parameters
           isShowLoading:(BOOL)showLoading
               hasHeader:(BOOL)hasHeader
        withRequestBlock:(nullable RequestBlock)requestBlock;

/**
 网络请求Post的实例方法
 */
- (void)postWithUrlString:(NSString *)urlString
          withParameters:(nullable NSDictionary *)parameters
       withRequestBlock:(nullable RequestBlock)requestBlock;

/**
 网络请求PostLoading的实例方法
 */
- (void)postWithUrlString:(NSString *)urlString
            withParameters:(nullable NSDictionary *)parameters
            isShowLoading:(BOOL)showLoading
         withRequestBlock:(nullable RequestBlock)requestBlock;

/**
 网络请求PostBodyLoading的实例方法
 */
- (void)postWithUrlString:(NSString *)urlString
            withParameters:(nullable NSDictionary *)parameters
                 withBody:(nullable NSData *)body
            isShowLoading:(BOOL)showLoading
         withRequestBlock:(nullable RequestBlock)requestBlock;

/**
 网络请求PostBodyLoading的实例方法 是否传 header
 */
- (void)postWithUrlString:(NSString *)urlString
            withParameters:(nullable NSDictionary *)parameters
                 withBody:(nullable NSData *)body
            isShowLoading:(BOOL)showLoading
                 hasHeader:(BOOL)hasHeader
         withRequestBlock:(nullable RequestBlock)requestBlock;

/**
 网络请求PutBodyLoading的实例方法
 */
- (void)putWithUrlString:(NSString *)urlString
            withParameters:(nullable NSDictionary *)parameters
                 withBody:(nullable NSData *)body
            isShowLoading:(BOOL)showLoading
         withRequestBlock:(nullable RequestBlock)requestBlock;

/**
 网络请求PutBodyLoading的实例方法 是否传 header
 */
- (void)putWithUrlString:(NSString *)urlString
            withParameters:(nullable NSDictionary *)parameters
                 withBody:(nullable NSData *)body
            isShowLoading:(BOOL)showLoading
                 hasHeader:(BOOL)hasHeader
         withRequestBlock:(nullable RequestBlock)requestBlock;

/**
 网络请求Type的实例方法
 */
- (void)requestWithType:(HttpRequestType)type
          withUrlString:(NSString *)urlString
          withParameters:(nullable NSDictionary *)parameters
       withRequestBlock:(nullable RequestBlock)requestBlock;

/**
 网络请求Type的实例方法
 */
- (void)requestWithType:(HttpRequestType)type
          withUrlString:(NSString *)urlString
          withParameters:(nullable NSDictionary *)parameters
               withBody:(nullable NSData *)body
          isShowLoading:(BOOL)showLoading
       withRequestBlock:(nullable RequestBlock)requestBlock;

/**
 网络请求TypeLoading的实例方法 是否传 header
 */
- (void)requestWithType:(HttpRequestType)type
          withUrlString:(NSString *)urlString
          withParameters:(nullable NSDictionary *)parameters
          isShowLoading:(BOOL)showLoading
               hasHeader:(BOOL)hasHeader
       withRequestBlock:(nullable RequestBlock)requestBlock;

/**
 网络请求Base的实例方法

 @param type 类型
 @param urlString 接口 url
 @param parameters 参数
 @param body 请求体
 @param showLoading 是否显示 Loading
        当 2 个接口一起访问，会出现 loading 隐藏 bug，在访问成功后隐藏
 @param hasHeader 是否传 header
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)requestWithType:(HttpRequestType)type
          withUrlString:(NSString *)urlString
          withParameters:(nullable NSDictionary *)parameters
               withBody:(nullable NSData *)body
          isShowLoading:(BOOL)showLoading
            isShowError:(BOOL)showError
               hasHeader:(BOOL)hasHeader
       withRequestBlock:(nullable RequestBlock)requestBlock;

/**
 *  取消所有的网络请求
 */
- (void)cancelAllRequest;

/**
 *  取消指定的url请求
 *
 *  @param requestType 该请求的请求类型
 *  @param string      该请求的url
 */

- (void)cancelHttpRequestWithRequestType:(NSString *)requestType requestUrlString:(NSString *)string;

/**
 字符串转字典

 @param jsonString json 字符串
 @return 字典对象
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 字符串转数组
 
 @param jsonString json 字符串
 @return 数组对象
 */
- (NSArray *)arrayWithJsonString:(NSString *)jsonString;

@end

NS_ASSUME_NONNULL_END