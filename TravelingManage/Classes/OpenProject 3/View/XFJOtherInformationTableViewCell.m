//
//  XFJOtherInformationTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/14.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJOtherInformationTableViewCell.h"

@interface XFJOtherInformationTableViewCell()

@property (nonatomic, strong) UIView *line_view;

@property (nonatomic, strong) UIImageView *otherInformation_imageView;

@property (nonatomic, strong) UILabel *otherInformation_label;

@property (nonatomic, strong) UITextField *quality_field;

@end

@implementation XFJOtherInformationTableViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.line_view];
        [self addSubview:self.otherInformation_imageView];
        [self addSubview:self.otherInformation_label];
        [self addSubview:self.quality_field];
        [self.line_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(self.mas_left);
            make.height.mas_equalTo(3.0);
            make.right.mas_equalTo(self.mas_right);
        }];
        [self.otherInformation_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(24.0);
            make.left.mas_equalTo(18.0);
            make.height.mas_equalTo(15.0);
            make.width.mas_equalTo(13.0);
        }];
        [self.otherInformation_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.otherInformation_imageView.mas_centerY);
            make.left.mas_equalTo(self.otherInformation_imageView.mas_right).mas_offset(10.0);
        }];
        [self.quality_field mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.otherInformation_imageView.mas_bottom).mas_offset(16.0);
            make.left.mas_equalTo(self.otherInformation_imageView.mas_left);
            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
            make.height.mas_equalTo(38.0);
        }];
    }
    return self;
}

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = kColoreeee;
    }
    return _line_view;
}
- (UIImageView *)otherInformation_imageView
{
    if (_otherInformation_imageView == nil) {
        _otherInformation_imageView = [[UIImageView alloc] init];
        _otherInformation_imageView.image = [UIImage originalWithImage:@"information-"];
    }
    return _otherInformation_imageView;
}

- (UILabel *)otherInformation_label
{
    if (_otherInformation_label == nil) {
        _otherInformation_label = [[UILabel alloc] init];
        _otherInformation_label.text = @"其他信息";
        _otherInformation_label.textColor = kColorff47;
        [_otherInformation_label setFont:[UIFont systemFontOfSize:15.0]];
        _otherInformation_label.textAlignment = NSTextAlignmentLeft;
    }
    return _otherInformation_label;
    
}

- (UITextField *)quality_field
{
    if (_quality_field == nil) {
        _quality_field = [UITextField textBackGroundImage:@"input-box-" titleName:@"属          性" rightImage:@"xinghao" placeholder:@"请输入属性值"];
    }
    return _quality_field;
}

@end
