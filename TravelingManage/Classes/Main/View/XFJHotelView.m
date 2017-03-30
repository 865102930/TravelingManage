//
//  XFJHotelView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/26.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJHotelView.h"

@interface XFJHotelView()

@property (nonatomic, strong) UIView *redCircel_view;
@property (nonatomic, strong) UILabel *hotelName_label;
@property (nonatomic, strong) UITextField *hotelText_field;
@property (nonatomic, strong) UILabel *peopleName_label;

@property (nonatomic, strong) UIView *blueCircel_view;
@property (nonatomic, strong) UILabel *romeName_label;
@property (nonatomic, strong) UITextField *romeText_field;
@property (nonatomic, strong) UILabel *rome_label;

@property (nonatomic, strong) UIButton *hotelButtonSignClick;

@end

@implementation XFJHotelView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.redCircel_view];
        [self addSubview:self.hotelName_label];
        [self addSubview:self.peopleName_label];
        [self addSubview:self.hotelText_field];
        [self addSubview:self.blueCircel_view];
        [self addSubview:self.romeName_label];
        [self addSubview:self.romeText_field];
        [self addSubview:self.rome_label];
        [self addSubview:self.hotelButtonSignClick];
        [self.redCircel_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(36.0);
            make.left.mas_equalTo(18.0);
            make.height.width.mas_equalTo(6.0);
        }];
        [self.hotelName_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.redCircel_view.mas_centerY);
            make.left.mas_equalTo(self.redCircel_view.mas_right).mas_offset(13.0);
        }];
        [self.peopleName_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.redCircel_view.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
            make.width.mas_equalTo(14.0);
        }];
        [self.hotelText_field mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.hotelName_label.mas_right).mas_offset(14.0);
            make.height.mas_equalTo(32.0);
            make.width.mas_equalTo(150);
            make.centerY.mas_equalTo(self.hotelName_label.mas_centerY);
        }];
        [self.blueCircel_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.redCircel_view.mas_bottom).mas_offset(38.0);
            make.left.mas_equalTo(18.0);
            make.height.width.mas_equalTo(6.0);
        }];
        [self.romeName_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.blueCircel_view.mas_centerY);
            make.left.mas_equalTo(self.blueCircel_view.mas_right).mas_offset(13.0);
        }];
        [self.romeText_field mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.romeName_label.mas_right).mas_offset(14.0);
            make.height.mas_equalTo(32.0);
            make.width.mas_equalTo(150);
            make.centerY.mas_equalTo(self.romeName_label.mas_centerY);
        }];
        [self.rome_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.blueCircel_view.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
            make.width.mas_equalTo(14.0);
        }];
        [self.hotelButtonSignClick mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.romeText_field.mas_bottom).mas_offset(19.0);
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
            make.height.mas_equalTo(37.0);
        }];
    }
    return self;
}

- (UIView *)redCircel_view
{
    if (_redCircel_view == nil) {
        _redCircel_view = [[UIView alloc] init];
        _redCircel_view.backgroundColor = kColorff47;
        _redCircel_view.layer.cornerRadius = 3.0;
        _redCircel_view.layer.borderColor = kColorff47.CGColor;
        _redCircel_view.layer.borderWidth = 0.5;
    }
    return _redCircel_view;
}

- (UILabel *)hotelName_label
{
    if (_hotelName_label == nil) {
        _hotelName_label = [[UILabel alloc] init];
        _hotelName_label.text = @"入住人数:";
        _hotelName_label.textColor = kColor8383;
        _hotelName_label.font = [UIFont fontWithName:PingFang size:14.0];
        _hotelName_label.textAlignment = NSTextAlignmentLeft;
    }
    return _hotelName_label;
}

- (UITextField *)hotelText_field
{
    if (_hotelText_field == nil) {
        _hotelText_field = [[UITextField alloc] init];
        _hotelText_field.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMPEOPLENUMBER"]];
        [_hotelText_field addTarget:self action:@selector(hotelSignPeopleNumber:) forControlEvents:UIControlEventEditingChanged];
        _hotelText_field.textAlignment = NSTextAlignmentCenter;
        _hotelText_field.textColor = kColor8383;
        _hotelText_field.keyboardType = UIKeyboardTypeNumberPad;
        _hotelText_field.font = [UIFont systemFontOfSize:14.0];
        _hotelText_field.background = [UIImage originalWithImage:@"input-box4-"];
    }
    return _hotelText_field;
}

- (void)hotelSignPeopleNumber:(UITextField *)textField
{
    self.isHotelCount = YES;
    if (self.hotelPopelSignBlock) {
        self.hotelPopelSignBlock(textField.text,self.isHotelCount);
    }
}

- (UILabel *)peopleName_label
{
    if (_peopleName_label == nil) {
        _peopleName_label = [[UILabel alloc] init];
        _peopleName_label.text = @"人";
        _peopleName_label.textColor = kColor8383;
        _peopleName_label.font = [UIFont fontWithName:PingFang size:14.0];
        _peopleName_label.textAlignment = NSTextAlignmentLeft;
    }
    return _peopleName_label;
}

- (UIView *)blueCircel_view
{
    if (_blueCircel_view == nil) {
        _blueCircel_view = [[UIView alloc] init];
        _blueCircel_view.backgroundColor = kColor1EA8;
        _blueCircel_view.layer.cornerRadius = 3.0;
        _blueCircel_view.layer.borderColor = kColor1EA8.CGColor;
        _blueCircel_view.layer.borderWidth = 0.5;
    }
    return _blueCircel_view;
}

- (UILabel *)romeName_label
{
    if (_romeName_label == nil) {
        _romeName_label = [[UILabel alloc] init];
        _romeName_label.text = @"房 间 数 :";
        _romeName_label.textColor = kColor8383;
        _romeName_label.font = [UIFont fontWithName:PingFang size:14.0];
        _romeName_label.textAlignment = NSTextAlignmentLeft;
    }
    return _romeName_label;
}

- (UITextField *)romeText_field
{
    if (_romeText_field == nil) {
        _romeText_field = [[UITextField alloc] init];
        _romeText_field.text = @"0";
        _romeText_field.textAlignment = NSTextAlignmentCenter;
        _romeText_field.textColor = kColor8383;
        _romeText_field.font = [UIFont systemFontOfSize:14.0];
        [_romeText_field addTarget:self action:@selector(hotelSignRoomCount:) forControlEvents:UIControlEventEditingChanged];
        _romeText_field.keyboardType = UIKeyboardTypeNumberPad;
        _romeText_field.background = [UIImage originalWithImage:@"input-box4-"];
    }
    return _romeText_field;
}

- (void)hotelSignRoomCount:(UITextField *)hotelRoomCountText
{
    if (self.HotelSignRoomCountBlock) {
        self.HotelSignRoomCountBlock(hotelRoomCountText.text);
    }
}

- (UILabel *)rome_label
{
    if (_rome_label == nil) {
        _rome_label = [[UILabel alloc] init];
        _rome_label.text = @"间";
        _rome_label.textColor = kColor8383;
        _rome_label.font = [UIFont fontWithName:PingFang size:14.0];
        _rome_label.textAlignment = NSTextAlignmentLeft;
    }
    return _rome_label;
}

- (UIButton *)hotelButtonSignClick
{
    if (_hotelButtonSignClick == nil) {
        _hotelButtonSignClick = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hotelButtonSignClick setTitle:@"签到" forState:UIControlStateNormal];
        [_hotelButtonSignClick setTitleColor:kColorFFFF forState:UIControlStateNormal];
        _hotelButtonSignClick.titleLabel.font = [UIFont fontWithName:PingFang size:14.0];
        _hotelButtonSignClick.backgroundColor = RedColor;
        _hotelButtonSignClick.layer.cornerRadius = 4.0;
        _hotelButtonSignClick.layer.borderColor = RedColor.CGColor;
        _hotelButtonSignClick.layer.borderWidth = 0.5;
        [_hotelButtonSignClick addTarget:self action:@selector(hotelSignButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hotelButtonSignClick;
}

- (void)hotelSignButtonClick
{
    if (self.hotelSignButtonClickBlock) {
        self.hotelSignButtonClickBlock();
    }
}

@end
