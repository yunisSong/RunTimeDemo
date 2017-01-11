//
//  NSObject+dicToModel.m
//  RunTimeDemo
//
//  Created by Yunis on 17/1/11.
//  Copyright © 2017年 Yunis. All rights reserved.
//

#import "NSObject+dicToModel.h"
#import "NSObject+Property.h"
#import <objc/runtime.h>

@implementation NSObject (dicToModel)
+ (instancetype)Y_ModelWithDic:(NSDictionary *)modelDic
{
    id instance = [[[self class] alloc] init];

    if (instance)
    {
        NSArray *pArr = [[self class] getAllProperties];
        [pArr enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
            id value = modelDic[key];
            if (value) {
                
                [instance setValue:value forKey:key];
            }
        }];
    }
    return instance;
}
@end
