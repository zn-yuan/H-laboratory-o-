//
//  moveViewController.m
//  note_oc
//
//  Created by hryan on 16/2/1.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "moveViewController.h"
#import "movePushedViewController.h"
#import "CollectionViewCell.h"



@interface moveViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, UINavigationControllerDelegate>

@end

@implementation moveViewController

static  NSString *const kCollectionViewCell = @"CollectionCell";

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    DLog("swww")
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DLog("1ss1")
}
- (void)viewDidLoad {
    
    [self.view addSubview:self.collectionView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(changeLayout)]];
}

- (void)changeLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake(200, 200);
    _collectionView.collectionViewLayout = layout;
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = CGSizeMake(150, 100);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCell];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
    
}

#pragma mark-----------collectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 100;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCell forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"%ld",(long)indexPath.row)
    
    _selecedIndexPath = indexPath;
    movePushedViewController *pushVC = [[movePushedViewController alloc]init];
    self.navigationController.delegate = pushVC;
    [self.navigationController pushViewController:pushVC animated:YES];
}


@end









