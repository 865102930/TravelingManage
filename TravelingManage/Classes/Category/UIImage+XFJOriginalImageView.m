//
//  UIImage+XFJOriginalImageView.m
//  WeiLook
//
//  Created by 肖锋 on 16/11/12.
//  Copyright © 2016年 XFJ. All rights reserved.
//

#import "UIImage+XFJOriginalImageView.h"

@implementation UIImage (XFJOriginalImageView)


+ (UIImage *)originalWithImage:(NSString *)imageName
{
    //传入一张图片
    UIImage *image = [UIImage imageNamed:imageName];
    //返回一张未被渲染的图片
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


@end
