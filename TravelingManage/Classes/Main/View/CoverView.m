//
//  CoverView.m
//  elevator
//
//  Created by 戎翠林 on 16/9/9.
//  Copyright © 2016年 郑子煜. All rights reserved.
//

#import "CoverView.h"

@implementation CoverView
+ (void)show {
    
    CoverView *cover  =  [[self alloc] init];
    //设置背景色
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.6;
    cover.frame = [UIScreen mainScreen].bounds;
    //把显示到最外面的东西添加到窗口上.
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    
}

@end
