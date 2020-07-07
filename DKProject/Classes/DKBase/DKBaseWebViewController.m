//
//  DKBaseWebViewController.m
//  GardenManager
//
//  Created by 王 on 2019/7/31.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseWebViewController.h"
#import <DKProject/DKProject.h>

//自定义的WKScriptMessageHandler 是为了解决内存不释放的问题
@implementation WeakWebViewScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

#pragma mark - WKScriptMessageHandler
//遵循WKScriptMessageHandler协议，必须实现如下方法，然后把方法向外传递
//通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([self.scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}

@end

@interface DKBaseWebViewController ()

@end

@implementation DKBaseWebViewController

- (instancetype)initWithUrl:(NSString *)url {
    if (self = [super init]) {
        self.urlString = url;
    }
    return self;
}

- (instancetype)initWithModel:(DKBaseModel *)model {
    if (self = [super initWithModel:model]) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.isLoadRequest) {
        [self.webView loadRequest:self.request];
    }
    if (self.isLoadHtml) {
        [self.webView loadHTMLString:self.htmlString baseURL:[NSURL URLWithString:self.baseUrlString]];
    }
    
    //添加监测网页加载进度的观察者
    [self.webView dk_addObserver:self forKeyPath:@"estimatedProgress" context:nil];
    //添加监测网页标题title的观察者
    [self.webView dk_addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)__addSubViews {
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
}

- (void)__makeConstraints {
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(2);
    }];
}

- (NSArray *)addScriptNameArray {
    return @[];
}

#pragma - mark setter
- (void)setLoadRequest:(BOOL)loadRequest {
    _loadRequest = loadRequest;
    if (_loadRequest) {
        self.loadHtml = NO;
    }
}

- (void)setLoadHtml:(BOOL)loadHtml {
    _loadHtml = loadHtml;
    if (_loadHtml) {
        self.loadRequest = NO;
    }
}

#pragma - mark lazy
- (NSString *)urlString {
    if (_urlString) {
        if (![_urlString hasPrefix:@"http://"] && ![_urlString hasPrefix:@"https://"]) {
            _urlString = [DK_BaseH5Url stringByAppendingString:_urlString];
        }
    }
    return _urlString;
}

- (NSMutableURLRequest *)request {
    if (!_request) {
        _request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlString]];
        [_request addValue:[self readCurrentCookieWithDomain:self.urlString] forHTTPHeaderField:@"Cookie"];
    }
    return _request;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:self.config];
        
        // UI代理
        _webView.UIDelegate = self;
        // 导航代理
        _webView.navigationDelegate = self;
        // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
        _webView.allowsBackForwardNavigationGestures = YES;
        //可返回的页面列表, 存储已打开过的网页
//        WKBackForwardList * backForwardList = [_webView backForwardList];
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _webView;
}

- (WKWebViewConfiguration *)config {
    if (!_config) {
        //创建网页配置对象
        _config = [[WKWebViewConfiguration alloc] init];
        //这个类主要用来做native与JavaScript的交互管理
        WKUserContentController *wkUContent = [[WKUserContentController alloc] init];
        for (NSString *name in [self addScriptNameArray]) {
            [wkUContent addScriptMessageHandler:self.weakScriptMessageDelegate name:name];
        }
        _config.userContentController = wkUContent;
    }
    return _config;
}

- (WeakWebViewScriptMessageDelegate *)weakScriptMessageDelegate {
    if (!_weakScriptMessageDelegate) {
        _weakScriptMessageDelegate = [[WeakWebViewScriptMessageDelegate alloc] initWithDelegate:self];
    }
    return _weakScriptMessageDelegate;
}

- (UIProgressView *)progressView {
    if (!_progressView){
        _progressView = [[UIProgressView alloc] init];
        _progressView.tintColor = dk_HexColor(DK_COLOR_APPMAIN);
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}

- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    
}
    
#pragma - mark KVO
//kvo 监听进度 必须实现此方法
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == self.webView) {
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.webView.estimatedProgress >= 1.0f) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.progress = 0;
            });
        }
    }else if([keyPath isEqualToString:@"title"]
             && object == self.webView){
        if (!self.isNotLoadTitle) {
            self.navigationItem.title = self.webView.title;
        }
    }else{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

#pragma - mark method
//解决第一次进入的cookie丢失问题
- (NSString *)readCurrentCookieWithDomain:(NSString *)domainStr{
    NSHTTPCookieStorage*cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSMutableString * cookieString = [[NSMutableString alloc]init];
    for (NSHTTPCookie*cookie in [cookieJar cookies]) {
        [cookieString appendFormat:@"%@=%@;",cookie.name,cookie.value];
    }
    
    //删除最后一个“;”
    if ([cookieString hasSuffix:@";"]) {
        [cookieString deleteCharactersInRange:NSMakeRange(cookieString.length - 1, 1)];
    }
    
    return cookieString;
}

//解决 页面内跳转（a标签等）还是取不到cookie的问题
- (void)getCookie{
    
    //取出cookie
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //js函数
    NSString *JSFuncString =
    @"function setCookie(name,value,expires)\
    {\
    var oDate=new Date();\
    oDate.setDate(oDate.getDate()+expires);\
    document.cookie=name+'='+value+';expires='+oDate+';path=/'\
    }\
    function getCookie(name)\
    {\
    var arr = document.cookie.match(new RegExp('(^| )'+name+'=([^;]*)(;|$)'));\
    if(arr != null) return unescape(arr[2]); return null;\
    }\
    function delCookie(name)\
    {\
    var exp = new Date();\
    exp.setTime(exp.getTime() - 1);\
    var cval=getCookie(name);\
    if(cval!=null) document.cookie= name + '='+cval+';expires='+exp.toGMTString();\
    }";
    
    //拼凑js字符串
    NSMutableString *JSCookieString = JSFuncString.mutableCopy;
    for (NSHTTPCookie *cookie in cookieStorage.cookies) {
        NSString *excuteJSString = [NSString stringWithFormat:@"setCookie('%@', '%@', 1);", cookie.name, cookie.value];
        [JSCookieString appendString:excuteJSString];
    }
    //执行js
    [self.webView evaluateJavaScript:JSCookieString completionHandler:nil];
}

#pragma mark -- WKNavigationDelegate
/*
 WKNavigationDelegate主要处理一些跳转、加载处理操作，WKUIDelegate主要处理JS脚本，确认框，警告框等
 */

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self getCookie];
}

//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
}

// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}

// 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString * urlStr = navigationAction.request.URL.absoluteString;
    DKLog(@"发送跳转请求：%@",urlStr);
    //自己定义的协议头 处理特殊 url 跳转
//    NSString *htmlHeadString = @"github://";
//    if([urlStr hasPrefix:htmlHeadString]) {
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"通过截取URL调用OC" message:@"你想前往我的Github主页?" preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//        }])];
//        [alertController addAction:([UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            NSURL * url = [NSURL URLWithString:[urlStr stringByReplacingOccurrencesOfString:@"github://callName_?" withString:@""]];
//            [[UIApplication sharedApplication] openURL:url];
//
//        }])];
//        [self presentViewController:alertController animated:YES completion:nil];
//
//        decisionHandler(WKNavigationActionPolicyCancel);
//
//    } else {
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSString * urlStr = navigationResponse.response.URL.absoluteString;
    DKLog(@"当前跳转地址：%@",urlStr);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

//需要响应身份验证时调用 同样在block中需要传入用户身份凭证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
    
//    //用户身份信息
//    NSURLCredential * newCred = [[NSURLCredential alloc] initWithUser:@"user123" password:@"123" persistence:NSURLCredentialPersistenceNone];
//    //为 challenge 的发送方提供 credential
//    [challenge.sender useCredential:newCred forAuthenticationChallenge:challenge];
//    completionHandler(NSURLSessionAuthChallengeUseCredential,newCred);
    
}

//进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    [self.webView reload];
}

#pragma mark -- WKUIDelegate
/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    DKBaseAlertController *alert = [DKBaseAlertController dk_AlertControllerWithTitle:nil message:message actionDefault:nil actionCancel:@"确定" handlerDefault:nil handlerCancel:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

// 确认框
//JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    DKBaseAlertController *alert = [DKBaseAlertController dk_AlertControllerWithTitle:nil message:message actionDefault:@"确定" actionCancel:@"取消" handlerDefault:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    } handlerCancel:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

// 输入框
//JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

// 页面是弹出窗口 _blank 处理
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma - mark 清除缓存
- (void)removeWebCache{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        NSSet *websiteDataTypes= [NSSet setWithArray:@[
                                                       WKWebsiteDataTypeDiskCache,
                                                       //WKWebsiteDataTypeOfflineWebApplication
                                                       WKWebsiteDataTypeMemoryCache,
                                                       //WKWebsiteDataTypeLocal
                                                       WKWebsiteDataTypeCookies,
                                                       //WKWebsiteDataTypeSessionStorage,
                                                       //WKWebsiteDataTypeIndexedDBDatabases,
                                                       //WKWebsiteDataTypeWebSQLDatabases
                                                       ]];
        
        // All kinds of data
        //NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            
        }];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        
    } else {
        //先删除cookie
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies])
        {
            [storage deleteCookie:cookie];
        }
        
        NSString *libraryDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleIdentifier"];
        NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
        NSString *webKitFolderInCaches = [NSString
                                          stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
        NSString *webKitFolderInCachesfs = [NSString
                                            stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
        NSError *error;
        /* iOS8.0 WebView Cache的存放路径 */
        [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
        [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
        /* iOS7.0 WebView Cache的存放路径 */
        [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCachesfs error:&error];
        NSString *cookiesFolderPath = [libraryDir stringByAppendingString:@"/Cookies"];
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&error];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
    }
}

#pragma - mark dealloc
- (void)dealloc {
    //移除观察者
//    [self removeAllObserverdKeyPath];
//    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
//    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(title))];
//    [[self.webView configuration].userContentController removeAllUserScripts];
    [self.config.userContentController removeAllUserScripts];
    [self removeWebCache];
    DKLog(@"dealloc");
}




@end
