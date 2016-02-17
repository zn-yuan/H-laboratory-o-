//
//  ViewController.m
//  note_oc
//
//  Created by hryan on 16/1/5.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "ViewController.h"
#import "FETransitioningVC.h"
#import "moveViewController.h"
#import "CircleSpreadVC1.h"
#import "CoreAnimationVC.h"
#import "WebJsVC.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic) NSArray *subData;

@end

@implementation ViewController


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    DLog("111")
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DLog("111")
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIDevice *dev = [UIDevice currentDevice];
    
    _data = @[@"模态",@"navMove",@"circleSpread",@"shakeAnimation",@"WebJsVC"];
    _subData = @[@"",@"moveViewController",@"CircleSpreadVC1",@"CoreAnimationVC",@"WebJsVC"];
    NSLog(@"%@",dev.identifierForVendor);
    DLog(@"%@",dev.systemVersion);
    DLog(@"%@",dev.localizedModel);

    DLog(@"name %@",dev.name);
    DLog(@"proximityState %d",dev.proximityState);
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -----ssss

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *nextVC = nil;

    if (indexPath.row == 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        nextVC = [storyboard instantiateViewControllerWithIdentifier:@"FETransitioningVC"];
    } else {
        nextVC = [[NSClassFromString(_subData[indexPath.row]) alloc]init];
    }
    
//    switch (indexPath.row) {
//        case 0:
//        {
//            
//            
//        }
//            break;
//        case 1: {
//            nextVC = [[moveViewController alloc]init];
//        }
//            break;
//        case 2: {
//            nextVC = [[CircleSpreadVC1 alloc]init];
//        }
//            break;
//       
//        default:
//            break;
//    }
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:nextVC];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
