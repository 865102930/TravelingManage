//
//  XFJHomeTopTaskMessageVeiw.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/20.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJHomeTopTaskMessageVeiw.h"

@interface XFJHomeTopTaskMessageVeiw()

@property (nonatomic, strong) UILabel *carNumber_label;

@property (nonatomic, strong) UILabel *carNumberContent_label;

@property (nonatomic, strong) UILabel *peopleMessage_label;

@property (nonatomic, strong) UILabel *peopleMessageContent_label;

@property (nonatomic, strong) UILabel *openTeam_label;

@property (nonatomic, strong) UILabel *openTeamContent_label;

@property (nonatomic, strong) UIButton *arrow_button;

@property (nonatomic, strong) UIButton *state_button;

@end

@implementation XFJHomeTopTaskMessageVeiw

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpContentControl];
        [self setUpContentControlWithMas];
    }
    return self;
}

#pragma mark - 添加控件
- (void)setUpContentControl
{
    [self addSubview:self.carNumber_label];
    [self addSubview:self.carNumberContent_label];
    [self addSubview:self.peopleMessage_label];
    [self addSubview:self.peopleMessageContent_label];
    [self addSubview:self.openTeam_label];
    [self addSubview:self.openTeamContent_label];
    [self addSubview:self.arrow_button];
    [self addSubview:self.state_button];
}

- (UILabel *)carNumber_label
{
    if (_carNumber_label == nil) {
        _carNumber_label = [[UILabel alloc] init];
        _carNumber_label.text = @"车  牌  号:";
        _carNumber_label.textAlignment = NSTextAlignmentLeft;
        _carNumber_label.font = [UIFont systemFontOfSize:13.0];
        _carNumber_label.textColor = kColor8383;
    }
    return _carNumber_label;
}

- (UILabel *)carNumberContent_label
{
    if (_carNumberContent_label == nil) {
        _carNumberContent_label = [[UILabel alloc] init];
        _carNumberContent_label.text = @"浙A5474";
        _carNumberContent_label.textAlignment = NSTextAlignmentLeft;
        _carNumberContent_label.font = [UIFont systemFontOfSize:14.0];
        _carNumberContent_label.textColor = kColor2f2f;
    }
    return _carNumberContent_label;
}

- (UILabel *)peopleMessageContent_label
{
    if (_peopleMessageContent_label == nil) {
        _peopleMessageContent_label = [[UILabel alloc] init];
        _peopleMessageContent_label.text = @"浙江杭州省余杭区";
        _peopleMessageContent_label.textAlignment = NSTextAlignmentLeft;
        _peopleMessageContent_label.font = [UIFont systemFontOfSize:14.0];
        _peopleMessageContent_label.textColor = kColor2f2f;
    }
    return _peopleMessageContent_label;
}

- (UILabel *)peopleMessage_label
{
    if (_peopleMessage_label == nil) {
        _peopleMessage_label = [[UILabel alloc] init];
        _peopleMessage_label.text = @"客  源  地:";
        _peopleMessage_label.textAlignment = NSTextAlignmentLeft;
        _peopleMessage_label.font = [UIFont systemFontOfSize:13.0];
        _peopleMessage_label.textColor = kColor8383;
    }
    return _peopleMessage_label;
}

- (UILabel *)openTeam_label
{
    if (_openTeam_label == nil) {
        _openTeam_label = [[UILabel alloc] init];
        _openTeam_label.text = @"开团时间:";
        _openTeam_label.textAlignment = NSTextAlignmentLeft;
        _openTeam_label.font = [UIFont systemFontOfSize:13.0];
        _openTeam_label.textColor = kColor8383;
    }
    return _openTeam_label;
}

- (UILabel *)openTeamContent_label
{
    if (_openTeamContent_label == nil) {
        _openTeamContent_label = [[UILabel alloc] init];
        _openTeamContent_label.text = @"2017-10-11 12:00";
        _openTeamContent_label.textAlignment = NSTextAlignmentLeft;
        _openTeamContent_label.font = [UIFont systemFontOfSize:14.0];
        _openTeamContent_label.textColor = kColor2f2f;
    }
    return _openTeamContent_label;
}

- (UIButton *)state_button
{
    if (_state_button == nil) {
        _state_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_state_button setTitle:@"完成" forState:UIControlStateNormal];
        _state_button.layer.cornerRadius = 4.0;
        _state_button.layer.borderColor = kColorff47.CGColor;
        _state_button.layer.borderWidth = 0.5;
        [_state_button setTitleColor:kColorff47 forState:UIControlStateNormal];
        _state_button.titleLabel.font = [UIFont systemFontOfSize:13.0];
    }
    return _state_button;
}

- (UIButton *)arrow_button
{
    if (_arrow_button == nil) {
        _arrow_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_arrow_button setImage:[UIImage originalWithImage:@"chakan"] forState:UIControlStateNormal];
        [_arrow_button addTarget:self action:@selector(teamMessage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrow_button;
}
#pragma mark - 布局控件
- (void)setUpContentControlWithMas
{
    [self.carNumber_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(23.0);
        make.left.mas_equalTo(self.mas_left).mas_offset(15.0);
    }];
    [self.carNumberContent_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(22.0);
        make.left.mas_equalTo(self.carNumber_label.mas_right).mas_offset(9.0);
    }];
    [self.peopleMessageContent_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(22.0);
        make.right.mas_equalTo(self.mas_right).mas_offset(-66.0);
    }];
    [self.peopleMessage_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(23.0);
        make.right.mas_equalTo(self.peopleMessageContent_label.mas_left).mas_offset(-9.0);
    }];
    [self.openTeam_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.carNumber_label.mas_bottom).mas_offset(19.0);
        make.left.mas_equalTo(self.mas_left).mas_offset(15.0);
    }];
    [self.openTeamContent_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.carNumberContent_label.mas_bottom).mas_offset(18.0);
        make.left.mas_equalTo(self.openTeam_label.mas_right).mas_offset(9.0);
    }];
    [self.state_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.peopleMessageContent_label.mas_bottom).mas_offset(14.0);
        make.right.mas_equalTo(self.mas_right).mas_offset(-66.0);
        make.width.mas_equalTo(62.0);
        make.height.mas_equalTo(25.0);
    }];
    [self.arrow_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(37.0);
        make.right.mas_equalTo(self.mas_right).mas_offset(-21.0);
        make.height.mas_equalTo(17.0);
        make.width.mas_equalTo(12.0);
    }];
}

- (void)teamMessage
{
    if (self.jumpWithTeamMessageBlock) {
        self.jumpWithTeamMessageBlock();
    }
}





@end
