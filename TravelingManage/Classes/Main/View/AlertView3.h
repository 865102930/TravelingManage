//
//  AlertView3.h
//  elevator
//
//  Created by 戎翠林 on 16/9/14.
//  Copyright © 2016年 郑子煜. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlertView3;

@protocol AlertView3Delegate <NSObject>
//隐藏
- (void)popViewClickBtn3:(AlertView3 *)alertView3;
//跳转
- (void)presentViewClickBtn3:(AlertView3 *)alertView3;


@end
@interface AlertView3 : UIView
+ (instancetype)showInPoint:(CGPoint)point;
//给定一个点,隐藏到指定的位置
- (void)hiddenInPoint:(CGPoint)point completion:(void(^)())completion;

@property(nonatomic, weak) id <AlertView3Delegate>delegate;


@end
