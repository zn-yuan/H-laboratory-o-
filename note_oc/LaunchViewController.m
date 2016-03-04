//
//  LaunchViewController.m
//  laboratory
//
//  Created by hryan on 16/3/1.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "LaunchViewController.h"
#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface LaunchViewController ()<WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic) WKWebView *webView;
@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSURL *url = [[NSBundle mainBundle]URLForResource:@"Launch" withExtension:@"html" subdirectory:@"webSource"];
//    DLog(@"url:%@",url.absoluteString);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Launch" ofType:@"html" inDirectory:@"webSource"];
    
//    DLog(@"%@",path);
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL fileURLWithPath:path]];
    DLog(@"NSURLRequest:%@",request.URL.absoluteString);
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
    // Do any additional setup after loading the view.
}

- (WKWebView*)webView {
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
        WKUserContentController *userContent = [[WKUserContentController alloc]init];
        [userContent addScriptMessageHandler:self name:@"launchEnd"];
        config.userContentController = userContent;
        
        _webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:config];
        _webView.navigationDelegate = self;
        _webView.scrollView.scrollEnabled = NO;
    }
    return _webView;
}


- (void)resetRootViewController{
    ViewController *vc = [[ViewController alloc]init];
    DLog(@"%@",self.parentViewController);
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
}


#pragma mark ----------------------------ScriptMessageHandler
#pragma mark----
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([message.name isEqualToString: @"launchEnd"]) {
        [self resetRootViewController];
    }
        DLog(@"body:%@---------frameInfo:%@----------name:%@",message.body,message.frameInfo,message.name);
//    [self jsCallOC:message.body];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
