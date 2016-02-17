//
//  FE_Perce.m
//  note_oc
//
//  Created by hryan on 16/1/27.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "FEPercentDrivenInteractive.h"


@interface FEPercentDrivenInteractive ()

@property (nonatomic, weak) UIViewController *VC;

@property (nonatomic, assign) FEInteractiveTransitionGestureDirection direction;

@property (nonatomic, assign) FEInteractiveTransitionType type;

@end

@implementation FEPercentDrivenInteractive

+ (instancetype)interactiveTransitionWithTransitionType:(FEInteractiveTransitionType)type gestureDirectiopn:(FEInteractiveTransitionGestureDirection)direction {
    
    return [[self alloc]initWithTransitionType:type gestureDirectiopn:direction];
    
}

- (instancetype)initWithTransitionType:(FEInteractiveTransitionType)type gestureDirectiopn:(FEInteractiveTransitionGestureDirection)direction {
    
    self = [super init];
    
    if (self) {
        _type = type;
        _direction = direction;
    }
    
    return self;
}

- (void)addPanGestureForViewController:(UIViewController *)viewController {
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    self.VC = viewController;
    [_VC.view addGestureRecognizer:pan];
    
}

- (void)handleGesture:(UIPanGestureRecognizer *)panGesture {
    
    CGFloat persent = 0;
    switch (_direction) {
        case FEInteractiveTransitionGestureDirectionDown:
        {
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.width;
        }
            break;
            
        case FEInteractiveTransitionGestureDirectionUp: {
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.width;
            
        }
            break;
        case FEInteractiveTransitionGestureDirectionLeft: {
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.width;
            
        }
            break;
        case FEInteractiveTransitionGestureDirectionRight: {
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.width;
            
        }
            break;
        default:
            break;
    }
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            self.interation = YES;
            [self startGesture];
        }
            
            break;
        case UIGestureRecognizerStateChanged: {
            [self updateInteractiveTransition:persent];
        }
            break;
        case UIGestureRecognizerStateEnded: {
            self.interation = NO;
            if (persent > 0.5) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
        }
            break;
        case UIGestureRecognizerStateFailed: {
            
        }
            break;
        default:
            break;
    }
    
}

- (void)startGesture {
    switch (_type) {
        case FEInteractiveTransitionTypeDismiss:
        {
            [_VC dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
            break;
        case FEInteractiveTransitionTypePresent: {
            if (_presentConifg) {
                _presentConifg();
            }
        }
            break;
        case FEInteractiveTransitionTypePop:{
            [_VC.navigationController popToRootViewControllerAnimated:YES];
        }
            break;
        default:
            break;
    }
}


@end
