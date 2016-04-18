//
//  CollectionViewCell.swift
//  laboratory
//
//  Created by hryan on 16/3/10.
//  Copyright © 2016年 fe. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var label:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel(frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel(frame:CGRect){
        self.label = UILabel(frame:frame)
        label.textColor = UIColor.grayColor()
        label.layer.borderWidth = 1;
        label.layer.borderColor = UIColor.darkGrayColor().CGColor
        self.contentView.addSubview(self.label)
    }
    
}
