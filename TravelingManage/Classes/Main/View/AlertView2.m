//
//  AlertView2.m
//  elevator
//
//  Created by 戎翠林 on 16/9/9.
//  Copyright © 2016年 郑子煜. All rights reserved.
//

#import "AlertView2.h"

@implementation AlertView2


///完成并签退
- (IBAction)finish:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(popViewClickBtn:)]) {
        [self.delegate popViewClickBtn:self];
    }
}

////故障上报
//- (IBAction)faultReportButton:(UIButton *)sender {
//    if([self.delegate respondsToSelector:@selector(faultReportButton:)]) {
//        [self.delegate faultReportButton:self];
//    }
//
//}


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
    
    AlertView2  *popV =  [[NSBundle mainBundle] loadNibNamed:@"AlertView" owner:nil options:nil][2];
    //    popV.center = point;
    //添加到主窗口上.
    [[UIApplication sharedApplication].keyWindow addSubview:popV];
    [popV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([UIApplication sharedApplication].keyWindow).offset(171 + 64);
        make.centerX.equalTo([UIApplication sharedApplication].keyWindow);
//        make.left.equalTo([UIApplication sharedApplication].keyWindow).offset(52);
        make.size.mas_equalTo(CGSizeMake(270, 180));
    }];
    return popV;
}


@end
