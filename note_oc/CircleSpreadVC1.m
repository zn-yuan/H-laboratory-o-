//
//  CircleSpreadVC1.m
//  note_oc
//
//  Created by hryan on 16/2/2.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "CircleSpreadVC1.h"
#import "CircleSpreadVC2.h"
#import "MaskView.h"

@interface CircleSpreadVC1 ()



@end

@implementation CircleSpreadVC1


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic1.jpg"]];
    imageView.frame = self.view.frame;
    [self.view addSubview:imageView];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(56, 150, 40, 40);
    [_button setTitle:@"点击——————" forState: UIControlStateNormal];
    _button.titleLabel.numberOfLines = 0;
    _button.titleLabel.textAlignment = 1;
    _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _button.titleLabel.font = [UIFont systemFontOfSize:12];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    _button.backgroundColor = [UIColor grayColor];
    _button.layer.cornerRadius = 20;
    _button.layer.masksToBounds = YES;
    [self.view addSubview:_button];
    
    UIPanGestureRecognizer *pan =  [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panHandle:)];
    [_button addGestureRecognizer:pan];
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)panHandle:(UIPanGestureRecognizer *)gesture {
    UIView *button = gesture.view;
    CGPoint newCenter =  CGPointMake([gesture translationInView:gesture.view].x + button.center.x , [gesture translationInView:gesture.view].y + button.center.y);
    button.center = newCenter;
    [gesture setTranslation:CGPointZero inView:gesture.view];
}

- (void)present {
    
    CircleSpreadVC2 *VC2 = [[CircleSpreadVC2 alloc]init];
    [self presentViewController:VC2 animated:YES completion:nil];
}



@end
