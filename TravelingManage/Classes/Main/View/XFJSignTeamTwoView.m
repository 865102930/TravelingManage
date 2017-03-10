//
//  XFJSignTeamTwoView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/10.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJSignTeamTwoView.h"

@interface XFJSignTeamTwoView()
@property (nonatomic, strong) UIView *scenerySign_view;
@property (nonatomic, strong) UIButton *scenerySign_button;
@property (nonatomic, strong) UILabel *scenerySign_label;
@property (nonatomic, strong) UIView *line_view;

@property (nonatomic, strong) UIView *hotelSign_view;
@property (nonatomic, strong) UIButton *hotelSign_button;
@property (nonatomic, strong) UILabel *hotelSign_label;

@end

@implementation XFJSignTeamTwoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scenerySign_view];
        [self addSubview:self.scenerySign_button];
        [self.scenerySign_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_centerX);
            make.height.mas_equalTo(self.mas_height);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        [self.scenerySign_button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.scenerySign_view.mas_centerX);
            make.height.mas_equalTo(40.0);
            make.width.mas_equalTo(40.0);
            make.top.mas_equalTo(self.scenerySign_view.mas_top).mas_offset(11.0);
        }];
    }
    return self;
}

- (UIView *)scenerySign_view
{
    if (_scenerySign_view == nil) {
        _scenerySign_view = [[UIView alloc] init];
        _scenerySign_view.backgroundColor = [UIColor yellowColor];
    }
    return _scenerySign_view;
}

- (UIButton *)scenerySign_button
{
    if (_scenerySign_button == nil) {
        _scenerySign_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scenerySign_button setImage:[UIImage originalWithImage:@"n-sign"] forState:UIControlStateNormal];
    }
    return _scenerySign_button;
}



@end
