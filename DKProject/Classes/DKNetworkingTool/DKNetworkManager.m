//
//  DKNetworkManager.m
//  GardenManager
//
//  Created by 王 on 2019/6/13.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKNetworkManager.h"
//#import "OpenUDID.h"
//#import "Debugo.h"
#import <DKProject/DKProject.h>

#define TimeoutInterval 10
#define DK_NetworkBaseURL DK_BaseUrl
#define DK_NetworkSecretKey @""

@implementation DKNetworkBaseModel

MJLogAllIvars
MJImplementDebugDescription
MJCodingImplementation

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"Id" : @"id",
             @"desc" : @"description"
             };
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if (property.type.typeClass == [NSString class]) {//过滤空字符串
        if (oldValue == nil) return @"";
    } else if (property.type.typeClass == [NSDate class]) {//转换 date
        if (oldValue == [NSString class]) {
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            return [fmt dateFromString:oldValue];
        } else {
            NSTimeInterval timeInterval = ((NSNumber *)oldValue).doubleValue;
            if(timeInterval > 140000000000) {
                timeInterval = timeInterval / 1000;
            }
            return [NSDate dateWithTimeIntervalSince1970:timeInterval];
        }
    }
    return oldValue;
}

@end

@implementation DKNetworkResultModel
@end
@implementation DKNetworkResponeModel
- (DKNetworkResultModel *)resultModel {
    return [DKNetworkResultModel mj_objectWithKeyValues:self.result];
}
@end
@interface DKNetworkRequestModel ()
@property (nonatomic, nullable, readwrite, copy) NSURLRequest  *request;
@property (nonatomic, nullable, readwrite, copy) NSURL *url;
@property (nonatomic, nullable, readwrite, copy) NSDictionary *httpBodyJsonString;
@property (nonatomic, nullable, readwrite, copy) NSDictionary<NSString *, NSString *> *allHTTPHeaderFields;
@property (nonatomic, nullable, readwrite, copy) NSDictionary *httpParameters;

@end
@implementation DKNetworkRequestModel
- (instancetype)initWithRequest:(NSURLRequest *)request withParameters:(NSDictionary *)parameters {
    if (self = [super init]) {
        self.request = request;
        self.httpParameters = parameters;
    }
    return self;
}

- (NSDictionary *)httpBodyJsonString {
    if (self.request.HTTPBody) {
        return [NSJSONSerialization JSONObjectWithData:self.request.HTTPBody options:NSJSONReadingMutableLeaves error:nil];
    }
    return nil;
}

- (NSURL *)url {
    return self.request.URL;
}

- (NSDictionary<NSString *,NSString *> *)allHTTPHeaderFields {
    return self.request.allHTTPHeaderFields;
}
@end

@implementation DKNetworkManager

static NSString * const NetworkRequestRetcodeErrorDomain = @"com.gardenManager.app.Request";


/// 单例
+ (instancetype)shareManager {
    static DKNetworkManager * manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:DK_NetworkBaseURL]];
        
        /**设置请求超时时间*/
        
        manager.requestSerializer.timeoutInterval = TimeoutInterval;
        
        /**设置相应的缓存策略*/
        
        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
        /**分别设置请求以及相应的序列化器*/
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        AFJSONResponseSerializer * response = [AFJSONResponseSerializer serializer];
        
        response.removesKeysWithNullValues = YES;
        manager.responseSerializer = response;
        
        
        /**复杂的参数类型 需要使用json传值-设置请求内容的类型*/
//        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        
        // 此处做为测试 可根据自己应用设置相应的值
        
        /**设置apikey ------类似于自己应用中的tokken---此处仅仅作为测试使用*/
//        [self.requestSerializer setValue:apikey forHTTPHeaderField:@"apikey"];
        [manager.requestSerializer setValue:@"iphone_cxr" forHTTPHeaderField:@"User-Agent"];
        
        /**设置接受的类型*/
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    
    return manager;
}

/**
 网络请求Get的实例方法
 */
- (void)getWithUrlString:(NSString *)urlString
           withParameters:(NSDictionary *)parameters
        withRequestBlock:(nullable RequestBlock)requestBlock {
    [self getWithUrlString:urlString withParameters:parameters isShowLoading:NO withRequestBlock:requestBlock];
}

/**
 网络请求GetLoading的实例方法
 */
- (void)getWithUrlString:(NSString *)urlString
           withParameters:(NSDictionary *)parameters
           isShowLoading:(BOOL)showLoading
        withRequestBlock:(nullable RequestBlock)requestBlock {
    [self getWithUrlString:urlString withParameters:parameters isShowLoading:showLoading hasHeader:YES withRequestBlock:requestBlock];
}

/**
 网络请求GetLoading的实例方法 是否传 header
 */
- (void)getWithUrlString:(NSString *)urlString
           withParameters:(nullable NSDictionary *)parameters
           isShowLoading:(BOOL)showLoading
               hasHeader:(BOOL)hasHeader
        withRequestBlock:(nullable RequestBlock)requestBlock {
    [self requestWithType:HttpRequestTypeGet withUrlString:urlString withParameters:parameters isShowLoading:showLoading hasHeader:hasHeader withRequestBlock:requestBlock];
}

/**
 网络请求Post的实例方法
 */
- (void)postWithUrlString:(NSString *)urlString withParameters:(NSDictionary *)parameters withRequestBlock:(nullable RequestBlock)requestBlock {
    [self postWithUrlString:urlString withParameters:parameters isShowLoading:NO withRequestBlock:requestBlock];
}

/**
 网络请求PostLoading的实例方法
 */
- (void)postWithUrlString:(NSString *)urlString withParameters:(NSDictionary *)parameters isShowLoading:(BOOL)showLoading withRequestBlock:(nullable RequestBlock)requestBlock {
    [self postWithUrlString:urlString withParameters:parameters withBody:nil isShowLoading:showLoading withRequestBlock:requestBlock];
}

/**
 网络请求PostBodyLoading的实例方法
 */
- (void)postWithUrlString:(NSString *)urlString
            withParameters:(nullable NSDictionary *)parameters
                 withBody:(nullable NSData *)body
            isShowLoading:(BOOL)showLoading
         withRequestBlock:(nullable RequestBlock)requestBlock {
    [self postWithUrlString:urlString withParameters:parameters withBody:body isShowLoading:showLoading hasHeader:YES withRequestBlock:requestBlock];
}


/**
 网络请求PostBodyLoading的实例方法 是否传 header
 */
- (void)postWithUrlString:(NSString *)urlString
            withParameters:(nullable NSDictionary *)parameters
                 withBody:(nullable NSData *)body
            isShowLoading:(BOOL)showLoading
                hasHeader:(BOOL)hasHeader
         withRequestBlock:(nullable RequestBlock)requestBlock {
    [self requestWithType:HttpRequestTypePost withUrlString:urlString withParameters:parameters withBody:body isShowLoading:showLoading isShowError:YES hasHeader:hasHeader withRequestBlock:requestBlock];
}

/**
网络请求PutBodyLoading的实例方法
*/
- (void)putWithUrlString:(NSString *)urlString
          withParameters:(nullable NSDictionary *)parameters
                withBody:(nullable NSData *)body
           isShowLoading:(BOOL)showLoading
        withRequestBlock:(nullable RequestBlock)requestBlock {
    [self putWithUrlString:urlString withParameters:parameters withBody:body isShowLoading:showLoading hasHeader:YES withRequestBlock:requestBlock];
}

/**
 网络请求PutBodyLoading的实例方法 是否传 header
 */
- (void)putWithUrlString:(NSString *)urlString
          withParameters:(nullable NSDictionary *)parameters
                withBody:(nullable NSData *)body
           isShowLoading:(BOOL)showLoading
               hasHeader:(BOOL)hasHeader
        withRequestBlock:(nullable RequestBlock)requestBlock {
    [self requestWithType:HttpRequestTypePut withUrlString:urlString withParameters:parameters withBody:body isShowLoading:showLoading isShowError:YES hasHeader:hasHeader withRequestBlock:requestBlock];
}

/**
 网络请求Type的实例方法
 */
- (void)requestWithType:(HttpRequestType)type withUrlString:(NSString *)urlString withParameters:(NSDictionary *)parameters withRequestBlock:(nullable RequestBlock)requestBlock {
    [self requestWithType:type withUrlString:urlString withParameters:parameters withBody:nil isShowLoading:NO isShowError:YES hasHeader:YES withRequestBlock:requestBlock];
}

- (void)requestWithType:(HttpRequestType)type
          withUrlString:(NSString *)urlString
         withParameters:(nullable NSDictionary *)parameters
               withBody:(nullable NSData *)body
          isShowLoading:(BOOL)showLoading
       withRequestBlock:(nullable RequestBlock)requestBlock {
    [self requestWithType:type withUrlString:urlString withParameters:parameters withBody:body isShowLoading:showLoading isShowError:YES hasHeader:YES withRequestBlock:requestBlock];
}

/**
 网络请求TypeLoading的实例方法
 */
- (void)requestWithType:(HttpRequestType)type
          withUrlString:(NSString *)urlString
          withParameters:(NSDictionary *)parameters
          isShowLoading:(BOOL)showLoading
               hasHeader:(BOOL)hasHeader
       withRequestBlock:(nullable RequestBlock)requestBlock {
    [self requestWithType:type withUrlString:urlString withParameters:parameters withBody:nil isShowLoading:showLoading isShowError:YES hasHeader:hasHeader withRequestBlock:requestBlock];
}

/**
 网络请求Base的实例方法
 
 @param type 类型
 @param urlString 接口 url
 @param parameters 参数
 @param body 请求体
 @param showLoading 是否显示 Loading
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)requestWithType:(HttpRequestType)type
          withUrlString:(NSString *)urlString
          withParameters:(NSDictionary *)parameters
               withBody:(NSData *)body
          isShowLoading:(BOOL)showLoading
            isShowError:(BOOL)showError
               hasHeader:(BOOL)hasHeader
       withRequestBlock:(nullable RequestBlock)requestBlock {
    
    NSString *method = @"";
    switch (type) {
        case HttpRequestTypeGet:
            method = @"GET";
            break;
        case HttpRequestTypePost:
            method = @"POST";
            break;
        case HttpRequestTypeDelect:
            method = @"DELETE";
            break;
        case HttpRequestTypePut:
            method = @"PUT";
            break;
        case HttpRequestTypePatch:
            method = @"PATCH";
            break;
        case HttpRequestTypeHead:
            method = @"HEAD";
            break;
        default:
            method = @"";
            break;
    }
    
    _showLoading = showLoading;
    _showError = showError;
    NSMutableURLRequest *request;
    self.urlNoHost = urlString;
    if ([urlString hasPrefix:@"http"] || [urlString hasPrefix:@"https"]) {
        request = [self.requestSerializer requestWithMethod:method URLString:urlString parameters:parameters error:nil];
    } else {
        request = [self.requestSerializer requestWithMethod:method URLString:[NSString stringWithFormat:@"%@%@", DK_NetworkBaseURL, urlString] parameters:parameters error:nil];
    }
    
    if (hasHeader) {
        // TODO: 添加 header
//        GardenManager *manager = [GardenManager sharedManager];
//        if (manager.UserID.integerValue > 0) {
//            [request addValue:manager.UserID.stringValue forHTTPHeaderField:@"userid"];
//
//            NSString *timestamp = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970InMilliSecond]];
//            [request addValue:timestamp forHTTPHeaderField:@"timestamp"];
//
//            [request addValue:[OpenUDID value] forHTTPHeaderField:@"imei"];
//
//            NSMutableString *tempToken=[[NSMutableString alloc]init];
//            [tempToken appendFormat:@"%@",DK_NetworkSecretKey];
//            [tempToken appendFormat:@"%@",timestamp];
//            [request addValue:[tempToken md5Encryption] forHTTPHeaderField:@"token"];
//        }
        
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];//获取项目版本号
        if (version) {
            [request addValue:version forHTTPHeaderField:@"version"];
        }
    }
    
    if (body) {
        if (request.HTTPBody) {
            NSMutableData *data = [NSMutableData dataWithData:request.HTTPBody];
            [data appendData:body];
        }
        request.HTTPBody = body;
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    }
    [self startRequest:request withParameters:parameters withShowLoading:showLoading withRequestBlock:requestBlock];
}

- (void)startRequest:(NSMutableURLRequest *)request withParameters:(NSDictionary *)parameters withShowLoading:(BOOL)showLoading withRequestBlock:(nullable RequestBlock)requestBlock {
    __block NSDictionary *blockParameters = parameters;
    __block NSURLSessionDataTask *dataTask = [self dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        __weak typeof(self) weakSelf = self;
        [weakSelf requestFinsh:responseObject withParameters:blockParameters error:error withRequestBlock:requestBlock dataTask:dataTask];
    }];
    [self.dataTaskIsShowLoding setObject:@(showLoading) forKey:dataTask];
    [self startWithDataTask:dataTask];
}


- (void)requestFinsh:(id)responseObject withParameters:(NSDictionary *)parameters error:(NSError *)error withRequestBlock:(nullable RequestBlock)requestBlock dataTask:(NSURLSessionDataTask *)dataTask {
    DKNetworkResponeModel *responeModel = [DKNetworkResponeModel mj_objectWithKeyValues:responseObject];
    DKNetworkRequestModel *request = [[DKNetworkRequestModel alloc] initWithRequest:dataTask.originalRequest withParameters:parameters];
    request.responseObject = responseObject;
    NSError *requestError = [self errorWtihRespone:responeModel withError:error];
    if (requestError) {
        DKLog(@"\n ========== url ========== \n%@", request.url.absoluteString);
        DKLog(@"\n ========== header ========== \n%@", request.allHTTPHeaderFields);
        DKLog(@"\n ========== body ========== \n%@", request.httpBodyJsonString);
        DKLog(@"\n ========== parameters ========== \n%@", request.httpParameters);
        DKLog(@"\n ========== code ========== \n%@", responeModel.code);
        DKLog(@"\n ========== des ========== \n%@", responeModel.des);
        if (responeModel && self.isShowError) {
            if (responeModel.des.dk_notEmpty) {
                [DKBaseProgressHUD showErrorWithStatus:responeModel.des];
            } else {
                [DKBaseProgressHUD showErrorWithStatus:[error.userInfo valueForKey:NSLocalizedDescriptionKey]];
            }
        }
    }
    // TODO: 添加测试工具
//    if (DGAssistant.shared.configuration.isShowConsole) {
//        DKConsoleOutputModel *consoleModel = [[DKConsoleOutputModel alloc] init];
//        consoleModel.time = [NSDate currentDateWithMSDefaultFormatter];
//        consoleModel.output = request.url.absoluteString;
//        consoleModel.request = request;
//        consoleModel.responseObject = responseObject;
//        [DGDebugo consoleOutput:consoleModel];
//    }
    
    [self.dataTaskIsShowLoding removeObjectForKey:dataTask];
    
    if (requestBlock) {
        requestBlock(responeModel, requestError, request);
    }
}

#pragma mark - 错误解析

- (NSError *)errorWtihRespone:(DKNetworkResponeModel *)resopne withError:(NSError *)error {
    
    if (_showLoading) {
        [DKBaseProgressHUD dismiss];
    }
    
    if (error) {
        NSData *data = [error.userInfo valueForKey:@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dict = nil;
        if (data) {
            dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        }
        DKLog(@"\n ========== errorData ========== \n%@", dict);
        if (error.code == NSURLErrorCancelled
            || error.code == NSURLErrorTimedOut
            || error.code == NSURLErrorCannotFindHost
            || error.code == NSURLErrorCannotConnectToHost
            || error.code == NSURLErrorNetworkConnectionLost
            || error.code == NSURLErrorNotConnectedToInternet) {
            [[NSNotificationCenter defaultCenter] postNotificationName:DK_Noti_NoNetwork_NameKey object:nil];
        }
        return error;
    }
    if (resopne.code.integerValue == DKRequestRetcodeSuccess) {
        [[NSNotificationCenter defaultCenter] postNotificationName:DK_Noti_NetworkSuccess_NameKey object:nil];
        return nil;
    }
    
    if (resopne.code.integerValue == DKRequestRetcodeNotLoggedIn) {
        error = [NSError errorWithDomain:NetworkRequestRetcodeErrorDomain code:DKRequestRetcodeNotLoggedIn userInfo:@{NSLocalizedDescriptionKey: resopne.des.dk_notEmpty?resopne.des:@"用户未登录，请先登录"}];
        [[NSNotificationCenter defaultCenter] postNotificationName:DK_Noti_NotLoggedIn_NameKey object:nil];
        return error;
    }
    
    if (resopne.code.integerValue == DKRequestRetcodeErrorParameter) {
        error = [NSError errorWithDomain:NetworkRequestRetcodeErrorDomain code:DKRequestRetcodeErrorParameter userInfo:@{NSLocalizedDescriptionKey: resopne.des.dk_notEmpty?resopne.des:@"参数错误"}];
        return error;
    }
    if (resopne.code.integerValue == DKRequestRetcodeBlockingAccess) {
        error = [NSError errorWithDomain:NetworkRequestRetcodeErrorDomain code:DKRequestRetcodeBlockingAccess userInfo:@{NSLocalizedDescriptionKey: resopne.des.dk_notEmpty?resopne.des:@"禁止访问"}];
        [[NSNotificationCenter defaultCenter] postNotificationName:DK_Noti_NetworkError_NameKey object:nil];
        return error;
    }
    error = [NSError errorWithDomain:NetworkRequestRetcodeErrorDomain code:resopne.code.integerValue userInfo:@{NSLocalizedDescriptionKey: resopne.des.dk_notEmpty?resopne.des:@"请求失败,请稍后再试"}];
    return error;
    
}

- (NSMutableArray<NSURLSessionDataTask *> *)dataTaskArray {
    if (!_dataTaskArray) {
        _dataTaskArray = [NSMutableArray array];
    }
    return _dataTaskArray;
}

/**
 取消请求
 */
- (void)cancle {
    if ([self dataTaskIsShowloding:self.dataTask]) {
        [DKBaseProgressHUD dismiss];
    }
    [self.dataTask cancel];
}

/**
 开始请求
 */
- (void)startWithDataTask:(NSURLSessionDataTask *)dataTask {
    if ([self dataTaskIsShowloding:dataTask]) {
        [DKBaseProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [DKBaseProgressHUD show];
    }
    [dataTask resume];
}

- (BOOL)dataTaskIsShowloding:(NSURLSessionDataTask *)dataTask {
    NSNumber *number = [self.dataTaskIsShowLoding objectForKey:dataTask];
    return number.boolValue;
}

- (NSMutableDictionary<NSURLSessionDataTask *,NSNumber *> *)dataTaskIsShowLoding {
    if (!_dataTaskIsShowLoding) {
        _dataTaskIsShowLoding = [NSMutableDictionary dictionary];
    }
    return _dataTaskIsShowLoding;
}

- (void)testDownload:(NSURLRequest *)request {
    
    NSURLSessionDownloadTask *task = [self downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:path];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        DKLog(@"%@", error);
    }];
    [task resume];
}

#pragma mark -  取消所有的网络请求

/**
 *  取消所有的网络请求
 *  a finished (or canceled) operation is still given a chance to execute its completion block before it iremoved from the queue.
 */

- (void)cancelAllRequest {
    if ([self dataTaskIsShowloding:self.dataTask]) {
        [DKBaseProgressHUD dismiss];
    }
    [self.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj cancel];
    }];
    [self.operationQueue cancelAllOperations];
}



#pragma mark -   取消指定的url请求/
/**
 *  取消指定的url请求
 *
 *  @param requestType 该请求的请求类型
 *  @param string      该请求的完整url
 */

- (void)cancelHttpRequestWithRequestType:(NSString *)requestType requestUrlString:(NSString *)string {
    
    NSError * error;
    
    /**根据请求的类型 以及 请求的url创建一个NSMutableURLRequest---通过该url去匹配请求队列中是否有该url,如果有的话 那么就取消该请求*/
    
    NSString * urlToPeCanced = [[[self.requestSerializer requestWithMethod:requestType URLString:string parameters:nil error:&error] URL] path];
    
    
    for (NSOperation * operation in self.operationQueue.operations) {
        
        //如果是请求队列
        if ([operation isKindOfClass:[NSURLSessionTask class]]) {
            
            //请求的类型匹配
            BOOL hasMatchRequestType      = [requestType isEqualToString:[[(NSURLSessionTask *)operation currentRequest] HTTPMethod]];
            
            //请求的url匹配
            
            BOOL hasMatchRequestUrlString = [urlToPeCanced isEqualToString:[[[(NSURLSessionTask *)operation currentRequest] URL] path]];
            
            //两项都匹配的话  取消该请求
            if (hasMatchRequestType&&hasMatchRequestUrlString) {
                [operation cancel];
            }
        }
    }
}

//字符串转字典
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        DKLog(@"json字典解析失败：%@",err);
        return nil;
    }
    return dic;
}

//字符串转数组
- (NSArray *)arrayWithJsonString:(NSString *)jsonString {
    if ([jsonString isEqual:[NSNull null]] || jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        DKLog(@"json数组解析失败：%@",err);
        return nil;
    }
    return arr;
}

@end

