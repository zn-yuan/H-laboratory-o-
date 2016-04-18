//
//  Man.m
//  laboratory
//
//  Created by hryan on 16/4/8.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "Man.h"
#import <objc/runtime.h>

@implementation Man


- (NSArray *)allProperty {
    
    unsigned int count;
   
    objc_property_t *property = class_copyPropertyList([self class], &count);
   
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger i = 0; i<count; i++) {
        const char *propertyName = property_getName(property[i]);
        const char *arrtibutesC = property_getAttributes(property[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        NSString *arrtibutes = [NSString stringWithUTF8String:arrtibutesC];
        
        [propertiesArray addObject:name];
        [propertiesArray addObject:arrtibutes];
    }
    
   
    
    free(property);
    return propertiesArray;
}

- (NSDictionary *)allPropertyNameAndValues {
   
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    
    unsigned int count;
    
    objc_property_t *property = class_copyPropertyList([self class], &count);
    
    
    for (NSUInteger i = 0; i<count; i++) {
        const char *propertyName = property_getName(property[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        id propertyValue = [self valueForKey:name];
        if (propertyValue && propertyValue != nil) {
            [resultDict setObject:propertyValue forKey:name];
        }
        
    }
    
    
    
    free(property);
    return resultDict;
}

- (NSMutableArray *)array{
    if (!_array) {
         unsigned int iCount;
         Ivar *ivar = class_copyIvarList([self class], &iCount);
        _array = [NSMutableArray arrayWithCapacity:iCount];
        for (NSUInteger i = 0; i<iCount; i++) {
            const char * ivarName = ivar_getName(ivar[i]);
            NSString *name = [NSString stringWithUTF8String:ivarName];
            [_array addObject:name];
        }
        free(ivar);
    }
   
    return _array;
}

- (void)allMethods {
    unsigned int count;
    Method *methods = class_copyMethodList([self class], &count);
    for (NSUInteger i = 0; i<count; i++) {
        Method method = methods[i];
        SEL methodSEL = method_getName(method);
        const char *methodName = sel_getName(methodSEL);
        NSString *name = [NSString stringWithUTF8String:methodName];
        int arguments = method_getNumberOfArguments(method);
        DLog(@"方法名:%@,   参数个数：%d",name, arguments)
    }
}


@end
