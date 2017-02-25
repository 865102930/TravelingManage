//
//  XFJSignView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/23.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJSignView.h"

@interface XFJSignView()

//签到人数的说明
@property (nonatomic, strong) UILabel *signNumber_label;

//签到的人数
@property (nonatomic, strong) UITextField *signPeople_text;

//name
@property (nonatomic, strong) UILabel *name_label;

//签到按钮
@property (nonatomic, strong) UIButton *sign_button;

@end

@implementation XFJSignView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.signNumber_label];
        [self addSubview:self.signPeople_text];
        [self addSubview:self.name_label];
        [self addSubview:self.sign_button];
        
        [self.signNumber_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.top.mas_equalTo(self.mas_top).mas_offset(31.0);
        }];
        [self.signPeople_text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.signNumber_label.mas_right).mas_offset(12.0);
            make.width.mas_equalTo(97.0);
            make.height.mas_equalTo(26.0);
            make.centerY.mas_equalTo(self.signNumber_label.mas_centerY);
        }];
        [self.name_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.signPeople_text.mas_right).mas_offset(15.0);
            make.centerY.mas_equalTo(self.signNumber_label.mas_centerY);
        }];
        [self.sign_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.signNumber_label.mas_centerY);
            make.right.mas_equalTo(-18.0);
            make.height.mas_equalTo(35.0);
            make.width.mas_equalTo(96.0);
        }];
    }
    return self;
}

- (UILabel *)signNumber_label
{
    if (_signNumber_label == nil) {
        _signNumber_label = [[UILabel alloc] init];
        _signNumber_label.text = @"签到人数:";
        _signNumber_label.font = [UIFont fontWithName:PingFang size:14.0];
        _signNumber_label.textColor = kColor8383;
        _signNumber_label.textAlignment = NSTextAlignmentLeft;
    }
    return _signNumber_label;
}

- (UITextField *)signPeople_text
{
    if (_signPeople_text == nil) {
        _signPeople_text = [[UITextField alloc] init];
        _signPeople_text.textColor = kColor8383;
        _signPeople_text.background = [UIImage originalWithImage:@"shurukuang"];
        [_signPeople_text setFont:[UIFont fontWithName:PingFang size:14.0]];
        [_signPeople_text addTarget:self action:@selector(signPeopleText:) forControlEvents:UIControlEventEditingDidEnd];
        _signPeople_text.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMPEOPLENUMBER"]];
        _signPeople_text.textAlignment = NSTextAlignmentCenter;
    }
    return _signPeople_text;
}

- (void)signPeopleText:(UITextField *)textField
{
    NSLog(@"输入框的值发生了变化------------%@",textField.text);
}

- (UILabel *)name_label
{
    if (_name_label == nil) {
        _name_label = [[UILabel alloc] init];
        _name_label.text = @"人";
        _name_label.font = [UIFont fontWithName:PingFang size:14.0];
        _name_label.textColor = kColor8383;
        _name_label.textAlignment =NSTextAlignmentLeft;
    }
    return _name_label;
}

- (UIButton *)sign_button
{
    if (_sign_button == nil) {
        _sign_button = [UIButton buttonWithType:UIButtonTypeCustom];
        _sign_button.layer.cornerRadius = 4.0;
        _sign_button.layer.borderColor = kColorff47.CGColor;
        _sign_button.layer.borderWidth = 0.5;
        _sign_button.backgroundColor = kColorff47;
        [_sign_button setTitle:@"签到" forState:UIControlStateNormal];
        [_sign_button setTitleColor:kColorFFFF forState:UIControlStateNormal];
        _sign_button.titleLabel.font = [UIFont fontWithName:PingFang size:14.0];
        [_sign_button addTarget:self action:@selector(signButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _sign_button;
}

- (void)signButtonClick
{
    if (self.signButtonClickBlock) {
        self.signButtonClickBlock();
    }
}

- (void)setPeopleNumberStr:(NSString *)peopleNumberStr
{
    _peopleNumberStr = peopleNumberStr;
    self.signPeople_text.placeholder = [NSString stringWithFormat:@"%@",peopleNumberStr];
    self.signPeople_text.text = [NSString stringWithFormat:@"%@",peopleNumberStr];
    NSLog(@"传过来的人数值是:%@---------%@",peopleNumberStr,self.signPeople_text.text);
}


@end
