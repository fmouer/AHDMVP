//
//  NSObject+UniqueCode.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "NSObject+UniqueCode.h"
#import <objc/runtime.h>

@implementation NSObject (UniqueCode)

-(NSString *)uniqueCode
{
    unsigned int count = 0;
    Ivar * vars = class_copyIvarList([self class], &count);
    NSInteger uniqueCode = 0;
    for (int i = 0; i < count; i ++) {
        Ivar const ivar = vars[i];
        
        //　获取变量名
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 若此变量未在类结构体中声明而只声明为Property，则变量名加前缀 '_'下划线
        // 比如 @property(retain) NSString *abc;则 key == _abc;
        
        //　获取变量值
        id value = [self valueForKey:key];
        uniqueCode += [value hash];
    }
    return [NSString stringWithFormat:@"%ld",(long)uniqueCode];
}

@end
