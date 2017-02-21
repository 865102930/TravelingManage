//
//  NSObject+Common.h
//  封装MBP显示方式
//
//  Created by 肖锋 on 2017/2/4.
//  Copyright © 2017年 肖锋. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
    选择不同的颜色对应不同的菊花背景
 */
typedef NS_ENUM(NSInteger, HidWithColorContentType) {
    HidWithColorContentWhite = 0,
    HidWithColorContentBlack,
};

@interface NSObject (Common)

/*  返回封装好的指示器
 *  titleStr    需要显示的文字
 */
+ (instancetype)showHUDQueryStr:(NSString *)titleStr contentColor:(HidWithColorContentType)contentType;

/*  作用完成后需要显示的内容
 *  tipStr      需要显示的文字
 */
+ (void)showHudTipStr:(NSString *)tipStr contentColor:(HidWithColorContentType)contentType;

/*
 *  显示加载的菊花样式
 */
+ (void)showLoadHudWithcontentColor:(HidWithColorContentType)contentType;

/*
 *  隐藏窗口上所有的指示器(该方法可用,也可不用,系统提供了一个此类的封装方法)
 */
+ (NSUInteger)hideHUDQuery;

/*
 *  影藏指示器
 */
+ (void)hidenHud;

@end
