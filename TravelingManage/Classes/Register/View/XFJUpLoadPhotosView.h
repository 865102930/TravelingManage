//
//  XFJUpLoadPhotosView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/4/17.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFJUpLoadPhotosView : UIView

@property (nonatomic, copy) void (^choosePhotosBlock)(NSInteger);

@property (nonatomic, strong) UIImage *font_imageView2;
@property (nonatomic, strong) UIImage *back_imageView2;
@property (nonatomic, strong) UIImage *guide_imageView2;

@end
