//
//  NSObject+Common.m
//  封装MBP显示方式
//
//  Created by 肖锋 on 2017/2/4.
//  Copyright © 2017年 肖锋. All rights reserved.
//

#import "NSObject+Common.h"
#import "MBProgressHUD.h"

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

@end
