//
//  UIImage+image.h
//  elevator
//
//  Created by 戎翠林 on 16/11/14.
//  Copyright © 2016年 郑子煜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (image)
/** 生成纯颜色图 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/** 自动缩放到指定大小，生成缩略图 */
+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;

/** 保持原来长宽比，生成缩略图 */
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;

/** 压缩图片 */
+ (NSData *)compressImage:(UIImage *)image maxSize:(NSUInteger)maxSize;

/** 高斯模糊 毛玻璃效果 */
+ (UIImage *)gsImage:(UIImage *)image withGsNumber:(CGFloat)blur;

/** 缩放图片 */
+ (UIImage*)scaleImage:(UIImage *)image scaleToSize:(CGSize)size;

/** 裁剪图片 */
+ (UIImage *)clipImage:(UIImage *)image inRect:(CGRect)rect;

/** 图片剪裁 取部分以适应pubSize */
+ (UIImage *)cutImage:(UIImage *)image size:(CGSize)pubSize;

/** 图片剪裁 圆形*/
+ (UIImage *)circleImageWithName:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end
