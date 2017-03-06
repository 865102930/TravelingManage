//
//  XFJCommitView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/6.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJCommitView.h"

@interface XFJCommitView()

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *commit_button;

@end

@implementation XFJCommitView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bottomView];
        [self addSubview:self.commit_button];
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(3.0);
            make.top.mas_equalTo(self.mas_top);
        }];
        [self.commit_button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.height.mas_equalTo(33.0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-18);
            make.top.mas_equalTo(self.bottomView).mas_offset(29.0);
        }];
    }
    return self;
}

- (UIView *)bottomView
{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = kColoreeee;
    }
    return _bottomView;
}

- (UIButton *)commit_button
{
    if (_commit_button == nil) {
        _commit_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commit_button setTitle:@"提交评价" forState:UIControlStateNormal];
        [_commit_button setTitleColor:kColorFFFF forState:UIControlStateNormal];
        _commit_button.backgroundColor = kColorff47;
        _commit_button.layer.cornerRadius = 8.0;
        [_commit_button addTarget:self action:@selector(commitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commit_button;
}

- (void)commitButtonClick
{
    NSLog(@"主人~~您点击了提交按钮!!");
}



@end
