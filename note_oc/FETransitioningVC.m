//
//  FETransitioningVC.m
//  note_oc
//
//  Created by hryan on 16/1/27.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "FETransitioningVC.h"
#import "FETransitioningVC2.h"
#import "FEPercentDrivenInteractive.h"
#import "FE_PresentTransition.h"


@interface FETransitioningVC ()<FETransitioningVC2Delegate>

@property (nonatomic, strong) FEPercentDrivenInteractive *interactivePush;

@end

@implementation FETransitioningVC


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back)];
    
    _interactivePush = [FEPercentDrivenInteractive interactiveTransitionWithTransitionType:FEInteractiveTransitionTypePresent gestureDirectiopn:FEInteractiveTransitionGestureDirectionUp];
    FEWeakSelf(weakSelf);

    _interactivePush.presentConifg = ^(){
        [weakSelf present];
    };
    [_interactivePush addPanGestureForViewController:self];
    
}


- (void)present {
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     FETransitioningVC2 *VC2 = [storyboard instantiateViewControllerWithIdentifier:@"FETransitioningVC2"];
    VC2.delegate = self;
   [self presentViewController:VC2 animated:YES completion:nil];
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@".....");
    FETransitioningVC2 *vc =
    segue.destinationViewController;
    vc.delegate = self;
}

- (void)presentedOneControllerPressedDissmiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id <UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent{
    return _interactivePush;
}

#pragma mark-------






//- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
//    
//    return self.panIntrtactiveTransition;
//}


@end
