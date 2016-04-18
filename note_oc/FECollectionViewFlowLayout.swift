//
//  FECollectionViewFlowLayout.swift
//  laboratory
//
//  Created by hryan on 16/3/10.
//  Copyright © 2016年 fe. All rights reserved.
//

import UIKit

let kMaxCellSpacing: CGFloat = 5

class FECollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let attributesToReturn = super.layoutAttributesForElementsInRect(rect)
        
        for attributes in attributesToReturn!{
//            if  nil == attributes.representedElementKind {
//                
//            }
            let indexPath = attributes.indexPath
            attributes.frame = (self.layoutAttributesForItemAtIndexPath(indexPath)?.frame)!;
        }
        
        return attributesToReturn
    }
    
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
       let currentIntemAttributes =  super.layoutAttributesForItemAtIndexPath(indexPath)
        
        if(indexPath.section == 1 || indexPath.section == 2){
            return currentIntemAttributes
        }
        
        let sectionInset = ( self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
        if(indexPath.item == 0) {
            var frame = currentIntemAttributes?.frame
            frame?.origin.x = sectionInset.left + 20
            frame?.origin.y = sectionInset.top + 10
            currentIntemAttributes?.frame = frame!
            return currentIntemAttributes
        }
        
        let previousIndexpath = NSIndexPath(forItem: (indexPath.item-1), inSection: indexPath.section)
        
        let previousFrame = super.layoutAttributesForItemAtIndexPath(previousIndexpath)?.frame
        let previousFrameRightPoint = (previousFrame?.size.width)! + kMaxCellSpacing + (previousFrame?.origin.x)!
        let currentFrame = currentIntemAttributes?.frame
        let strecthedCurrentFrame = CGRectMake(0, currentFrame!.origin.y, (self.collectionView?.frame.size.width)!, currentFrame!.size.height)
        
        
        if (!CGRectIntersectsRect(previousFrame!, strecthedCurrentFrame)) {
            var frame = currentIntemAttributes?.frame
            frame?.origin.x = sectionInset.left
            
            if(frame?.origin.x < 10) {
                frame?.origin.x = (frame?.origin.x)! + 10
            }
            currentIntemAttributes?.frame = frame!
            return currentIntemAttributes
        }
        
        var frame = currentIntemAttributes?.frame
        frame?.origin.x = previousFrameRightPoint
//        frame?.origin.y = (previousFrame?.origin.y)!
        currentIntemAttributes?.frame = frame!
        return currentIntemAttributes
        
    }
    
}
