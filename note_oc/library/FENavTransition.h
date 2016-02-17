//
//  FENavTransition.h
//  note_oc
//
//  Created by hryan on 16/2/1.
//  Copyright © 2016年 fe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FENaviTransitionType) {
    FENavitransitionTypePush = 0,
    FENavitransitionTypePop
};

@interface FENavTransition : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithType:(FENaviTransitionType)type;
- (instancetype)initWithTransitionType:(FENaviTransitionType)type;

@end
