//
//  webJsVC.m
//  note_oc
//
//  Created by hryan on 16/2/16.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "WebJsVC.h"
#import <WebKit/WebKit.h>

typedef NS_ENUM(NSInteger,containerType) {
    containerTypeString,
    containerTypeNumber,
    containerTypeArray,
    containerTypeDictionary,
    containerTypeUndefined
};

@interface WebJsVC ()<WKScriptMessageHandler, WKUIDelegate,WKNavigationDelegate>

@property (nonatomic) UIProgressView *progress;
@property (nonatomic) WKWebView *wKWebView;
@property (nonatomic) WKWebsiteDataStore *sss;


@end

@implementation WebJsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(click)];
    [self.view addSubview:self.wKWebView];
    [self.view addSubview:self.progress];
    [_wKWebView addObserver: self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
#pragma 方法一  加载本地html  加载图片时 if图片和html文件在同一目录下可以直接加载 else 在图片的url上加上相对路径
//    NSString *html = [[NSBundle mainBundle] pathForResource:@"JSAndOC" ofType:@"html"];
//    NSURL *url = [NSURL fileURLWithPath:html];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [_wKWebView loadRequest:request];

#pragma  方法二 加载html 本地图片时 必须设置baseURL

    NSString *baseStr = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/webSource"];
    NSURL *baseURL = [NSURL fileURLWithPath:baseStr];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JSAndOC" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [_wKWebView loadHTMLString:html baseURL:baseURL];
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSString*, id> *)change context:(nullable void *)context {
    if ([@"estimatedProgress" isEqualToString:keyPath]) {
        [self.progress setProgress:self.wKWebView.estimatedProgress animated:YES];
        
        if (self.progress.progress == 0) {
            self.progress.hidden = NO;
        } else if (self.progress.progress == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.progress.progress == 1) {
                    self.progress.progress = 0;
                    self.progress.hidden = YES;
                }
            });
        }
    }
}

#pragma mark --oc掉Js
- (void)click {

    [_wKWebView evaluateJavaScript:@"onClikButton()" completionHandler:^(id _Nullable completionHandler, NSError * _Nullable error) {
        DLog(@"completionHandler:%@",completionHandler);
    }];
}

- (void)jsCallOC:(id)body {
    switch ([self isTypeof:body]) {
        case containerTypeString:
        {
            
        }
            break;
        case containerTypeDictionary:{
            
        }
            break;
        case containerTypeArray:{
            
        }
            break;
        case containerTypeNumber:{
            
        }
            break;
        case containerTypeUndefined:{
            
        }
            break;
            
        default:
            break;
    }
}
 

- (containerType)isTypeof:(id)body {
    
    if ([body isKindOfClass:[NSString class]]) {
        return containerTypeString;
    } else if ([body isKindOfClass:[NSNumber class]]) {
        return containerTypeNumber;
    } else if ([body isKindOfClass:[NSDictionary class]]) {
        return containerTypeDictionary;
    } else if ([body isKindOfClass:[NSArray class]]) {
        return  containerTypeArray;
    } else {
        return containerTypeUndefined;
    }
}

- (void)dismiss {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (WKWebView *)wKWebView {
    if (_wKWebView) {
        return _wKWebView;
    }
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    WKUserContentController *userContenr = [[WKUserContentController alloc]init];
    
    [userContenr addScriptMessageHandler:self name:@"OOCC"];
    
    config.userContentController = userContenr;
    _wKWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    _wKWebView.UIDelegate = self;
    _wKWebView.navigationDelegate = self;
    return _wKWebView;
}

- (UIProgressView *)progress {
    if (!_progress) {
        _progress = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
        _progress.progressTintColor = [UIColor redColor];
        _progress.frame = CGRectMake(0, 64, self.view.width, 5);
    }
    return _progress;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark ----------------------------ScriptMessageHandler
#pragma mark----
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
//    DLog(@"%@",message.body);
    [self jsCallOC:message.body];
}

#pragma mark-WKNavigationDelegateWKNavigationDelegate协议有两大核心部分，第一部分是导航部分，第二部分是页面内监听。
#pragma mark--------------------------------- 页面跳转
#pragma mark 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"%s",__FUNCTION__);
    /**
     *typedef NS_ENUM(NSInteger, WKNavigationActionPolicy) {
     WKNavigationActionPolicyCancel, // 取消
     WKNavigationActionPolicyAllow,  // 继续
     }
     */
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark 身份验证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler {
    completionHandler(NSURLSessionAuthChallengeUseCredential, nil);
}

#pragma mark 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"%s",__FUNCTION__);
    decisionHandler(WKNavigationResponsePolicyAllow);
}

#pragma mark 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
     NSLog(@"%s",__FUNCTION__);
}

#pragma mark WKNavigation导航错误
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
     NSLog(@"%s",__FUNCTION__);
}

#pragma mark WKWebView终止

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"%s",__FUNCTION__);
}


#pragma mark - WKNavigationDelegate 页面加载
#pragma mark 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    DLog(@"");
}

#pragma mark 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    DLog(@"");
}
#pragma mark 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    DLog(@"");
}

#pragma mark 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"%@", error.localizedDescription);
}

#pragma mark --------------------------------UIDelegate
#pragma mark----
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    DLog(@"新建webView");
    return webView;
}
- (void)webViewDidClose:(WKWebView *)webView {
    DLog(@"关闭webView")
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    DLog(@"alert")
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:@"123" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    DLog(@"选择框")
    UIAlertAction *alertActionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }];
    
    UIAlertAction *alertActionOK = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:webView.title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:alertActionCancel];
    [alertController addAction:alertActionOK];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    
    DLog(@"输入框")
    
   
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"123" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alertController.textFields.firstObject;
        UITextField *textField2 = alertController.textFields.lastObject;
        completionHandler([textField.text stringByAppendingString:textField2.text]);
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = defaultText;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       textField.placeholder = @"ssss";
    }];
    [alertController addAction:alertAction];
//    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

@end




