//
//  RuntimeViewController.m
//  laboratory
//
//  Created by hryan on 16/4/8.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "RuntimeViewController.h"
#import <objc/objc-runtime.h>
#import "Man.h"

@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Man *p = [[Man alloc] init];
    p.name = @"lili";
    size_t size = class_getInstanceSize(p.class);
    NSLog(@"size=%ld",size);
    
    for(NSString *propertyName in p.allProperty){
        NSLog(@"%@",propertyName);
    }
    
    for (NSString *name in p.array) {
        NSLog(@"ivar:%@",name);
    }
    
    for (NSString *key  in p.allPropertyNameAndValues.allKeys) {
        NSLog(@"key:%@,value=%@",key,p.allPropertyNameAndValues[key]);
    }
//    [p allMethods];
    
    
    objc_msgSend(p, @selector(setName:),@"job");
    DLog(@"%@",p.name)
    
//    objc_getClass(<#const char *name#>)
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
