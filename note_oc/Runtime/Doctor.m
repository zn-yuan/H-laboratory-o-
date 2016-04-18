//
//  Doctor.m
//  laboratory
//
//  Created by hryan on 16/4/18.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "Doctor.h"

@implementation Doctor

- (void)operate2{
    DLog(@"doctor'operate")
}

- (void)operate3{
    DLog(@"%@'s %s",self, sel_getName(_cmd))
}

@end
