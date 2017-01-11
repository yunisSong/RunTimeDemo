//
//  NSString+json2Dic.m
//  RunTimeDemo
//
//  Created by Yunis on 17/1/11.
//  Copyright © 2017年 Yunis. All rights reserved.
//

#import "NSString+json2Dic.h"

@implementation NSString (json2Dic)
- (NSDictionary *)toDic
{
    NSError *error = nil;
    NSData *jsonData = [self dataUsingEncoding:NSASCIIStringEncoding];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
}
@end
