
//
//  closeLayer.m
//  note_oc
//
//  Created by hryan on 16/2/15.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "closeLayerVC.h"

@interface closeLayerVC ()

@property (nonatomic) CALayer *closeLayer;
@property (nonatomic) CALayer *redBGLayer;

@end

@implementation closeLayerVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _redBGLayer = [CALayer layer];
    [_redBGLayer setBackgroundColor:[UIColor redColor].CGColor];
    [_redBGLayer setFrame:CGRectMake(50, 100, 100, 100)];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setFrame:CGRectMake(50 , 100 , 100, 100)];
    [button addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view.layer addSublayer:self.redBGLayer];
    [self.view addSubview:button];
    
}


- (void)action {
    [_redBGLayer addSublayer:self.closeLayer];
#warning - (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
    [_closeLayer setNeedsDisplay]; //
    [self.redBGLayer addAnimation:[self shakeAnimation] forKey:nil];
}

- (CALayer *)closeLayer {
    
    CGColorRef white = [UIColor whiteColor].CGColor;
    CGColorRef black = [UIColor blackColor].CGColor;
    
    CALayer *layer = [CALayer layer];
    
    [layer setFrame:CGRectMake(-5.0, - 5.0, 30.0, 30.0)];
    
    [layer setBackgroundColor:black];
    [layer setShadowColor:black];
    [layer setShadowOpacity:1.0];
    [layer setShadowRadius:5.0];
    [layer setBorderColor:white];
    [layer setBorderWidth:3];
    [layer setCornerRadius:15];
#warning - (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
    [layer setDelegate:self];   //
    _closeLayer = layer;
    return layer;
}

#warning - (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 10.0f, 10.0f);
    CGPathAddLineToPoint(path, NULL, 20.0, 20.0);
    CGPathMoveToPoint(path, NULL, 10.0, 20.0);
    CGPathAddLineToPoint(path, NULL, 20.0, 10.0);
    
    CGColorRef white = [UIColor whiteColor].CGColor;
    
    CGContextSetStrokeColorWithColor(ctx, white); //start drawing the path;
    CGContextBeginPath(ctx);
    CGContextAddPath(ctx, path);
    CGPathRelease(path);
    CGContextSetLineWidth(ctx, 3.0);
    CGContextStrokePath(ctx);
   

    
}

- (CAAnimation *)shakeAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    [animation setDuration:0.2];
    [animation setRepeatDuration:1000];
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:DegreesToNumber(2)];
    [values addObject:DegreesToNumber(-2)];
    [values addObject:DegreesToNumber(2)];
    [animation setValues:values];
    return animation;
}

CGFloat DegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;
}

NSNumber * DegreesToNumber (CGFloat degrees) {
    return [NSNumber numberWithFloat:DegreesToRadians(degrees)];
}


@end
