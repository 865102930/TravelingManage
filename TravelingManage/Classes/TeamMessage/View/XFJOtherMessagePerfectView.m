//
//  XFJOtherMessagePerfectView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/4.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJOtherMessagePerfectView.h"

@interface XFJOtherMessagePerfectView()
@property (nonatomic, strong) UIView *line_view;
@property (nonatomic, strong) UIImageView *otherMessage_imageView;
@property (nonatomic, strong) UILabel *otherMessage_label;
@property (nonatomic, strong) UITextField *quality_field;

@end

@implementation XFJOtherMessagePerfectView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.line_view];
        [self addSubview:self.otherMessage_imageView];
        [self addSubview:self.otherMessage_label];
//        [self addSubview:self.quality_field];
        [self.line_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(2.0);
        }];
        [self.otherMessage_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.line_view.mas_bottom).mas_offset(9.0);
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.width.mas_equalTo(10.0);
            make.height.mas_equalTo(12.0);
        }];
        [self.otherMessage_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.otherMessage_imageView.mas_right).mas_offset(8.0);
            make.centerY.mas_equalTo(self.otherMessage_imageView.mas_centerY);
        }];
//        [self.quality_field mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.otherMessage_imageView.mas_bottom).mas_offset(16.0);
//            make.left.mas_equalTo(self.otherMessage_imageView.mas_left);
//            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
//            make.height.mas_equalTo(38.0);
//        }];
    }
    return self;
}

- (UIImageView *)otherMessage_imageView
{
    if (_otherMessage_imageView == nil) {
        _otherMessage_imageView = [[UIImageView alloc] init];
        _otherMessage_imageView.image = [UIImage originalWithImage:@"information-"];
    }
    return _otherMessage_imageView;
}

- (UILabel *)otherMessage_label
{
    if (_otherMessage_label == nil) {
        _otherMessage_label = [[UILabel alloc] init];
        _otherMessage_label.text = @"其他信息";
        _otherMessage_label.font = [UIFont fontWithName:PingFang size:13.0];
        _otherMessage_label.textColor = kColorFF38;
    }
    return _otherMessage_label;
}

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = kColoreeee;
    }
    return _line_view;
}

- (UITextField *)quality_field
{
    if (_quality_field == nil) {
        _quality_field = [UITextField textBackGroundImage:@"input-box-" titleName:@"属          性" rightImage:@"xinghao" placeholder:@"请输入属性值"];
    }
    return _quality_field;
}



@end
