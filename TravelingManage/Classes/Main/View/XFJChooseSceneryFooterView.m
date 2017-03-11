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

@end

@implementation XFJChooseSceneryFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.sure_button];
        [self.sure_button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(29.0);
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
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
        [_sure_button setTitleColor:kColorFFFF forState:UIControlStateNormal];
        _sure_button.backgroundColor = kColorff47;
        _sure_button.layer.cornerRadius = 8.0;
        _sure_button.userInteractionEnabled = YES;
        [_sure_button addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sure_button;
}

- (void)sureButtonClick
{
    if (self.sureChoose_buttonClickBlock) {
        self.sureChoose_buttonClickBlock();
    }
}


@end
