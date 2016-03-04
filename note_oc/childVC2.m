//
//  childVC2.m
//  laboratory
//
//  Created by hryan on 16/2/18.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "childVC2.h"

@interface childVC2 ()

@end

@implementation childVC2
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"22222";
    self.view.backgroundColor = [UIColor redColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 130, 50)];
    label.text = @"2222";
    [self.view addSubview:label];
}

-( void)willMoveToParentViewController:(UIViewController *)parent
{
    [super willMoveToParentViewController: parent];
    DLog(@"willMoveToParentViewController -> %@", self);
}

-( void) didMoveToParentViewController:(UIViewController *)parent
{
    [super didMoveToParentViewController: parent];
    DLog(@"didMoveToParentViewController -> %@", self);
}

-( void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DLog(@"viewWillAppear -> %@", self);
}

-( void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    DLog(@"viewDidDisappear -> %@", self);
}

@end
