//
//  NetTestViewController.m
//  laboratory
//
//  Created by hryan on 16/3/7.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "NetTestViewController.h"

@interface NetTestViewController ()

@end

@implementation NetTestViewController


- (void)dealloc {
    DLog(@"ssss");
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    DLog("111")
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"网络篇";
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/2222"];
    
//    scheme http resourceSpecifier http://www.baidu.com/2222
//    DLog(@"scheme:%@,\n resourceSpecifier:%@",[url scheme],[url resourceSpecifier]);
    NSURLRequest *urlRequest = [[NSURLRequest alloc ]initWithURL:url];
    NSMutableURLRequest *mutableUrlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSURLConnection *connection = [[NSURLConnection alloc]init];
    
    // Do any additional setup after loading the view.
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
