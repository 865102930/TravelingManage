//
//  UIView+Frame.m
//
//  Created by 肖锋 on 17/2/6.
//  Copyright © 2017年 XFJ. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

#pragma mark - 实现快速创建xib的方法
+ (instancetype)XFJ_middleXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)setXFJ_centerX:(CGFloat)XFJ_centerX
{
    CGPoint center = self.center;
    center.x = XFJ_centerX;
    self.center = center;
    
}

- (CGFloat )XFJ_centerX
{
    return self.center.x;
}

- (void)setXFJ_centerY:(CGFloat)XFJ_centerY
{
    CGPoint center = self.center;
    center.y = XFJ_centerY;
    self.center = center;
}

- (CGFloat)XFJ_centerY
{
    return self.center.y;
}

- (void)setXFJ_X:(CGFloat)XFJ_X
{
    CGRect frame = self.frame;
    
    frame.origin.x = XFJ_X;
    
    self.frame = frame;
}

- (CGFloat)XFJ_X
{
    return self.frame.origin.x;
}

- (void)setXFJ_Y:(CGFloat)XFJ_Y
{
    CGRect frame = self.frame;
    
    frame.origin.y = XFJ_Y;
    
    self.frame = frame;
}

- (CGFloat)XFJ_Y
{
    return self.frame.origin.y;
}

- (void)setXFJ_Width:(CGFloat)XFJ_Width
{
    CGRect frame = self.frame;
    
    frame.size.width = XFJ_Width;
    
    self.frame = frame;
}

- (CGFloat)XFJ_Width
{
    return self.frame.size.width;
}

- (void)setXFJ_Height:(CGFloat)XFJ_Height
{
    CGRect frame = self.frame;
    
    frame.size.height = XFJ_Height;
    
    self.frame = frame;
}

- (CGFloat)XFJ_Height
{
    return self.frame.size.height;
}





@end
