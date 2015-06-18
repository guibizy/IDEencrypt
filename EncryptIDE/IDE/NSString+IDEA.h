//
//  NSString+DES.h
//  UMC
//
//  Created by 悦讯科技  on 13-7-23.
//  Copyright (c) 2013年 shihui. All rights reserved.
//

// idea加密解密类

// --- mode 加密解密时使用

#define IDEA_TO_STR(string) \
if(string.length!=0) string = [string stringWithIDEAToStr]; \
else string = @"";
#define DMLog(...) NSLog(@"%@", [NSString stringWithFormat:__VA_ARGS__])

#import <Foundation/Foundation.h>

@interface NSString (IDEA)

// 字符串加密
- (NSString *)stringWithStrToIDEA;

// 字符串解密
- (NSString *)stringWithIDEAToStr;

@end
