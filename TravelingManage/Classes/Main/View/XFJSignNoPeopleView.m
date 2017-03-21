//
//  XFJSignNoPeopleView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/24.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJSignNoPeopleView.h"

@interface XFJSignNoPeopleView()

@property (nonatomic, strong) UIImageView *peopleNumber_imageView;

@property (nonatomic, strong) UILabel *peopleNumber_label;

@property (nonatomic, strong) UILabel *peopleName_label;

@property (nonatomic, strong) UIImageView *time_imageView;

@property (nonatomic, strong) UILabel *timeCantent_label;

@property (nonatomic, strong) UILabel *hour_label;

@property (nonatomic, strong) UIButton *signNo_button;

@property (nonatomic, strong) UILabel *minuteContent_label;

@property (nonatomic, strong) UILabel *minute_label;

@end

@implementation XFJSignNoPeopleView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.peopleNumber_imageView];
        [self addSubview:self.peopleNumber_label];
        [self addSubview:self.peopleName_label];
        [self addSubview:self.time_imageView];
        [self addSubview:self.timeCantent_label];
        [self addSubview:self.hour_label];
        [self addSubview:self.signNo_button];
        [self addSubview:self.minuteContent_label];
        [self addSubview:self.minute_label];
        self.backgroundColor = [UIColor whiteColor];
        [self.peopleNumber_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(29.0);
            make.left.mas_equalTo(20.0);
            make.height.width.mas_equalTo(16.0);
        }];
        [self.peopleNumber_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.peopleNumber_imageView.mas_centerY);
            make.left.mas_equalTo(self.peopleNumber_imageView.mas_right).mas_offset(6.0);
        }];
        [self.peopleName_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.peopleNumber_label.mas_right).mas_offset(3.0);
            make.centerY.mas_equalTo(self.peopleNumber_imageView.mas_centerY);
        }];
        [self.time_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(29.0);
            make.left.mas_equalTo(self.peopleName_label.mas_right).mas_offset(10.0);
            make.centerY.mas_equalTo(self.peopleNumber_imageView.mas_centerY);
            make.height.width.mas_equalTo(16.0);
        }];
        [self.timeCantent_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.peopleNumber_imageView.mas_centerY);
            make.left.mas_equalTo(self.time_imageView.mas_right).mas_offset(6.0);
        }];
        [self.hour_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.timeCantent_label.mas_right).mas_offset(3.0);
            make.centerY.mas_equalTo(self.peopleNumber_imageView.mas_centerY);
        }];
        [self.signNo_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20.0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
            make.width.mas_equalTo(96.0);
            make.height.mas_equalTo(35.0);
        }];
        [self.minuteContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.peopleNumber_imageView.mas_centerY);
            make.left.mas_equalTo(self.hour_label.mas_right).mas_offset(3.0);
        }];
        [self.minute_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.peopleNumber_imageView.mas_centerY);
            make.left.mas_equalTo(self.minuteContent_label.mas_right).mas_offset(3.0);
        }];
    }
    return self;
}

#pragma mark - 人数
- (UIImageView *)peopleNumber_imageView
{
    if (_peopleNumber_imageView == nil) {
        _peopleNumber_imageView = [[UIImageView alloc] init];
        _peopleNumber_imageView.image = [UIImage originalWithImage:@"renshu"];
    }
    return _peopleNumber_imageView;
}

#pragma mark - 人数的内容
- (UILabel *)peopleNumber_label
{
    if (_peopleNumber_label == nil) {
        _peopleNumber_label = [[UILabel alloc] init];
        _peopleNumber_label.textColor = RedColor;
        _peopleNumber_label.font = [UIFont fontWithName:PingFang size:14.0];
        _peopleNumber_label.textAlignment = NSTextAlignmentCenter;
    }
    return _peopleNumber_label;
}


#pragma mark - 人数
- (UILabel *)peopleName_label
{
    if (_peopleName_label == nil) {
        _peopleName_label = [[UILabel alloc] init];
        _peopleName_label.text = [NSString stringWithFormat:@"%@",@"人"];
        _peopleName_label.textColor = kColor8383;
        _peopleName_label.font = [UIFont systemFontOfSize:14.0];
    }
    return _peopleName_label;
}

#pragma makr - 时间图片
- (UIImageView *)time_imageView
{
    if (_time_imageView == nil) {
        _time_imageView = [[UIImageView alloc] init];
        _time_imageView.image = [UIImage originalWithImage:@"shijian"];
    }
    return _time_imageView;
}

#pragma makr - 时间的内容
- (UILabel *)timeCantent_label
{
    if (_timeCantent_label == nil) {
        _timeCantent_label = [[UILabel alloc] init];
        _timeCantent_label.textColor = RedColor;
        _timeCantent_label.font = [UIFont fontWithName:PingFang size:14.0];
        _timeCantent_label.textAlignment = NSTextAlignmentCenter;
    }
    return _timeCantent_label;
}

#pragma makr - hour_label
- (UILabel *)hour_label
{
    if (_hour_label == nil) {
        _hour_label = [[UILabel alloc] init];
        _hour_label.text = [NSString stringWithFormat:@"%@",@"时"];
        _hour_label.textColor = kColor8383;
        _hour_label.font = [UIFont systemFontOfSize:14.0];
    }
    return _hour_label;
}

#pragma mark - 签退按钮
- (UIButton *)signNo_button
{
    if (_signNo_button == nil) {
        _signNo_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_signNo_button setTitle:@"签退" forState:UIControlStateNormal];
        _signNo_button.backgroundColor = kColorACAC;
        _signNo_button.titleLabel.textColor = kColorFFFF;
        _signNo_button.layer.cornerRadius = 4.0;
        _signNo_button.layer.borderColor = kColorACAC.CGColor;
        _signNo_button.layer.borderWidth = 0.5;
        [_signNo_button addTarget:self action:@selector(signNoButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signNo_button;
}

- (UILabel *)minuteContent_label
{
    if (_minuteContent_label == nil) {
        _minuteContent_label = [[UILabel alloc] init];
        _minuteContent_label.textColor = RedColor;
        _minuteContent_label.font = [UIFont fontWithName:PingFang size:14.0];
        _minuteContent_label.textAlignment = NSTextAlignmentCenter;
    }
    return _minuteContent_label;
}

- (UILabel *)minute_label
{
    if (_minute_label == nil) {
        _minute_label = [[UILabel alloc] init];
        _minute_label.text = [NSString stringWithFormat:@"%@",@"分"];
        _minute_label.textColor = kColor8383;
        _minute_label.font = [UIFont systemFontOfSize:14.0];
    }
    return _minute_label;
}

#pragma makr - 签退点击事件
- (void)signNoButton
{
    if (self.signNoButtonClickBlock) {
        self.signNoButtonClickBlock();
    }
}

- (void)setSignNoPeopleArray:(NSMutableArray<XFJTeamSignListItem *> *)signNoPeopleArray
{
    _signNoPeopleArray = signNoPeopleArray;
    if (signNoPeopleArray.count != 0) {
        self.peopleNumber_label.text = [NSString stringWithFormat:@"%zd",signNoPeopleArray[0].checkinNumber];
    }
}

- (void)setHourTeamTime:(NSString *)hourTeamTime
{
    _hourTeamTime = hourTeamTime;
    self.timeCantent_label.text = [NSString stringWithFormat:@"%@",hourTeamTime];
}

- (void)setMinteTeamTime:(NSString *)minteTeamTime
{
    _minteTeamTime = minteTeamTime;
    self.minuteContent_label.text = [NSString stringWithFormat:@"%@",minteTeamTime];
}

- (void)setFindTeamTaskItem:(XFJFindTeamTaskItem *)findTeamTaskItem
{
    _findTeamTaskItem = findTeamTaskItem;
    self.peopleNumber_label.text = [NSString stringWithFormat:@"%zd",findTeamTaskItem.checkinNumber];
}

- (void)setTeamNum:(NSInteger)teamNum
{
    _teamNum = teamNum;
    self.peopleNumber_label.text = [NSString stringWithFormat:@"%zd",teamNum];
}






@end
