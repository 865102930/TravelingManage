//
//  XFJPleasePerfectView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/4.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJPleasePerfectView.h"

@interface XFJPleasePerfectView()

@property (nonatomic, strong) UIImageView *reject_imageView;

@property (nonatomic, strong) UILabel *reject_label;

@end

@implementation XFJPleasePerfectView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.reject_imageView];
        [self addSubview:self.reject_label];
        [self.reject_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18.0);
            make.top.mas_equalTo(32.0);
            make.height.width.mas_equalTo(8.0);
        }];
        [self.reject_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.reject_imageView.mas_right).mas_offset(10.0);
            make.top.mas_equalTo(19.0);
            make.right.mas_equalTo(-21.0);
        }];
    }
    return self;
}

- (UIImageView *)reject_imageView
{
    if (_reject_imageView == nil) {
        _reject_imageView = [[UIImageView alloc] init];
        _reject_imageView.image = [UIImage originalWithImage:@"attention1-"];
    }
    return _reject_imageView;
}

- (UILabel *)reject_label
{
    if (_reject_label == nil) {
        _reject_label = [[UILabel alloc] init];
        _reject_label.text = [NSString stringWithFormat:@"驳回原因: %@",@"原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因"];
        _reject_label.font = [UIFont fontWithName:PingFang size:13.0];
        _reject_label.numberOfLines = 0;
        _reject_label.textColor = kColorFF4B;
    }
    return _reject_label;
}

@end
