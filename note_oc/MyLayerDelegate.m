//
//  MyLayerDelegate.m
//  laboratory
//
//  Created by hryan on 16/2/26.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "MyLayerDelegate.h"
#import <objc/objc-api.h>

@interface MyLayerDelegate ()
@property (nonatomic, assign) UIView *view;
@property (nonatomic, strong) UIViewController *viewContrller;
@end

@implementation MyLayerDelegate


- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        _view = view;
    }
    return self;
}

- (instancetype)initWithViewController:(UIViewController *)viewController {
    self = [super init];
    if (self) {
        _viewContrller = viewController;
    }
    return self;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    NSString *methodName = [NSString stringWithFormat:@"draw%@Layer:inContext:",layer.name];
    
    SEL selector = NSSelectorFromString(methodName);
    
    if (_viewContrller) {
        if (![self.viewContrller respondsToSelector:selector]) {
            selector = @selector(drawLayer:inContext:);
        }
        void (*drawLayer)(UIViewController *, SEL, CALayer *, CGContextRef) = (__typeof__(drawLayer))objc_msgSend;
        drawLayer(self.viewContrller, selector, layer, ctx);
        return;
    }
    if (![self.view respondsToSelector:selector]) {
        selector = @selector(drawLayer:inContext:);
    }
    
#pragma mark-----------------------------------------
#pragma mark---
//    NSMethodSignature * signature = [[_view class] instanceMethodSignatureForSelector:selector];
//    NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
//    
//    [invocation setTarget:_view];             // Actually index 0
//    [invocation setSelector:selector];        // Actually index 1
//    
//    [invocation setArgument:&layer atIndex:2];
//    [invocation setArgument:&ctx atIndex:3];
//    
//    [invocation invoke];

    void (*drawLayer)(UIView *, SEL, CALayer *, CGContextRef) = (__typeof__(drawLayer))objc_msgSend;
    drawLayer(self.view, selector, layer, ctx);
}

@end
