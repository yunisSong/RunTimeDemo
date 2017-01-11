//
//  UIAlertController+exchangeMethod.m
//  RunTimeDemo
//
//  Created by Yunis on 17/1/9.
//  Copyright © 2017年 Yunis. All rights reserved.
//

#import "UIAlertController+exchangeMethod.h"
#import <objc/runtime.h>
@implementation UIAlertController (exchangeMethod)
+ (void)load
{
    SEL oldSel = @selector(alertControllerWithTitle:message:preferredStyle:);
    SEL newSel = @selector(new_alertControllerWithTitle:message:preferredStyle:);
    Method oldMethod = class_getClassMethod(self, oldSel);
    Method newMethod = class_getClassMethod(self, newSel);
    // 交换方法地址，相当于交换实现方式
    method_exchangeImplementations(oldMethod, newMethod);

}
+ (instancetype)new_alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle
{
    title = @"我是修改后的名字";
    return [UIAlertController new_alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
}
@end
