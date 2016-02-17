//
//  webJsVC.m
//  note_oc
//
//  Created by hryan on 16/2/16.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "WebJsVC.h"
#import <WebKit/WebKit.h>

@interface WebJsVC ()<WKScriptMessageHandler>

@property (nonatomic) UIProgressView *progress;
@property (nonatomic) WKWebView *wKWebView;
@property (nonatomic) WKWebsiteDataStore *sss;


@end

@implementation WebJsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)];
    

    
    
#pragma 方法一  加载本地html  加载图片时 if图片和html文件在同一目录下可以直接加载 else 在图片的url上加上相对路径
//    NSString *html = [[NSBundle mainBundle] pathForResource:@"JSAndOC" ofType:@"html"];
//    [self.view addSubview:self.wKWebView];
//    NSURL *url = [NSURL fileURLWithPath:html];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [_wKWebView loadRequest:request];

#pragma  方法二 加载html 本地图片时 必须设置baseURL
    [self.view addSubview:self.wKWebView];
    NSString *baseStr = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/webSource"];
    NSURL *baseURL = [NSURL fileURLWithPath:baseStr];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JSAndOC" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [_wKWebView loadHTMLString:html baseURL:baseURL];
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
    return _wKWebView;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    DLog(@"%@",message.body);
}

@end




