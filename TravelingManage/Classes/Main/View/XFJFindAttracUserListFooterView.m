//
//  XFJFindAttracUserListFooterView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/21.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJFindAttracUserListFooterView.h"


@interface XFJFindAttracUserListFooterView()

@property (nonatomic, strong) UIButton *sure_button;
@property (nonatomic, strong) UIButton *cancel_button;
@property (nonatomic, strong) UIView *line_view;

@end

@implementation XFJFindAttracUserListFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.sure_button];
        [self addSubview:self.cancel_button];
        [self addSubview:self.line_view];
        [self.sure_button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(10.0);
            make.left.mas_equalTo(self.mas_centerX).mas_offset(18.0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
            make.height.mas_equalTo(33.0);
        }];
        [self.cancel_button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.right.mas_equalTo(self.mas_centerX).mas_offset(-18.0);
            make.top.mas_equalTo(self.mas_top).mas_offset(10.0);
            make.height.mas_equalTo(33.0);
        }];
        [self.line_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(1.5);
        }];
    }
    return self;
}

- (UIButton *)sure_button
{
    if (_sure_button == nil) {
        _sure_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sure_button setTitle:@"确定" forState:UIControlStateNormal];
        [_sure_button setTitleColor:RedColor forState:UIControlStateNormal];
        _sure_button.titleLabel.font = [UIFont fontWithName:PingFang size:15.0];
        [_sure_button addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sure_button;
}

- (UIButton *)cancel_button
{
    if (_cancel_button == nil) {
        _cancel_button = [UIButton buttonWithType: UIButtonTypeCustom];
        [_cancel_button setTitle:@"取消" forState:UIControlStateNormal];
        [_cancel_button setTitleColor:kColor7979 forState:UIControlStateNormal];
        _cancel_button.titleLabel.font = [UIFont fontWithName:PingFang size:15.0];
        [_cancel_button addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancel_button;
}

- (void)cancelButtonClick
{
    NSLog(@"取消管理员.....");
    if (self.cancelUserButtonBlock) {
        self.cancelUserButtonBlock();
    }
}

- (void)sureButtonClick
{
    if (self.sureUserButtonBlock) {
        self.sureUserButtonBlock();
    }
}

@end
