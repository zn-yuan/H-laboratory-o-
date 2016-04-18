//
//  FECollectionViewFlowLayout.m
//  laboratory
//
//  Created by hryan on 16/3/11.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "FECollectionViewFlowLayout.h"

@implementation FECollectionViewFlowLayout


const NSInteger kMaxCellSpacing = 15;


-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray* attributesToReturn = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes* attributes in attributesToReturn) {
        if (nil == attributes.representedElementKind) {
            NSIndexPath* indexPath = attributes.indexPath;
            attributes.frame = [self layoutAttributesForItemAtIndexPath:indexPath].frame;
        }
    }
    return attributesToReturn;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UICollectionViewLayoutAttributes *currentItemAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    if (indexPath.section != 0)
    {
        return currentItemAttributes;
    }
    
    UIEdgeInsets sectionInset = [(UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout sectionInset];
    
    if (indexPath.item == 0) { // first item of section
        CGRect frame = currentItemAttributes.frame;
        frame.origin.x = sectionInset.left+20; // first item of the section should always be left aligned
        currentItemAttributes.frame = frame;
        
        return currentItemAttributes;
    }
    
    NSIndexPath* previousIndexPath = [NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section];
    CGRect previousFrame = [self layoutAttributesForItemAtIndexPath:previousIndexPath].frame;
    CGFloat previousFrameRightPoint = previousFrame.origin.x + previousFrame.size.width + kMaxCellSpacing;
    
    CGRect currentFrame = currentItemAttributes.frame;
    CGRect strecthedCurrentFrame = CGRectMake(0, currentFrame.origin.y, self.collectionView.frame.size.width, currentFrame.size.height);
    
    if ( !CGRectIntersectsRect(previousFrame, strecthedCurrentFrame) )
    {
        CGRect frame = currentItemAttributes.frame;
        frame.origin.x = sectionInset.left;// first item on the line should always be left aligned
        if (frame.origin.x < 20 )
        {
            frame.origin.x = frame.origin.x + 20;
        }
        currentItemAttributes.frame = frame;
        return currentItemAttributes;
    }
    
    CGRect frame = currentItemAttributes.frame;
    frame.origin.x = previousFrameRightPoint;
    currentItemAttributes.frame = frame;
    return currentItemAttributes;
}


@end
