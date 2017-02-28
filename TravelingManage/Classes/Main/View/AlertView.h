//
//  AlertView.h
//  elevator
//
//  Created by 戎翠林 on 16/8/30.
//  Copyright © 2016年 郑子煜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AlertView;
@protocol AlertViewDelegate <NSObject>
- (void)popViewClickBtn:(AlertView *)alertView;
- (void)presentViewClickBtn:(AlertView *)alertView;
@end

@interface AlertView : UIView
//给定一个点,显示到指定的位置
+ (instancetype)showInPoint:(CGPoint)point;
//给定一个点,隐藏到指定的位置
- (void)hiddenInPoint:(CGPoint)point completion:(void(^)())completion;

@property(nonatomic, weak) id <AlertViewDelegate>delegate;


@end










