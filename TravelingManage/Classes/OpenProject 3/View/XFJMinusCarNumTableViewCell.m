//
//  XFJMinusCarNumTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/16.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

/*
    这是加车牌的按钮
 */

#import "XFJMinusCarNumTableViewCell.h"

@interface XFJMinusCarNumTableViewCell()

@property (nonatomic, strong) UITextField *carName_field;

@property (nonatomic, strong) UIButton *carNmae_button;

@end

@implementation XFJMinusCarNumTableViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initControlWithCarName];
        [self setUpConventionCarNameWithMas];
    }
    return self;
}

- (void)initControlWithCarName
{
    [self addSubview:self.carName_field];
    [self addSubview:self.carNmae_button];
}

- (void)setUpConventionCarNameWithMas
{
    [self.carName_field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(5.0);
        make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
        make.width.mas_equalTo(231);
        make.height.mas_equalTo(38.0);
    }];
    [self.carNmae_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.carName_field.mas_top);
        make.height.width.mas_equalTo(37.0);
        make.left.mas_equalTo(self.carName_field.mas_right).mas_offset(9.0);
    }];
}

- (UITextField *)carName_field
{
    if (_carName_field == nil) {
        _carName_field = [UITextField textBackGroundImage:@"input-box2-" titleName:@"车    牌    号" rightImage:@"xinghao" placeholder:@"请输入车牌号"];
    }
    return _carName_field;
}

- (UIButton *)carNmae_button
{
    if (_carNmae_button == nil) {
        _carNmae_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_carNmae_button setImage:[UIImage originalWithImage:@"delete-"] forState:UIControlStateNormal];
        [_carNmae_button addTarget:self action:@selector(minusCarNameButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _carNmae_button;
}

- (void)minusCarNameButtonClick:(UIButton *)buttonTag
{
    if (self.minusCarNumBlock) {
        self.minusCarNumBlock();
    }
}

- (void)setTextFieldStr:(NSString *)textFieldStr
{
    _textFieldStr = textFieldStr;
    //限制输入框的内容
    if (textFieldStr.length != 0) {
        self.carName_field.text = [NSString stringWithFormat:@"%@",textFieldStr];
    }
}


@end
