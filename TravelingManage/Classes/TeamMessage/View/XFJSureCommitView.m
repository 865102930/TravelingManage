//
//  XFJSureCommitView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/15.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJSureCommitView.h"

@interface XFJSureCommitView()

@property (nonatomic, strong) UIView *line_view;
@property (nonatomic, strong) UIButton *sure_commitButton;

@end

@implementation XFJSureCommitView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.line_view];
        [self addSubview:self.sure_commitButton];
        [self.line_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(3.0);
            make.top.mas_equalTo(self.mas_top);
        }];
        [self.sure_commitButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(20.0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-20.0);
            make.height.mas_equalTo(42.0);
            make.top.mas_equalTo(self.line_view.mas_bottom).mas_offset(33.0);
        }];
    }
    return self;
}

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = kColoreeee;
    }
    return _line_view;
}

- (UIButton *)sure_commitButton
{
    if (_sure_commitButton == nil) {
        _sure_commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sure_commitButton setTitle:@"确认提交" forState:UIControlStateNormal];
        [_sure_commitButton setTitleColor:kColorFFFF forState:UIControlStateNormal];
        _sure_commitButton.backgroundColor = kColorff47;
        _sure_commitButton.layer.cornerRadius = 8.0;
        [_sure_commitButton addTarget:self action:@selector(sure_commitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sure_commitButton;
}

- (void)sure_commitButtonClick
{
    if (self.sureButton_clickBlock) {
        self.sureButton_clickBlock();
    }
}

@end
