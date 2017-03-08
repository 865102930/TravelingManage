//
//  XFJSixAttributeTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJSixAttributeTableViewCell.h"

@interface XFJSixAttributeTableViewCell()

@property (nonatomic, strong) UIButton *teamProperties_button;

@property (nonatomic, strong) UILabel *teamProperties_label;

@property (nonatomic, strong) UIImageView *teamProperties_imageViewLeft;

@property (nonatomic, strong) UILabel *teamPropertiesContent_label;


@end

@implementation XFJSixAttributeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.teamProperties_button];
        [self addSubview:self.teamProperties_label];
        [self addSubview:self.teamProperties_imageViewLeft];
        [self addSubview:self.teamPropertiesContent_label];
        
        [self.teamProperties_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(9.0);
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
            make.height.mas_equalTo(38.0);
        }];
        [self.teamProperties_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.teamProperties_button.mas_centerY);
            make.left.mas_equalTo(self.teamProperties_button.mas_left).mas_offset(15.0);
        }];
        [self.teamProperties_imageViewLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.teamProperties_button.mas_top).mas_offset(13.0);
            make.left.mas_equalTo(self.teamProperties_label.mas_right).mas_offset(1.0);
            make.height.mas_equalTo(5.0);
            make.width.mas_equalTo(5.0);
        }];
        [self.teamPropertiesContent_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.teamProperties_imageViewLeft.mas_right).mas_offset(18.0);
            make.centerY.mas_equalTo(self.teamProperties_label.mas_centerY);
        }];
    }
    return self;
}

- (UIButton *)teamProperties_button
{
    if (_teamProperties_button == nil) {
        _teamProperties_button = [UIButton buttonWithType:UIButtonTypeCustom];
        _teamProperties_button.layer.borderColor = kBorderColor.CGColor;
        _teamProperties_button.layer.borderWidth = 0.5;
        _teamProperties_button.layer.cornerRadius = 3.0;
        _teamProperties_button.clipsToBounds = YES;
        _teamProperties_button.layer.masksToBounds = YES;
        [_teamProperties_button addTarget:self action:@selector(teamPropertiesButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _teamProperties_button;
}

- (void)teamPropertiesButtonClick
{
    NSLog(@"主人~~您点击了请输入日期框!!");
}

- (UILabel *)teamProperties_label
{
    if (_teamProperties_label == nil) {
        _teamProperties_label = [[UILabel alloc] init];
        _teamProperties_label.text = @"属          性";
        _teamProperties_label.textColor = kColor2f2f;
        _teamProperties_label.font = [UIFont systemFontOfSize:13.0];
    }
    return _teamProperties_label;
}

- (UIImageView *)teamProperties_imageViewLeft
{
    if (_teamProperties_imageViewLeft == nil) {
        _teamProperties_imageViewLeft = [[UIImageView alloc] init];
        _teamProperties_imageViewLeft.image = [UIImage originalWithImage:@"xinghao"];
    }
    return _teamProperties_imageViewLeft;
}

- (UILabel *)teamPropertiesContent_label
{
    if (_teamPropertiesContent_label == nil) {
        _teamPropertiesContent_label = [[UILabel alloc] init];
        _teamPropertiesContent_label.text = @"请输入日期";
        _teamPropertiesContent_label.textColor = kColor2f2f;
        _teamPropertiesContent_label.font = [UIFont systemFontOfSize:14.0];
    }
    return _teamPropertiesContent_label;
}

@end
