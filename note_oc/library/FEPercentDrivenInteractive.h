//
//  FE_Perce.h
//  note_oc
//
//  Created by hryan on 16/1/27.
//  Copyright © 2016年 fe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GestureConifg)();

typedef NS_ENUM(NSInteger, FEInteractiveTransitionGestureDirection) {
    FEInteractiveTransitionGestureDirectionLeft = 0,
    FEInteractiveTransitionGestureDirectionRight,
    FEInteractiveTransitionGestureDirectionUp,
    FEInteractiveTransitionGestureDirectionDown
};

typedef NS_ENUM(NSInteger, FEInteractiveTransitionType) {
    FEInteractiveTransitionTypeDismiss = 0,
    FEInteractiveTransitionTypePresent,
    FEInteractiveTransitionTypePop
};

@interface FEPercentDrivenInteractive : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interation;
@property (nonatomic, copy) GestureConifg presentConifg;
@property (nonatomic, copy) GestureConifg pushConifg;

+ (instancetype)interactiveTransitionWithTransitionType:(FEInteractiveTransitionType)type gestureDirectiopn:(FEInteractiveTransitionGestureDirection)direction;

- (instancetype)initWithTransitionType:(FEInteractiveTransitionType)type gestureDirectiopn:(FEInteractiveTransitionGestureDirection)direction;

- (void)addPanGestureForViewController:(UIViewController *)viewController;

@end
