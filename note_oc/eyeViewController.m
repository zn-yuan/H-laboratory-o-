//
//  eyeViewController.m
//  laboratory
//
//  Created by hryan on 16/2/19.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "eyeViewController.h"
#import "EyeView.h"

@interface eyeViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic) UITableView *tableView;

@property (nonatomic) EyeView *eyeView;
@end

@implementation eyeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.view addSubview:self.tableView];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 200, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
    scrollView.delegate = self;
   
//    [self.view addSubview:scrollView];
    
    [self.view addSubview:self.eyeView];
}

- (EyeView *)eyeView {
    if (!_eyeView) {
        _eyeView = [[EyeView alloc]initWithFrame:CGRectMake(0, 64, KSCREEN_WIDTH, 80)];
        _eyeView.backgroundColor = [UIColor darkGrayColor];
    }
    return _eyeView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, 144, KSCREEN_WIDTH, KSCREEN_HEIGHT);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.eyeView animationWith:scrollView.contentOffset.y];
}

#pragma mark-- UITableViewDataSource, UITableViewDelegate
#pragma mark-----

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text =  [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}



@end
