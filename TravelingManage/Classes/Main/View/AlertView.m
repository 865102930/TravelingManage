//
//  AlertView.m
//  elevator
//
//  Created by 戎翠林 on 16/8/30.
//  Copyright © 2016年 郑子煜. All rights reserved.
//

#import "AlertView.h"

@interface AlertView ()

@end

@implementation AlertView
//提示
////手动签到
- (IBAction)manualSign:(id)sender {
    if([self.delegate respondsToSelector:@selector(popViewClickBtn:)]) {
        [self.delegate popViewClickBtn:self];
    }
}

//扫描签到
- (IBAction)scanSign:(id)sender {
    if([self.delegate respondsToSelector:@selector(presentViewClickBtn:)]) {
        [self.delegate presentViewClickBtn:self];
    }
}


//给定一个点,隐藏到指定的位置
- (void)hiddenInPoint:(CGPoint)point completion:(void(^)())completion{
    [UIView animateWithDuration:0.5 animations:^{
        self.center = point;
        self.transform = CGAffineTransformMakeScale(0.00001, 0.00001);
    }completion:^(BOOL finished) {
        //执行外界传入的代码
        completion();
        //移除遮盖
        [self removeFromSuperview];
    }];
}

//给定一个点,显示到指定的位置
+ (instancetype)showInPoint:(CGPoint)point {
    
    AlertView  *popV =  [[NSBundle mainBundle] loadNibNamed:@"AlertView" owner:nil options:nil].firstObject;
//    popV.center = point;
    //添加到主窗口上.
    [[UIApplication sharedApplication].keyWindow addSubview:popV];
    [popV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([UIApplication sharedApplication].keyWindow).offset(171 + 64);
        make.centerX.equalTo([UIApplication sharedApplication].keyWindow);
        make.size.mas_equalTo(CGSizeMake(270, 180));
    }];
    return popV;
}



@end
