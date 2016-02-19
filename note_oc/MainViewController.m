//
//  MainViewController.m
//  laboratory
//
//  Created by hryan on 16/2/18.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"

@interface MainViewController ()

//@property (nonatomic) UIViewController *rootVC;

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    _rootVC = window.rootViewController;
//    window.rootViewController = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
      self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)];
    
    UIViewController *test1 = [[ViewController1 alloc]init];
    test1.tabBarItem.title = @"title1";
    test1.tabBarItem.image = [UIImage imageNamed:@"qq"];
    
    UIViewController *test2 = [[ViewController2 alloc]init];
    test2.tabBarItem.title = @"title2";
    test2.tabBarItem.image = [UIImage imageNamed:@"qq"];
    
    NSArray *VCs = @[test1,test2];
    [self setViewControllers:VCs];
    
    // Do any additional setup after loading the view.
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
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
