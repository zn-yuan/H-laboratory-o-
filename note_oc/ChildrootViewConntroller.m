//
//  rootViewConntroller.m
//  laboratory
//
//  Created by hryan on 16/2/18.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "ChildrootViewConntroller.h"
#import "childVC1.h"
#import "childVC2.h"
#import "childVC3.h"

@interface ChildrootViewConntroller ()

@property (nonatomic) UIViewController * currentVC;
@property (nonatomic) UIView *contentView;
@property (nonatomic) UIScrollView *headScrollView;

@property (nonatomic) NSMutableArray *itemArray;

@end

@implementation ChildrootViewConntroller


- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"首页";
    
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)];
    
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(click)];
     _itemArray = [NSMutableArray arrayWithObjects:@"头条",@"今日",@"焦点", nil];
    [self loadBaseUI];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addChildViewControllers];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)click {
//    [self.childViewControllers.lastObject willMoveToParentViewController:nil];
//    [self.childViewControllers.lastObject.view removeFromSuperview];
//    [self.childViewControllers.lastObject removeFromParentViewController];
//    
}

- (void)loadBaseUI {
   
    _headScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 44)];
    _headScrollView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    for (int i = 0; i<_itemArray.count; i++) {
        UIButton *itemButton = [[UIButton alloc]initWithFrame:CGRectMake(i*([UIScreen mainScreen].bounds.size.width/_itemArray.count), 0, [UIScreen mainScreen].bounds.size.width/_itemArray.count, 44)];
        itemButton.tag = 100+i;
        itemButton.backgroundColor = [UIColor clearColor];
        NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor purpleColor],NSFontAttributeName:[UIFont systemFontOfSize:14.0f]};
        [itemButton setAttributedTitle:[[NSAttributedString alloc]initWithString:_itemArray[i] attributes:dic] forState:UIControlStateNormal];
        [itemButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headScrollView addSubview:itemButton];
    }
    [_headScrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 44)];
    _headScrollView.showsHorizontalScrollIndicator = NO;
    _headScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_headScrollView];
    
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 108, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44 - 64)];
    _contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_contentView];
    
//    [self addSubControllers];
}

- (void)addChildViewControllers {
    
    NSArray *array = @[@"childVC1",@"childVC2",@"childVC3"];
    
    for (NSString *VCName in array) {
        UIViewController *vc = [[NSClassFromString(VCName) alloc]init];
        [self addChildViewController:vc];
    }
    
#pragma mark--------我们调用[父视图控制器 addChildViewController:子视图控制器]时，[子视图控制器 willMoveToParentViewController:父视图控制器]已经默认调用了。只需要在transitionFromViewController方法后，调用[子视图控制器didMoveToParentViewController:父视图控制器];
    
    
#pragma mark -----我们调用  [子视图控制器 removeFromParentViewController]时，已经默认调用了[子视图控制器 didMoveToParentViewController:父视图控制器]。    只需要在transitionFromViewController方法之前调用：[子视图控制器willMoveToParentViewController:nil]。
    

    [self.childViewControllers.firstObject didMoveToParentViewController:self];
    [self.contentView addSubview:self.childViewControllers.firstObject.view];
    _currentVC = self.childViewControllers.firstObject;
    
}

- (void)buttonClick:(UIButton *)sender{
    UIViewController *_firstVC =  self.childViewControllers.firstObject;
     UIViewController *_secondVC = self.childViewControllers[1];
     UIViewController *_thirdVC = self.childViewControllers.lastObject;
    if ((sender.tag == 100 && _currentVC == self.childViewControllers.firstObject ) || (sender.tag == 101 && _currentVC == _secondVC) || (sender.tag == 102 && _currentVC == _thirdVC)) {
        return;
    }
    switch (sender.tag) {
        case 100:{
            [self fitFrameForChildViewController:_firstVC];
            [self transitionFromOldViewController:_currentVC toNewViewController:_firstVC];
        }
            break;
        case 101:{
            [self fitFrameForChildViewController:_secondVC];
            [self transitionFromOldViewController:_currentVC toNewViewController:_secondVC];
        }
            break;
        case 102:{
            [self fitFrameForChildViewController:_thirdVC];
            [self transitionFromOldViewController:_currentVC toNewViewController:_thirdVC];
        }
            break;
    }
}

- (void)fitFrameForChildViewController:(UIViewController *)chileViewController{
    CGRect frame = self.contentView.frame;
    frame.origin.y = 0;
    chileViewController.view.frame = frame;
}

- (void)transitionFromOldViewController:(UIViewController *)oldViewController toNewViewController:(UIViewController *)newViewController{
    [self transitionFromViewController:oldViewController toViewController:newViewController duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newViewController didMoveToParentViewController:self];
            _currentVC = newViewController;
        }else{
            _currentVC = oldViewController;
        }
    }];
}





@end
