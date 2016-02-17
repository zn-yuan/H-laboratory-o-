//
//  FENavTransition.m
//  note_oc
//
//  Created by hryan on 16/2/1.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "FENavTransition.h"
#import "movePushedViewController.h"
#import "moveViewController.h"
#import "CollectionViewCell.h"

@interface FENavTransition()

@property (nonatomic, assign) FENaviTransitionType type;

@end

@implementation FENavTransition

- (instancetype) initWithTransitionType:(FENaviTransitionType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

+ (instancetype)transitionWithType:(FENaviTransitionType)type{
    return [[self alloc]initWithTransitionType:type];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.75;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case FENavitransitionTypePop:{
            [self doPopAnimation:transitionContext];
        }
            
            break;
        case FENavitransitionTypePush: {
            [self doPushAnimation:transitionContext];
        }
            break;
        default:
            break;
    }

}

- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    moveViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    movePushedViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CollectionViewCell *cell = (CollectionViewCell *)[fromVC.collectionView cellForItemAtIndexPath:fromVC.selecedIndexPath];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = [cell.contentView snapshotViewAfterScreenUpdates:NO];
    DLog(@"%@",tempView);
    DLog(@"cell-%@",cell);
//             把一个视图的坐标系转移到另一个视图中；[cell.contentView convertRect:cell.contentView.bounds toView:containerView]
//    [cell.contentView.superView? convertRect:cell.contentView.frame toView:containerView]
    tempView.frame = [cell.contentView convertRect:cell.contentView.bounds toView:containerView];
    cell.imageView.hidden = YES;
    toVC.view.alpha = 0;
    toVC.imageView.hidden = YES;
    
    [containerView addSubview:tempView];
    [containerView insertSubview:toVC.view belowSubview:tempView]; //把toView.view 插到tempView下面

    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1/0.55 options:0 animations:^{
        
        tempView.frame = [toVC.imageView convertRect:toVC.imageView.bounds toView:containerView];
        toVC.view.alpha = 1;

    } completion:^(BOOL finished) {
//        [tempView removeFromSuperview];
        tempView.hidden = YES;
        toVC.imageView.hidden = NO;
        [transitionContext completeTransition:YES];
    }];
    
}

- (void)doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {

    movePushedViewController *fromVC = (movePushedViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    moveViewController *toVC = (moveViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CollectionViewCell *cell = (CollectionViewCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.selecedIndexPath];
    UIView *containerView = [transitionContext containerView];
    //这里的lastView就是push时候初始化的那个tempView
    UIView *tempView = containerView.subviews.lastObject;
    //设置初始状态
    cell.imageView.hidden = YES;
    fromVC.imageView.hidden = YES;
    tempView.hidden = NO;
    [containerView insertSubview:toVC.view atIndex:0];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:0 animations:^{
        tempView.frame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        //由于加入了手势必须判断
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {//手势取消了，原来隐藏的imageView要显示出来
            //失败了隐藏tempView，显示fromVC.imageView
            tempView.hidden = YES;
            fromVC.imageView.hidden = NO;
        }else{//手势成功，cell的imageView也要显示出来
            //成功了移除tempView，下一次pop的时候又要创建，然后显示cell的imageView
            cell.imageView.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];

    
}






@end
