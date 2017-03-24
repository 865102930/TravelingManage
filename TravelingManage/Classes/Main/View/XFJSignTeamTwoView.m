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

@property (nonatomic, assign) NSInteger scenten_inter;
@property (nonatomic, assign) NSInteger hotel_inter;

@end

@implementation XFJSignTeamTwoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scenerySign_view];
        [self.scenerySign_view addSubview:self.scenerySign_button];
        [self.scenerySign_view addSubview:self.scenerySign_label];
        [self addSubview:self.line_view];
        [self addSubview:self.hotelSign_view];
        [self.hotelSign_view addSubview:self.hotelSign_button];
        [self.hotelSign_view addSubview:self.hotelSign_label];
        [self.scenerySign_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_centerX);
            make.height.mas_equalTo(self.mas_height);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        [self.scenerySign_button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.scenerySign_view.mas_centerX);
            make.height.mas_equalTo(30.0);
            make.width.mas_equalTo(30.0);
            make.top.mas_equalTo(self.scenerySign_view.mas_top).mas_offset(11.0);
        }];
        [self.scenerySign_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.scenerySign_button.mas_centerX);
            make.top.mas_equalTo(self.scenerySign_button.mas_bottom).mas_offset(0);
        }];
        [self.line_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.scenerySign_view.mas_right);
            make.height.mas_equalTo(self.scenerySign_view.mas_height);
            make.width.mas_equalTo(0.5);
            make.top.mas_equalTo(self.scenerySign_view.mas_top);
        }];
        [self.hotelSign_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.line_view.mas_right);
            make.height.mas_equalTo(self.line_view.mas_height);
            make.right.mas_equalTo(self.mas_right);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        [self.hotelSign_button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.hotelSign_view.mas_centerX);
            make.height.mas_equalTo(30.0);
            make.width.mas_equalTo(30.0);
            make.top.mas_equalTo(self.hotelSign_view.mas_top).mas_offset(11.0);
        }];
        [self.hotelSign_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.hotelSign_button.mas_centerX);
            make.top.mas_equalTo(self.hotelSign_button.mas_bottom).mas_offset(0);
        }];
    }
    return self;
}

- (UIView *)scenerySign_view
{
    if (_scenerySign_view == nil) {
        _scenerySign_view = [[UIView alloc] init];
    }
    return _scenerySign_view;
}

- (UIButton *)scenerySign_button
{
    if (_scenerySign_button == nil) {
        _scenerySign_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scenerySign_button setImage:[UIImage originalWithImage:@"sign"] forState:UIControlStateNormal];
        [_scenerySign_button addTarget:self action:@selector(scenerySign_buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scenerySign_button;
}

- (UILabel *)scenerySign_label
{
    if (_scenerySign_label == nil) {
        _scenerySign_label = [[UILabel alloc] init];
        _scenerySign_label.text = @"景点签到";
        _scenerySign_label.textColor = RedColor;
        _scenerySign_label.font = [UIFont fontWithName:PingFang size:13.0];
    }
    return _scenerySign_label;
}

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = kColoreeee;
    }
    return _line_view;
}

- (UIView *)hotelSign_view
{
    if (_hotelSign_view == nil) {
        _hotelSign_view = [[UIView alloc] init];
    }
    return _hotelSign_view;
}

- (UIButton *)hotelSign_button
{
    if (_hotelSign_button == nil) {
        _hotelSign_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hotelSign_button setImage:[UIImage originalWithImage:@"sign"] forState:UIControlStateNormal];
        [_hotelSign_button addTarget:self action:@selector(hotelSign_buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hotelSign_button;
}

- (UILabel *)hotelSign_label
{
    if (_hotelSign_label == nil) {
        _hotelSign_label = [[UILabel alloc] init];
        _hotelSign_label.text = @"酒店签到";
        _hotelSign_label.textColor = RedColor;
        _hotelSign_label.font = [UIFont fontWithName:PingFang size:13.0];
    }
    return _hotelSign_label;
}

#pragma makr - 景点签到
- (void)scenerySign_buttonClick
{
    //否则不改变按钮的颜色,并且用户也可以点击(接收点击事件)
    NSLog(@"---------主人!~~您点击了景点签到!!!");
    if (self.scenerySign_Block) {
        self.scenerySign_Block();
    }
}

#pragma mark - 酒店签到
- (void)hotelSign_buttonClick
{
    //否则不改变颜色,并且让用户点击
    NSLog(@"-------主人~~您点击了酒店签到!!!");
    if (self.hotelSign_block) {
        self.hotelSign_block();
    }
}

- (void)setScenery_array:(NSMutableArray *)scenery_array
{
    _scenery_array = scenery_array;
    NSLog(@"+++++++++++景点的个数是 :%zd",scenery_array.count);
    //如果景区签到的个数为0,就让点击的按钮变灰色并且不让点击
    self.scenerySign_view.backgroundColor = kColorE9E9;
    self.scenerySign_label.textColor = kColorFFFF;
    self.scenerySign_button.enabled = NO;
    [self.scenerySign_button setImage:[UIImage originalWithImage:@"n-sign"] forState:UIControlStateNormal];
}

- (void)setHotel_array:(NSMutableArray *)hotel_array
{
    _hotel_array = hotel_array;
    //如果酒店签到的个数为0,就让点击的按钮变灰色并且不让点击
    self.hotelSign_view.backgroundColor = kColorE9E9;
    self.hotelSign_label.textColor = kColorFFFF;
    self.hotelSign_button.enabled = NO;
    [self.hotelSign_button setImage:[UIImage originalWithImage:@"n-sign"] forState:UIControlStateNormal];
}



@end
