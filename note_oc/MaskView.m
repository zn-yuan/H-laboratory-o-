//
//  maskView.m
//  note_oc
//
//  Created by hryan on 16/2/2.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "MaskView.h"

@interface MaskView ()

@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation MaskView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initImageView];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initImageView];
    }
    return self;
}

- (void) initImageView {
    _imageView = [[UIImageView alloc]initWithFrame:self.frame];
    [self addSubview:_imageView];
 }


- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"pic1.jpg"];
    CGFloat imageWidth = KSCREEN_WIDTH;
    CGFloat imageHeight = KSCREEN_HEIGHT;
    
    DLog(@"%f",imageHeight)
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    UIGraphicsBeginImageContext(CGSizeMake(150, 200));
    CGContextTranslateCTM(currentContext, 0, - imageHeight);
    CGContextScaleCTM(currentContext, 1, -1);
    CGContextDrawImage(currentContext, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    UIImage *desimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _imageView.image = desimage;
 
    
}



@end
