//
//  AlertView1.m
//  elevator
//
//  Created by 戎翠林 on 16/9/9.
//  Copyright © 2016年 郑子煜. All rights reserved.
//

#import "AlertView1.h"

@implementation AlertView1

- (IBAction)bake:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(popViewClickBtn1:)]) {
        [self.delegate popViewClickBtn1:self];
    }

}

- (IBAction)signOut:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(presentViewClickBtn1:)]) {
        [self.delegate presentViewClickBtn1:self];
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
    
    AlertView1  *popV =  [[NSBundle mainBundle] loadNibNamed:@"AlertView" owner:nil options:nil][1];
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
