//
//  CircleSpreadVC2.m
//  note_oc
//
//  Created by hryan on 16/2/2.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "CircleSpreadVC2.h"
#import "CircleSpreadTransition.h"

@interface CircleSpreadVC2 ()<UIViewControllerTransitioningDelegate>

@property (nonatomic) CircleSpreadTransition *dismiss;
@property (nonatomic) CircleSpreadTransition *present;

@end

@implementation CircleSpreadVC2

- (instancetype)init {
    self = [super init];
    if (self) {
        _dismiss = [CircleSpreadTransition circleSpreadWithType:FECircleSpreadTransitionTypeDismiss];
        _present = [CircleSpreadTransition circleSpreadWithType:FECircleSpreadTransitionTypePresent];
        self.transitioningDelegate = self;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    imageView.image = [UIImage imageNamed:@"pic2.jpeg"];
    [self.view addSubview:imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissHandle:)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tap];
    
 }


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return _present;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return _dismiss;
}


- (void)dismissHandle:(UITapGestureRecognizer *)tap {
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
