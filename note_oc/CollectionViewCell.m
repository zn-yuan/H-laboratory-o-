//
//  CollectionViewCell.m
//  note_oc
//
//  Created by hryan on 16/2/1.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()




@end


@implementation CollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    return self;
}

- (instancetype)init {
    self = [super init];
//    DLog(@"13")
    return  self;
}

- (void)willRemoveSubview:(UIView *)subview {
   
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zrx4.jpg"]];
        _imageView.frame = self.contentView.frame;
    }
    return _imageView;
}

- (void)didAddSubview:(UIView *)subview {
    
    [super didAddSubview:subview];
    
    DLog(@"14")
  
    [self.contentView addSubview:self.imageView];
   
}



@end
