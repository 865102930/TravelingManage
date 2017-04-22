//
//  AlertView2.h
//  elevator
//
//  Created by 戎翠林 on 16/9/9.
//  Copyright © 2016年 郑子煜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AlertView2;
@protocol AlertView2Delegate <NSObject>
- (void)popViewClickBtn:(AlertView2 *)alertView2;
//- (void)faultReportButton:(AlertView2 *)alertView2;
@end

@interface AlertView2 : UIView
//给定一个点,显示到指定的位置
+ (instancetype)showInPoint:(CGPoint)point;
//给定一个点,隐藏到指定的位置
- (void)hiddenInPoint:(CGPoint)point completion:(void(^)())completion;

@property(nonatomic, weak) id <AlertView2Delegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *promptText;//提交成功的提示文字

@end
