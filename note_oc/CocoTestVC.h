//
//  CocoTestVC.h
//  laboratory
//
//  Created by hryan on 16/2/24.
//  Copyright © 2016年 fe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CocoTestVC : UIViewController

@end

@interface Person : NSObject

@property (nonatomic) NSString *name;

+(instancetype)personWithName:(NSString *)name;
- (instancetype)initWithName:(NSString *)name;
- (void)showMess:(id)object;
- (void)show:(id)ss;
@end