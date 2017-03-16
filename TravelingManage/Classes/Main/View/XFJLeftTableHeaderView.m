//
//  XFJLeftTableHeaderView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJLeftTableHeaderView.h"
#import <Masonry.h>

@interface XFJLeftTableHeaderView()

@property (nonatomic, strong) UIImageView *headerImageView;

@property (nonatomic, strong) UIButton *userName_label;

@property (nonatomic, strong) UIButton *phoneNumber_label;

@property (nonatomic, strong) UIButton *viewThePersonalDetailsPageButton;

@property (nonatomic, strong) NSUserDefaults *user;

@end

@implementation XFJLeftTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _user = [NSUserDefaults standardUserDefaults];
        [_user synchronize];
        [self addSubview:self.headerImageView];
        [self addSubview:self.userName_label];
        [self addSubview:self.phoneNumber_label];
        [self addSubview:self.viewThePersonalDetailsPageButton];
        [self.headerImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(38.0);
            make.left.mas_equalTo(self.mas_left).mas_offset(12.0);
            make.width.height.mas_equalTo(46.0);
        }];
        [self.viewThePersonalDetailsPageButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(38.0);
            make.left.mas_equalTo(self.headerImageView.mas_right).mas_offset(10.0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 3, 50));
        }];
        [self.userName_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(41.0);
            make.left.mas_equalTo(self.headerImageView.mas_right).mas_offset(10.0);
            make.height.mas_equalTo(15.0);
        }];
        [self.phoneNumber_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.userName_label.mas_bottom).mas_offset(8.0);
            make.left.mas_equalTo(self.userName_label.mas_left);
            make.height.mas_equalTo(15.0);
        }];
        
    }
    return self;
}

#pragma mark - 头像
- (UIImageView *)headerImageView
{
    if (_headerImageView == nil) {
        _headerImageView = [[UIImageView alloc] init];
        [_headerImageView setImage:[UIImage originalWithImage:@"message"]];
        _headerImageView.userInteractionEnabled = YES;
        [_headerImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerImageView:)]];
    }
    return _headerImageView;
}

#pragma mark - 头像的点击事件
- (void)headerImageView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushToNoticeOfController)]) {
        [self.delegate pushToNoticeOfController];
    }
}

#pragma mark - 查看个人详情页按钮
- (UIButton *)viewThePersonalDetailsPageButton {
    if (!_viewThePersonalDetailsPageButton) {
        _viewThePersonalDetailsPageButton = [[UIButton alloc] init];
        _viewThePersonalDetailsPageButton.backgroundColor = [UIColor clearColor];
        [_viewThePersonalDetailsPageButton addTarget:self action:@selector(modifyUserInformation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _viewThePersonalDetailsPageButton;
}

#pragma mark - 用户名
- (UIButton *)userName_label
{
    if (_userName_label == nil) {
        _userName_label = [[UIButton alloc] init];
        [_userName_label setTitle:[_user objectForKey:@"userName"] forState:UIControlStateNormal];
        [_userName_label setTitleColor:kColor2b2b forState:UIControlStateNormal];
        _userName_label.titleLabel.textAlignment = NSTextAlignmentLeft;
        _userName_label.titleLabel.font = [UIFont systemFontOfSize:14.0];
//        [_userName_label addTarget:self action:@selector(modifyUserInformation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userName_label;
}

#pragma mark - 电话号码
- (UIButton *)phoneNumber_label
{
    if (_phoneNumber_label == nil) {
        _phoneNumber_label = [[UIButton alloc] init];
        [_phoneNumber_label setTitle:[_user objectForKey:@"phone"] forState:UIControlStateNormal];
        [_phoneNumber_label setTitleColor:kColor2b2b forState:UIControlStateNormal];
        _phoneNumber_label.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _phoneNumber_label.titleLabel.textAlignment = NSTextAlignmentLeft;
//        [_phoneNumber_label addTarget:self action:@selector(modifyUserInformation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneNumber_label;
}

- (void)modifyUserInformation
{
    if (self.changeUserInformationBlock) {
        self.changeUserInformationBlock();
    }
}


@end
