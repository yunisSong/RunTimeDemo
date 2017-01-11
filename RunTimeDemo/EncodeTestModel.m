//
//  EncodeTestModel.m
//  RunTimeDemo
//
//  Created by Yunis on 17/1/11.
//  Copyright © 2017年 Yunis. All rights reserved.
//

#import "EncodeTestModel.h"
#import "NSObject+encode.h"

@implementation EncodeTestModel
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self Y_encodeWithCoder:aCoder];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self Y_initWithCoder:aDecoder];
    }
    return self;
}
@end
