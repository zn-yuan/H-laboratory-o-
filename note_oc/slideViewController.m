//
//  slideViewController.m
//  laboratory
//
//  Created by hryan on 16/2/18.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "slideViewController.h"
#import "MainViewController.h"
#import "LeftViewController.h"
#import "SwiftBridging-swift.h"

@interface slideViewController ()

@property (nonatomic) MainViewController *MainViewController;
@property (nonatomic) UIViewController *leftViewController;
@property (nonatomic) rightViewController *rightViewController;
@property (nonatomic) UIView *containerView;

@end

@implementation slideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftShow = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)];
    UIBarButtonItem *dismiss = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(dismiss2)];
    
    self.navigationItem.leftBarButtonItems = @[dismiss,leftShow];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(click)];
    
    [self setSubViews];
}

- (void)dismiss2 {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismiss {
    self.containerView.center = CGPointMake(KSCREEN_WIDTH, _containerView.center.y);
}

- (void) click {
    self.containerView.center = CGPointMake(0, _containerView.center.y);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSubViews {
    _containerView = [[UIView alloc]init];
    _containerView.frame = self.view.frame;
    [self.view addSubview:_containerView];
    
    _MainViewController = [[ MainViewController alloc]init];
    
   _leftViewController = [[LeftViewController alloc] init];
    
    _rightViewController = [[rightViewController alloc] init];
    
    
    [self.containerView addSubview:_MainViewController.view];
    [self.containerView addSubview:_leftViewController.view];
    [self.containerView addSubview:_rightViewController.view];
    [self.containerView addSubview:((UINavigationController *)self.parentViewController).navigationBar];
    [self.containerView addSubview:_MainViewController.tabBar];
    
    
    _leftViewController.view.center = CGPointMake( - KSCREEN_WIDTH/2, KSCREEN_HEIGHT/2);
    _rightViewController.view.center = CGPointMake(KSCREEN_WIDTH/2 + KSCREEN_WIDTH, KSCREEN_HEIGHT/2);
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    
    [self.MainViewController.view addGestureRecognizer:tapGestureRecognizer];

}

- (void)action:(UITapGestureRecognizer *)tapGestureRecognizer {
    
    self.containerView.center = CGPointMake(KSCREEN_WIDTH/2, _containerView.center.y);
//    float x = [panGestureRecognizer translationInView:panGestureRecognizer.view].x;
//    panGestureRecognizer.view.center = CGPointMake(self.view.center.x + x, panGestureRecognizer.view.center.y);
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
