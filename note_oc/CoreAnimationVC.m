//
//  CoreAnimationVC.m
//  note_oc
//
//  Created by hryan on 16/2/15.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "CoreAnimationVC.h"
#import "closeLayerVC.h"
#import "FivePointerStarVC.h"

@interface  CoreAnimationVC() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *subDataSource;

@end


@implementation CoreAnimationVC

static NSString * const kCell = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = @[@"图表抖动效果实现－左上角小黑叉实习(层的使用)",@"五角星"];
    _subDataSource = @[@"closeLayerVC",@"FivePointerStarVC"];
    
    [self.view addSubview:self.tableView];
    
}


- (UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCell];
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    UIViewController *nextVC = [[NSClassFromString(_subDataSource[indexPath.row]) alloc]init];
    
    if (nextVC) {
        [self.navigationController pushViewController:nextVC animated:nil];
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
