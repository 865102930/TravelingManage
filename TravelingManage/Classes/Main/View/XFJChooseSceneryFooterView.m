//
//  XFJChooseSceneryFooterView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/11.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJChooseSceneryFooterView.h"

@interface XFJChooseSceneryFooterView()

@property (nonatomic, strong) UIButton *sure_button;
@property (nonatomic, strong) UIButton *cancel_button;
@property (nonatomic, strong) UIView *line_view;

@end

@implementation XFJChooseSceneryFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.sure_button];
        [self addSubview:self.cancel_button];
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

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = kColoreeee;
    }
    return _line_view;
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

#pragma mark - 确定
- (void)sureButtonClick
{
    if (self.sureChoose_buttonClickBlock) {
        self.sureChoose_buttonClickBlock();
    }
}


#pragma mark - 取消
- (void)cancelButtonClick
{
    NSLog(@"点击了取消景区按钮........");
    if (self.cancelChoose_buttonClickBlock) {
        self.cancelChoose_buttonClickBlock();
    }
}


@end
