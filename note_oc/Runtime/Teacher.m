//
//  Teacher.m
//  laboratory
//
//  Created by hryan on 16/4/18.
//  Copyright © 2016年 fe. All rights reserved.
//

/*
 * 消息转发测试
 *
 * 我们就是利用这几个方案进行消息转发，注意一点，前一套方案实现后一套方法就不会执行。如果这几套方案你都没有做处理，那么程序就会报错crash。
 
 
 * 首先，系统会调用resolveInstanceMethod(当然，如果这个方法是一个类方法，就会调用resolveClassMethod)让你自己为这个方法增加实现。
 
 * 现在我不去对方案一的resolveInstanceMethod做任何处理，直接调用父类方法。可以看到，系统已经来到了forwardingTargetForSelector方法. 程序就来到了Doctor类的operate方法，这样，我们就实现了消息转发。
 
 * 如果我们不实现forwardingTargetForSelector，系统就会调用方案三的两个方法methodSignatureForSelector和forwardInvocation
 
 
 *
 */

#warning "v@:"
/*
 
 * 关于生成签名的类型"v@:"解释一下。每一个方法会默认隐藏两个参数，self、_cmd，self代表方法调用者，_cmd代表这个方法的SEL，签名类型就是用来描述这个方法的返回值、参数的，v代表返回值为void，@表示self，:表示_cmd。
 */


#import "Teacher.h"
#import <objc/runtime.h>
@implementation Teacher

void operate(id self, SEL _cmd){
    DLog(@"%@'s %s",self,sel_getName(_cmd))
}


#pragma mark:-------------方法一
//只是在这个例子中，我为run方法动态增加了实现
+ (BOOL)resolveClassMethod:(SEL)sel {
    return [super resolveClassMethod:sel];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    
    if(sel == @selector(operate)){
        class_addMethod(self, sel, (IMP)operate, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
    
}

#pragma mark:-------------方法二
//第二套方法，forwardingTargetForSelector，这个方法返回你需要转发消息的对象。

-(id)forwardingTargetForSelector:(SEL)aSelector {
    Doctor *doctor = [[Doctor alloc]init];
    if ([doctor respondsToSelector:aSelector]) {
        return doctor;
    }
    return nil;
}

#pragma mark:-------------方法三
/*
 
 * methodSignatureForSelector用来生成方法签名，这个签名就是给forwardInvocation中的参数NSInvocation调用的。
 
 *
 
 */


/*
 * 产生 unrecognized selector sent to instance原因，就是因为methodSignatureForSelector这个方法中，由于没有找到run对应的实现方法，所以返回了一个空的方法签名，最终导致程序报错崩溃
 
 *  所以我们需要做的是自己新建方法签名，再在forwardInvocation中用你要转发的那个对象调用这个对应的签名，这样也实现了消息转发。
*/
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    NSString *sel = NSStringFromSelector(aSelector);
    if ([sel isEqualToString:@"operate3"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL selector = [anInvocation selector];
    
//    新建 需要转发消息的对象
    Doctor *doctor = [[Doctor alloc]init];
    if ([doctor respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:doctor];
    }
    
    
}



@end
