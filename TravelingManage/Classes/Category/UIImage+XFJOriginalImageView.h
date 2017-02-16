//
//  UIImage+XFJOriginalImageView.h
//  WeiLook
//
//  Created by 肖锋 on 16/11/12.
//  Copyright © 2016年 XFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XFJOriginalImageView)

/* 返回一张未被拉伸的图片
 * imageName 图片名称
 */
+ (UIImage *)originalWithImage:(NSString *)imageName;

@end
