//
//  moveViewController.h
//  note_oc
//
//  Created by hryan on 16/2/1.
//  Copyright © 2016年 fe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface moveViewController : UIViewController
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSIndexPath* selecedIndexPath;

@end
