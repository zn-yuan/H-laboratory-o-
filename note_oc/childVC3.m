//
//  childVC3.m
//  laboratory
//
//  Created by hryan on 16/2/18.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "childVC3.h"

@interface childVC3 ()

@end

@implementation childVC3
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"333333";
    self.view.backgroundColor = [UIColor yellowColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 130, 50)];
    label.text = @"3333";
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
    [super viewDidAppear:animated];
    DLog(@"viewWillAppear -> %@", self);
}

-( void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    DLog(@"viewDidDisappear -> %@", self);
}


@end
