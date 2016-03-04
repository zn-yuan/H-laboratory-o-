//
//  chidVC1.m
//  laboratory
//
//  Created by hryan on 16/2/18.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "childVC1.h"

@interface childVC1 ()

@end

@implementation childVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"111111";
    self.view.backgroundColor = [UIColor lightGrayColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 130, 50)];
    label.text = @"1111";
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
