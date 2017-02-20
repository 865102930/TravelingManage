//
//  XFJTitleMessageTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/20.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJTitleMessageTableViewCell.h"

@interface XFJTitleMessageTableViewCell()

@property (nonatomic, strong) UIImageView *title_imageView;

@property (nonatomic, strong) UILabel *title_label;

@property (nonatomic, strong) UIView *line_view;


@end

@implementation XFJTitleMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
            [self addSubview:self.title_imageView];
            [self addSubview:self.title_label];
            [self addSubview:self.line_view];
            [self.title_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(17.0);
                make.left.mas_equalTo(18.0);
                make.height.mas_equalTo(15.0);
                make.width.mas_equalTo(13.0);
            }];
            [self.title_label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.title_imageView.mas_top);
                make.left.mas_equalTo(self.title_imageView.mas_right).mas_offset(10.0);
            }];
            [self.line_view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.title_imageView.mas_bottom).mas_offset(17.0);
                make.left.mas_equalTo(self.mas_left);
                make.right.mas_equalTo(self.mas_right);
                make.height.mas_equalTo(0.5);
            }];
    }
    return self;
}

- (UIImageView *)title_imageView
{
    if (_title_imageView == nil) {
        _title_imageView = [[UIImageView alloc] init];
        _title_imageView.image = [UIImage originalWithImage:@"information-"];
    }
    return _title_imageView;
}

- (UILabel *)title_label
{
    if (_title_label == nil) {
        _title_label = [[UILabel alloc] init];
        _title_label.textColor = kColorff47;
        _title_label.font = [UIFont systemFontOfSize:15.0];
    }
    return _title_label;
}

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = kColoreeee;
    }
    return _line_view;
}

- (void)setTitle:(NSString *)title
{
    self.title_label.text = title;
}
+ (CGFloat)cellHeight
{
    return 49.5;
}


@end
