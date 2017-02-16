//
//  UIView+Frame.h
//
//  Created by 肖锋 on 17/2/6.
//  Copyright © 2017年 XFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property CGFloat XFJ_X;

@property CGFloat XFJ_Y;

@property CGFloat XFJ_Width;

@property CGFloat XFJ_Height;

@property CGFloat XFJ_centerX;

@property CGFloat XFJ_centerY;

#pragma mark - 增加一个类方法,方便创建xib的时候直接调用创建
+ (instancetype)XFJ_middleXib;

@end
