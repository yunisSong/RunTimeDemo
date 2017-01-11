//
//  NSObject+Property.h
//  RunTimeDemo
//
//  Created by Yunis on 17/1/9.
//  Copyright © 2017年 Yunis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Property)
+(NSArray *)getAllProperties;
+(NSArray *)getAllMethods;
- (NSDictionary *)getAllPropertiesAndVaules;
@end
