//
//  XFJTitleMessageContentTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/20.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJTitleMessageContentTableViewCell.h"

@interface XFJTitleMessageContentTableViewCell()

@property (nonatomic, strong) UILabel *contentTitle_label;

@property (nonatomic, strong) UILabel *content_label;

@property (nonatomic, strong) UIView *line_view;

@end

@implementation XFJTitleMessageContentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.contentTitle_label];
        [self addSubview:self.content_label];
        [self addSubview:self.line_view];
        [self.contentTitle_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(17.0);
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
        }];
        [self.content_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
            make.centerY.mas_equalTo(self.contentTitle_label.mas_centerY);
        }];
        [self.line_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(0.5);
            make.top.mas_equalTo(self.contentTitle_label.mas_bottom).mas_offset(16.3);
        }];
    }
    return self;
}

- (UILabel *)contentTitle_label
{
    if (_contentTitle_label == nil) {
        _contentTitle_label = [[UILabel alloc] init];
        _contentTitle_label.textColor = kColor2f2f;
        _contentTitle_label.font = [UIFont systemFontOfSize:13.0];
    }
    return _contentTitle_label;
}

- (UILabel *)content_label
{
    if (_content_label == nil) {
        _content_label = [[UILabel alloc] init];
        _content_label.textColor = kColor2f2f;
        _content_label.font = [UIFont systemFontOfSize:14.0];
    }
    return _content_label;
}

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = kColorE9E9;
    }
    return _line_view;
}

- (void)setTitle:(NSString *)title content:(NSString *)content
{
    self.contentTitle_label.text = title;
    self.content_label.text = content;
}

+ (CGFloat)cellHeight
{
    return 49.5;
}



@end
