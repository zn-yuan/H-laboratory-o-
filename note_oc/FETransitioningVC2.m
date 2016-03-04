//
//  FEtransitioning2.m
//  note_oc
//
//  Created by hryan on 16/1/27.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "FETransitioningVC2.h"
#import "FE_PresentTransition.h"
#import "FEPercentDrivenInteractive.h"


@interface FETransitioningVC2 () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) FE_PresentTransition *transitionDismiss;
@property (nonatomic, strong) FE_PresentTransition *transitionPresent;
@property (nonatomic, strong) FEPercentDrivenInteractive *panIntrtactiveTransition;


@end

@implementation FETransitioningVC2

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
        _transitionDismiss = [FE_PresentTransition transitionWithTransitionType:FEPresentTransitionDismiss];
        _transitionPresent = [FE_PresentTransition transitionWithTransitionType:FEPresentTransitionPresent];
        _panIntrtactiveTransition = [[FEPercentDrivenInteractive alloc]initWithTransitionType:FEInteractiveTransitionTypeDismiss gestureDirectiopn:FEInteractiveTransitionGestureDirectionDown];
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [_panIntrtactiveTransition addPanGestureForViewController:self];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.transitionDismiss;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.transitionPresent;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return _panIntrtactiveTransition.interation ? _panIntrtactiveTransition : nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    
    FEPercentDrivenInteractive *pre = [_delegate interactiveTransitionForPresent];
    return pre.interation ? pre : nil;
    
}


- (IBAction)dismiss:(id)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(presentedOneControllerPressedDissmiss)]) {
        [_delegate presentedOneControllerPressedDissmiss];
    }
    
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
}
@end
