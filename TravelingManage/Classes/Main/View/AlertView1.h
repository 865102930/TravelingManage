//
//  AlertView1.h
//  elevator
//
//  Created by 戎翠林 on 16/9/9.
//  Copyright © 2016年 郑子煜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AlertView1;
@protocol AlertView1Delegate <NSObject>
- (void)popViewClickBtn1:(AlertView1 *)alertView1;
- (void)presentViewClickBtn1:(AlertView1 *)alertView1;

@end

@interface AlertView1 : UIView
//给定一个点,显示到指定的位置
+ (instancetype)showInPoint:(CGPoint)point;
//给定一个点,隐藏到指定的位置
- (void)hiddenInPoint:(CGPoint)point completion:(void(^)())completion;



@property(nonatomic, weak) id <AlertView1Delegate>delegate;


@end
