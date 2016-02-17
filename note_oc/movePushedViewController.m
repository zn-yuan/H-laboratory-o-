//
//  movePushedViewController.m
//  note_oc
//
//  Created by hryan on 16/2/1.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "movePushedViewController.h"
#import "FENavTransition.h"
#import "FEPercentDrivenInteractive.h"

@interface movePushedViewController ()

@property (nonatomic, strong) FENavTransition *naviTransitionPop;
@property (nonatomic, strong) FENavTransition *naviTransitionPush;
@property (nonatomic, strong) FEPercentDrivenInteractive *interactive;

@end

@implementation movePushedViewController


- (instancetype) init {
    self = [super init];
    if (self) {
        _naviTransitionPush = [FENavTransition transitionWithType:FENavitransitionTypePush];
        _naviTransitionPop = [FENavTransition transitionWithType:FENavitransitionTypePop];
//        self.navigationController.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    _interactive = [[FEPercentDrivenInteractive alloc]initWithTransitionType:FEInteractiveTransitionTypePop gestureDirectiopn:FEInteractiveTransitionGestureDirectionRight];
    [_interactive addPanGestureForViewController:self];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zrx4.jpg"]];
        _imageView.bounds = CGRectMake(0, 0, self.view.width * 0.8, self.view.width * 0.8);
        _imageView.center = self.view.center;
    
    }
    return _imageView;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    return  _interactive.interation ? _interactive : nil;
    
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    return operation == UINavigationControllerOperationNone ? nil : (operation == UINavigationControllerOperationPop ? _naviTransitionPop : _naviTransitionPush);
}

@end
