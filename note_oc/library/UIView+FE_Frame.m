//
//  UIView+FE_Frame.m
//  note_oc
//
//  Created by hryan on 16/1/26.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "UIView+FE_Frame.h"

@implementation UIView (FE_Frame)

//@dynamic x, y, height, width;

- (float)x {
    return self.frame.origin.x;
}

- (float)y {
    return self.frame.origin.y;
}
- (float)height {
    return self.frame.size.height;
}
- (float)width {
    return self.frame.size.width;
}

- (void)setX:(float)x {
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}

- (void) setY:(float)y {
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}

- (void) setHeight:(float)height {
    self.frame = CGRectMake(self.x, self.y, self.width, height);
}

- (void) setWidth:(float)width {
    self.frame = CGRectMake(self.x, self.y, width, self.height);
}

@end

@implementation UIScreen (FE_Frame)

- (float)height {
    return self.bounds.size.height;
}
- (float)width {
    return self.bounds.size.width;
}

@end

