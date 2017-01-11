//
//  NSObject+encode.m
//  RunTimeDemo
//
//  Created by Yunis on 17/1/11.
//  Copyright © 2017年 Yunis. All rights reserved.
//

#import "NSObject+encode.h"
#import "NSObject+Property.h"

@implementation NSObject (encode)
- (void)Y_encodeWithCoder:(NSCoder *)coder
{
    NSArray *pArray = [[self class] getAllProperties];
    [pArray enumerateObjectsUsingBlock:^(NSString *propertyName, NSUInteger idx, BOOL * _Nonnull stop) {
        //  利用KVC取出属性对应的值
        id value = [self valueForKey:propertyName];
        //  归档
        if (value)
        {
            [coder encodeObject:value forKey:propertyName];
        }

    }];
}
- (void)Y_initWithCoder:(NSCoder *)coder
{
    //  设置到成员变量身上
    
    NSArray *pArray = [[self class] getAllProperties];
    [pArray enumerateObjectsUsingBlock:^(NSString *propertyName, NSUInteger idx, BOOL * _Nonnull stop) {
    
        //  利用KVC取出属性对应的值
        id value = [coder decodeObjectForKey:propertyName];
        //  归档
        if (value)
        {
            [self setValue:value forKey:propertyName];
        }
    }];

}

@end
