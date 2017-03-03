//
//  NSObject+Common.m
//  封装MBP显示方式
//
//  Created by 肖锋 on 2017/2/4.
//  Copyright © 2017年 肖锋. All rights reserved.
//

#import "NSObject+Common.h"
#import "MBProgressHUD.h"
#define DelayTime 1.5
#define kHUDQueryViewTag 101
#define kKeyWindow [UIApplication sharedApplication].keyWindow
@implementation NSObject (Common)

+ (instancetype)showHUDQueryStr:(NSString *)titleStr contentColor:(HidWithColorContentType)contentType
{
    titleStr = titleStr.length > 0 ? titleStr: @"正在获取数据...";
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    hud.tag = kHUDQueryViewTag;
    hud.label.text = titleStr;
    hud.label.font = [UIFont boldSystemFontOfSize:15.0];
    if (contentType) {
        hud.contentColor = [UIColor whiteColor];
        hud.bezelView.color = [UIColor blackColor];
    }
    hud.margin = 10.f;
    return hud;
}

+ (void)showHudTipStr:(NSString *)tipStr contentColor:(HidWithColorContentType)contentType
{
    if (tipStr && tipStr.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.font = [UIFont boldSystemFontOfSize:15.0];
        hud.detailsLabel.text = tipStr;
        hud.margin = 10.f;
        if (contentType) {
            hud.contentColor = [UIColor whiteColor];
            hud.bezelView.color = [UIColor blackColor];
        }
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:1.0];
    }
}

+ (NSUInteger)hideHUDQuery
{
    __block NSUInteger count = 0;
    NSArray *huds = [MBProgressHUD allHUDsForView:kKeyWindow];
    [huds enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if (obj.tag == kHUDQueryViewTag) {
            [obj removeFromSuperview];
            count++;
        }
    }];
    return count;
}

+ (void)showLoadHudWithcontentColor:(HidWithColorContentType)contentType
{
    [self showLoadHUDAddedToView:kKeyWindow contentColor:contentType];
}

+ (void)showLoadHUDAddedToView:(UIView *)view contentColor:(HidWithColorContentType)contentType
{
    [MBProgressHUD hideHUDAndView:view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (contentType) {
        hud.contentColor = [UIColor whiteColor];
        hud.bezelView.color = [UIColor blackColor];
    }
}

+ (void)hideHUDAndView:(UIView *)view
{
    if (view) {
        [MBProgressHUD hideHUDForView:view animated:YES];
    } else {
        [MBProgressHUD hideHUDForView:kKeyWindow animated:YES];
    }
}

+ (void)hidenHud
{
    [self hideHUDAndView:nil];
}


/**
 *  在窗口上显示菊花
 */
+ (void)showLoadHUD {
    [self showLoadHUDAddedToView:[UIApplication sharedApplication].keyWindow];
}
/**
 *  在view上显示菊花
 */
+ (void)showLoadHUDAddedToView:(UIView *)view {
    
    [MBProgressHUD hideHUDAndView:view];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor blackColor];
}

/**
 *  在窗口上显示文字-->1.5秒钟后消失
 */
+ (void)showHUDMsg:(NSString *)message {
    [self showHUDWithMsg:message withDelay:DelayTime];
}
/**
 *  在窗口上显示文字-->afterDelay秒钟后消失
 */
+ (void)showHUDWithMsg:(NSString *)message withDelay:(NSTimeInterval)afterDelay {
    [self showHUDAddedToView:[UIApplication sharedApplication].keyWindow WithMsg:message withDelay:afterDelay];
}

/**
 *  在View上显示文字-->afterDelay秒钟后消失
 */
+ (void)showHUDAddedToView:(UIView *)view WithMsg:(NSString *)message withDelay:(NSTimeInterval)afterDelay {
    
    [MBProgressHUD hideHUDAndView:view];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor blackColor];
    //可以设置显示的位置
    // hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    [hud hideAnimated:YES afterDelay:afterDelay];
}

@end
