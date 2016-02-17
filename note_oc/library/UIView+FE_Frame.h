//
//  UIView+FE_Frame.h
//  note_oc
//
//  Created by hryan on 16/1/26.
//  Copyright © 2016年 fe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FE_Frame)

@property(assign, nonatomic) float x , y, width, height;

@end

@interface UIScreen (FE_Frame)

@property (assign, nonatomic, readonly) float width, height;

@end