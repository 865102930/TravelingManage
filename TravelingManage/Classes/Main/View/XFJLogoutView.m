//
//  XFJLogoutView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/13.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJLogoutView.h"

@interface XFJLogoutView()

@property (nonatomic, strong) UIButton *logout_button;
@property (nonatomic, strong) UIView *line_view;

@end
@implementation XFJLogoutView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.logout_button];
        [self addSubview:self.line_view];
        [self.logout_button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(17.0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-17.0);
            make.height.mas_equalTo(42.0);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(0);
        }];
        [self.line_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15.0);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(0.5);
            make.top.mas_equalTo(self.mas_top);
        }];
    }
    return self;
}

- (UIButton *)logout_button
{
    if (_logout_button == nil) {
        _logout_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logout_button setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logout_button setTitleColor:kColorFFFF forState:UIControlStateNormal];
        [_logout_button addTarget:self action:@selector(logout_buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [_logout_button setBackgroundImage:[UIImage originalWithImage:@"red"] forState:UIControlStateNormal];
        _logout_button.titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _logout_button;
}

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = DEF_RGB_COLOR(200, 199, 204);
    }
    return _line_view;
}

- (void)logout_buttonClick
{
    if (self.logout_buttonClickBlock) {
        self.logout_buttonClickBlock();
    }
}

@end
