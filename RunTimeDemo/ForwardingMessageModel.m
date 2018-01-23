//
//  ForwardingMessageModel.m
//  RunTimeDemo
//
//  Created by Yunis on 5/1/17.
//  Copyright © 2018年 Yunis. All rights reserved.
//

#import "ForwardingMessageModel.h"
#import <objc/runtime.h>
@implementation ForwardingMessageModel

void rescueCrash (id self,SEL _cmd)
{
    NSLog(@"成功的拯救了一次闪退");
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSLog(@"进入消息转发的流程");
    
    class_addMethod(self, sel, (IMP)rescueCrash, "v:@:");
    return YES;
    return [super resolveInstanceMethod:sel];
}


- (void)sayHello:(NSString *)name
{
    NSLog(@"Hello,%@",name);
}
@end
