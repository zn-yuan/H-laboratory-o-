//
//  UtilsMacro.h
//  note_oc
//
//  Created by hryan on 16/1/5.
//  Copyright © 2016年 fe. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h


#define KMainScreen [UIScreen mainScreen]

#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE_PLUS_STANDARD ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE_PLUS_BIG ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)

#define KSCREEN_WIDTH           [[UIScreen mainScreen] bounds].size.width
#define KSCREEN_HEIGHT           [[UIScreen mainScreen] bounds].size.height

#define kCVScreenSize                   ([[UIScreen mainScreen] applicationFrame].size)
#define kCVScreenWidth                  kCVScreenSize.width
#define kCVScreenHeight                 kCVScreenSize.height

#define IOS7_OR_LATER   ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)
#define IS_IOS8         ([[[UIDevice currentDevice] systemVersion] doubleValue]>=8.0)


#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r) / 255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


//use dlog to print while in debug model
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#define FEWeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;


#endif /* UtilsMacro_h */
