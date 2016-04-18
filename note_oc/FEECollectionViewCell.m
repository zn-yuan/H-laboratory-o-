//
//  FECollectionViewCell.m
//  laboratory
//
//  Created by hryan on 16/3/11.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "FEECollectionViewCell.h"

@implementation FEECollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:self.frame];
        _label.textColor = [UIColor grayColor];
        _label.layer.borderColor = [UIColor darkGrayColor].CGColor;
        [self.contentView addSubview:self.label];
    }
    return _label;
}




@end
