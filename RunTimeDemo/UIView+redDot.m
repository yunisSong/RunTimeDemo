//
//  UIView+redDot.m
//  CMCC_CY
//
//  Created by Yunis on 9/21/16.
//  Copyright © 2016 CMCC. All rights reserved.
//

#import "UIView+redDot.h"
#import <objc/runtime.h>

static char badgeLabelKey;
static float dotWidth = 5.f;
@implementation UIView (redDot)
- (void)addRedDot
{
    if (nil == self.badgeImagView)
    {
        self.badgeImagView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"User_MessageRed"]];
        [self addSubview:self.badgeImagView];
        self.badgeImagView.frame = CGRectMake(self.frame.size.width - (dotWidth /2.f), - (dotWidth /2.f), dotWidth, dotWidth);
    }
    self.badgeImagView.hidden = NO;
 

}
- (void)removeRedDot
{
    self.badgeImagView.hidden = YES;

}
- (void)addLeftRedDot
{
    if (nil == self.badgeImagView)
    {
        self.badgeImagView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"User_MessageRed"]];
        [self addSubview:self.badgeImagView];
        self.badgeImagView.frame = CGRectMake(5,(self.frame.size.height - dotWidth )/2.f, dotWidth, dotWidth);
    }
    self.badgeImagView.hidden = NO;
}

- (UIImageView *)badgeImagView
{
    return objc_getAssociatedObject(self, &badgeLabelKey);
}

- (void)setBadgeImagView:(UIImageView *)badgeImagView
{
    objc_setAssociatedObject(self, &badgeLabelKey, badgeImagView, OBJC_ASSOCIATION_RETAIN);
}
@end
