//
//  XFJAnnouncementView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/10.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJAnnouncementView.h"
#import <Masonry.h>

@interface XFJAnnouncementView()

@property (nonatomic, strong) UIImageView *backGroundImageView;

@property (nonatomic, strong) UIImageView *pictureImageView;

@property (nonatomic, strong) UILabel *content_label;

@end

@implementation XFJAnnouncementView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.backGroundImageView];
        [self.backGroundImageView addSubview:self.pictureImageView];
        [self.backGroundImageView addSubview:self.content_label];
        [self setUpControlWithMas];
    }
    return self;
}

- (UIImageView *)backGroundImageView
{
    if (_backGroundImageView == nil) {
        _backGroundImageView = [[UIImageView alloc] init];
        _backGroundImageView.image = [UIImage originalWithImage:@"gonggao"];
        _backGroundImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTapped)];
        //点击图片事件
        [_backGroundImageView addGestureRecognizer:singleTap];
    }
    return _backGroundImageView;
}

- (void)photoTapped
{
    if (self.clickAnnouncementBlock) {
        self.clickAnnouncementBlock();
    }
}

- (UIImageView *)pictureImageView
{
    if (_pictureImageView == nil) {
        _pictureImageView = [[UIImageView alloc] init];
        _pictureImageView.image = [UIImage originalWithImage:@"laba"];
    }
    return _pictureImageView;
}

- (UILabel *)content_label
{
    if (_content_label == nil) {
        _content_label = [[UILabel alloc] init];
        _content_label.textAlignment = NSTextAlignmentLeft;
        _content_label.textColor = kColor6c6c;
        [_content_label setFont:[UIFont systemFontOfSize:12]];
        _content_label.text = @"公告公告公告公告公告公告公告公告";
        _content_label.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _content_label;
}

- (void)setUpControlWithMas
{
    [self.backGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(self.mas_height);
    }];
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(15.0);
        make.left.mas_equalTo(self.mas_left).mas_offset(25.0);
        make.height.mas_equalTo(12.0);
        make.width.mas_equalTo(14.0);
    }];
    [self.content_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(16.0);
        make.left.mas_equalTo(self.pictureImageView.mas_right).mas_offset(12.0);
        make.centerY.mas_equalTo(self.pictureImageView.mas_centerY);
    }];
}



@end
