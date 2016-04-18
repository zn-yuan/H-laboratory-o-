//
//  TestThreadViewController.m
//  laboratory
//
//  Created by hryan on 16/3/4.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "TestThreadViewController.h"
#import <objc/objc-runtime.h>

@interface TestThreadViewController ()

@end

@implementation TestThreadViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"线程测试";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)];
    SEL selector = @selector(main);
    objc_msgSend(self,selector);
    
    // Do any additional setup after loading the view.
}



- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)main{
    dispatch_queue_t main = dispatch_get_main_queue();
    dispatch_async(main, ^{
            DLog(@"%@",[NSThread currentThread])
    });
    
    /*创建一个串行队列
     第一个参数：队列名称
     第二个参数：队列类型
     */
    dispatch_queue_t dss = dispatch_queue_create("myThreadQueue1", DISPATCH_QUEUE_SERIAL);
    
    for (int i =  1; i<2; i++) {
        dispatch_sync(dss, ^{
            NSLog(@"串行同步:%d,----%@，name:%@",i,[NSThread currentThread],[NSThread currentThread]);
        });
    }
    
    for (int i =  1; i<2; i++) {
        dispatch_async(dss, ^{
            NSLog(@"串行异步:%d,----%@，name:%@",i,[NSThread currentThread],[NSThread currentThread]);
        });
    }
    
    
    dispatch_queue_t concurrent = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    
    
    for (int i =  1; i<2; i++) {
        dispatch_async(concurrent, ^{
            NSLog(@"并行异步:%d,----%@，name:%@",i,[NSThread currentThread],[NSThread currentThread]);
        });
    }
    for (int i =  1; i<4; i++) {
        dispatch_sync(concurrent, ^{
            NSLog(@"并行同步:%d,----%@，name:%@",i,[NSThread currentThread],[NSThread currentThread]);
        });
    }
    for (int i =  1; i<3; i++) {
        dispatch_sync(concurrent, ^{
            NSLog(@"并行同步2:%d,----%@，name:%@",i,[NSThread currentThread],[NSThread currentThread]);
        });
    }
    
    
    
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
