//
//  Man.h
//  laboratory
//
//  Created by hryan on 16/4/8.
//  Copyright © 2016年 fe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Man : NSObject

{
    NSString *_variableString;
}
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *array;

- (NSArray *)allProperty;
- (NSDictionary *)allPropertyNameAndValues;

- (void)allMethods;


@end
