//
//  XFJSignMessageTimeView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/3.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJSignMessageTimeView.h"

@interface XFJSignMessageTimeView()

//签到
@property (nonatomic, strong) UIView *signRecrilTime_view;
@property (nonatomic, strong) UILabel *sign_label;
@property (nonatomic, strong) UILabel *signContent_label;

@property (nonatomic, strong) UIView *line_view;

//签退
@property (nonatomic, strong) UIView *signNoRecrilTime_view;
@property (nonatomic, strong) UILabel *signNo_label;
@property (nonatomic, strong) UILabel *signNoContent_label;

@end

@implementation XFJSignMessageTimeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.signRecrilTime_view];
        [self addSubview:self.sign_label];
        [self addSubview:self.signContent_label];
        [self addSubview:self.line_view];
        [self addSubview:self.signNoRecrilTime_view];
        [self addSubview:self.signNo_label];
        [self addSubview:self.signNoContent_label];
        [self.signRecrilTime_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20.0);
            make.left.mas_equalTo(12.0);
            make.height.width.mas_equalTo(8.0);
        }];
        [self.sign_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.signRecrilTime_view.mas_right).mas_offset(8.0);
            make.centerY.mas_equalTo(self.signRecrilTime_view.mas_centerY);
        }];
        [self.signContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.sign_label.mas_right).mas_offset(10.0);
            make.centerY.mas_equalTo(self.signRecrilTime_view.mas_centerY);
        }];
        [self.line_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.signContent_label.mas_bottom).mas_offset(16.0);
            make.left.mas_equalTo(self.mas_left).mas_offset(12.0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-12);
            make.height.mas_equalTo(0.5);
        }];
        [self.signNoRecrilTime_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.line_view.mas_bottom).mas_offset(18.0);
            make.left.mas_equalTo(12.0);
            make.height.width.mas_equalTo(8.0);
        }];
        [self.signNo_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.signNoRecrilTime_view.mas_right).mas_offset(8.0);
            make.centerY.mas_equalTo(self.signNoRecrilTime_view.mas_centerY);
        }];
        [self.signNoContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.signNo_label.mas_right).mas_offset(10.0);
            make.centerY.mas_equalTo(self.signNoRecrilTime_view.mas_centerY);
        }];
    }
    return self;
}

- (UIView *)signRecrilTime_view
{
    if (_signRecrilTime_view == nil) {
        _signRecrilTime_view = [[UIView alloc] init];
        _signRecrilTime_view.backgroundColor = kColor5AD8;
        _signRecrilTime_view.layer.cornerRadius = 4.0;
    }
    return _signRecrilTime_view;
}

- (UILabel *)sign_label
{
    if (_sign_label == nil) {
        _sign_label = [[UILabel alloc] init];
        _sign_label.text = @"签到时间:";
        _sign_label.textColor = kColor8383;
        _sign_label.font = [UIFont fontWithName:PingFang size:13.0];
    }
    return _sign_label;
}

- (UILabel *)signContent_label
{
    if (_signContent_label == nil) {
        _signContent_label = [[UILabel alloc] init];
        _signContent_label.text = @"2017-03-02";
        _signContent_label.textColor = kColor2b2b;
        _signContent_label.font = [UIFont fontWithName:PingFang size:14.0];
    }
    return _signContent_label;
}

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = kColorEBEB;
    }
    return _line_view;
}

#pragma mark - 签退时间
- (UIView *)signNoRecrilTime_view
{
    if (_signNoRecrilTime_view == nil) {
        _signNoRecrilTime_view = [[UIView alloc] init];
        _signNoRecrilTime_view.backgroundColor = kColorFF4745;
        _signNoRecrilTime_view.layer.cornerRadius = 4.0;
    }
    return _signNoRecrilTime_view;
}

- (UILabel *)signNo_label
{
    if (_signNo_label == nil) {
        _signNo_label = [[UILabel alloc] init];
        _signNo_label.text = @"签退时间:";
        _signNo_label.textColor = kColor8383;
        _signNo_label.font = [UIFont fontWithName:PingFang size:13.0];
    }
    return _signNo_label;
}

- (UILabel *)signNoContent_label
{
    if (_signNoContent_label == nil) {
        _signNoContent_label = [[UILabel alloc] init];
        _signNoContent_label.text = @"2017-03-02";
        _signNoContent_label.textColor = kColor2b2b;
        _signNoContent_label.font = [UIFont fontWithName:PingFang size:14.0];
    }
    return _signNoContent_label;
}

- (void)setLaterTeamControlItem:(XFJLaterTeamControlItem *)laterTeamControlItem
{
    _laterTeamControlItem = laterTeamControlItem;
    if (laterTeamControlItem.createTime == nil) {
        self.signContent_label.text = [NSString stringWithFormat:@"%@",@"该团队还未签到"];
    }else {
        self.signContent_label.text = [NSString stringWithFormat:@"%@",laterTeamControlItem.createTime];
    }
}



@end
