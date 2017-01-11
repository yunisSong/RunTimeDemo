//
//  NSObject+encode.h
//  RunTimeDemo
//
//  Created by Yunis on 17/1/11.
//  Copyright © 2017年 Yunis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (encode)
- (void)Y_encodeWithCoder:(NSCoder *)coder;
- (void)Y_initWithCoder:(NSCoder *)coder;
@end
