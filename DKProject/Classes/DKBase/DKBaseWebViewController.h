//
//  DKBaseWebViewController.h
//  GardenManager
//
//  Created by 王 on 2019/7/31.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseViewController.h"
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

// WKWebView 内存不释放的问题解决
@interface WeakWebViewScriptMessageDelegate : NSObject<WKScriptMessageHandler>

//WKScriptMessageHandler 这个协议类专门用来处理JavaScript调用原生OC的方法
@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end

@protocol DKBaseWebDelegate <NSObject>
@required
- (NSArray *)addScriptNameArray;
@optional
- (instancetype)initWithUrl:(NSString *)url;
@end

@interface DKBaseWebViewController : DKBaseViewController<WKUIDelegate, WKScriptMessageHandler, WKNavigationDelegate, DKBaseWebDelegate>

@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSString *htmlString;
@property (nonatomic, strong) NSString *baseUrlString;
@property (nonatomic, strong) NSArray *scriptNameArray;
@property (nonatomic, strong) WKWebViewConfiguration *config;
@property (nonatomic, strong) WKWebView *webView;
//网页加载进度视图
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WeakWebViewScriptMessageDelegate *weakScriptMessageDelegate;
@property (nonatomic, strong) DKBaseModel *model;

///是否加载 url
@property (nonatomic, assign, getter=isLoadRequest) BOOL loadRequest;
///是否加载 html
@property (nonatomic, assign, getter=isLoadHtml) BOOL loadHtml;
///是否不加载标题
@property (nonatomic, assign, getter=isNotLoadTitle) BOOL notLoadTitle;

@end

NS_ASSUME_NONNULL_END
