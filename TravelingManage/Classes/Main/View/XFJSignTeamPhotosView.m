//
//  XFJSignTeamPhotosView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/3.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJSignTeamPhotosView.h"

@interface XFJSignTeamPhotosView()

@property (nonatomic, strong) UIView *middle_view;
@property (nonatomic, strong) UIView *photosTitle_view;
@property (nonatomic, strong) UILabel *photos_label;

@end

@implementation XFJSignTeamPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.middle_view];
        [self addSubview:self.photosTitle_view];
        [self addSubview:self.photos_label];
        [self.middle_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(8.0);
            make.left.mas_equalTo(self.mas_left);
        }];
        [self.photosTitle_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.middle_view.mas_bottom).mas_offset(16.0);
            make.left.mas_equalTo(12.0);
            make.height.width.mas_equalTo(8.0);
        }];
        [self.photos_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.photosTitle_view.mas_right).mas_offset(8.0);
            make.centerY.mas_equalTo(self.photosTitle_view.mas_centerY);
        }];
    }
    return self;
}

- (UIView *)middle_view
{
    if (_middle_view == nil) {
        _middle_view = [[UIView alloc] init];
        _middle_view.backgroundColor = kColoreeee;
    }
    return _middle_view;
}

- (UIView *)photosTitle_view
{
    if (_photosTitle_view == nil) {
        _photosTitle_view = [[UIView alloc] init];
        _photosTitle_view.backgroundColor = kColor16A7B8;
        _photosTitle_view.layer.cornerRadius = 4.0;
    }
    return _photosTitle_view;
}

- (UILabel *)photos_label
{
    if (_photos_label == nil) {
        _photos_label = [[UILabel alloc] init];
        _photos_label.text = @"凭证照片";
        _photos_label.textColor = kColor2b2b;
        _photos_label.font = [UIFont fontWithName:PingFang size:14.0];
    }
    return _photos_label;
}




@end
