//
//  XFJMaskView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/7.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJMaskView.h"

@interface XFJMaskView()

@property (nonatomic, strong) UIButton *button;

@end

@implementation XFJMaskView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        [self addSubview:self.button];
    }
    return self;
}

- (UIButton *)button
{
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor clearColor];
        _button.frame = [UIScreen mainScreen].bounds;
        [_button addTarget:self action:@selector(maskButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)maskButtonClick
{
    if (self.maskBlock) {
        self.maskBlock();
    }
}

@end
