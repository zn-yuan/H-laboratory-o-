//
//  CircleSpreadVC.h
//  note_oc
//
//  Created by hryan on 16/2/2.
//  Copyright © 2016年 fe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FECircleSpreadTransitionType) {
    FECircleSpreadTransitionTypeDismiss,
    FECircleSpreadTransitionTypePresent
    
};

@interface CircleSpreadTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) FECircleSpreadTransitionType type;

+ (instancetype)circleSpreadWithType:(FECircleSpreadTransitionType)type;

- (instancetype)initWithTransitionType:(FECircleSpreadTransitionType)type;


@end
