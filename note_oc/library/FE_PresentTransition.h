//
//  FE_PresentTransition.h
//  note_oc
//
//  Created by hryan on 16/1/27.
//  Copyright © 2016年 fe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FEPresentTransitionType) {
    FEPresentTransitionPresent = 0,
    FEPresentTransitionDismiss
};

@interface FE_PresentTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(FEPresentTransitionType)type;

- (instancetype)initWithTransitionType:(FEPresentTransitionType)type;

@end
