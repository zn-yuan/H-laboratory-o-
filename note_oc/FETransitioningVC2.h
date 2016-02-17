//
//  FEtransitioning2.h
//  note_oc
//
//  Created by hryan on 16/1/27.
//  Copyright © 2016年 fe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FETransitioningVC2Delegate <NSObject>

- (void)presentedOneControllerPressedDissmiss;

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent;

@end

@interface FETransitioningVC2 : UIViewController

@property (nonatomic, weak) id<FETransitioningVC2Delegate> delegate;

@end
