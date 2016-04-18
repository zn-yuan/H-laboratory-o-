//
//  CollectionView.m
//  laboratory
//
//  Created by hryan on 16/3/10.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "CollectionView.h"
#import "FEECollectionViewCell.h"
#import "FECollectionViewFlowLayout.h"

@interface CollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic)NSArray *dataSource_first;
@property (nonatomic) UICollectionView *collectionView;

@end

@implementation CollectionView


static NSString *const kCollectionViewCellIdentifier = @"cell1";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil)
    {
        FECollectionViewFlowLayout *layout = [[FECollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = UIColorFromRGB(0XF2F2F2);
        [_collectionView registerClass:[FEECollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
        
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FEECollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.label.text = @"金融服务";
    cell.label.backgroundColor = [UIColor redColor];
    
    return cell;
}

//设置item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    CGSize itemSize = CGSizeMake((FESreen_Width-40)/3, 44);
    CGSize itemSize = CGSizeZero;
    if (indexPath.section == 0)
    {
       CGFloat itemWidth = (KSCREEN_WIDTH-70) /3;
        itemSize = CGSizeMake(itemWidth, 44);
    }
    return itemSize;
}

//设置item的偏移量
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    if (section == 0)
    {
        //  UIEdgeInsets *ed = UIEdgeInsetsMake(CGFloat top, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
        
        edgeInsets = UIEdgeInsetsMake(10, 0, 10, 0);
    }
    return edgeInsets;
}

//设置header

//设置item 的水平间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

//设置 item的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0)
    {
        return 10;
    }
    return 2;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {

    }
    
    if (indexPath.section == 1)
    {
    }
    
    DLog(@"%@",indexPath.description);
}


@end
