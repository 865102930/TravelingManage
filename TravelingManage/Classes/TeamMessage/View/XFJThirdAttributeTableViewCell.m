//
//  XFJThirdAttributeTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJThirdAttributeTableViewCell.h"
#import "UIPlaceHolderTextView.h"
@interface XFJThirdAttributeTableViewCell()

@property (nonatomic, strong) UIPlaceHolderTextView *textView;
@property (nonatomic, strong) UIImageView *textView_imageView;
@property (nonatomic, strong) UILabel *title_label;
@property (nonatomic, strong) UIImageView *star_imageView;

@end

@implementation XFJThirdAttributeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.textView];
        [self.textView addSubview:self.textView_imageView];
        [self.textView addSubview:self.title_label];
        [self.textView addSubview:self.star_imageView];
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
            make.height.mas_equalTo(90.0);
            make.top.mas_equalTo(9.0);
        }];
        [self.textView_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
            make.height.mas_equalTo(90.0);
            make.top.mas_equalTo(0);
        }];
        [self.title_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.textView).mas_offset(15.0);
            make.top.mas_equalTo(self.textView.mas_top).mas_offset(9.0);
        }];
        [self.star_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.title_label.mas_centerY);
            make.height.with.mas_equalTo(4.0);
            make.left.mas_equalTo(self.title_label.mas_right).mas_offset(2.0);
        }];
    }
    return self;
}
- (UIPlaceHolderTextView *)textView
{
    if (_textView == nil) {
        _textView = [[UIPlaceHolderTextView alloc] init];
        _textView.placeholderColor = [UIColor lightGrayColor];
        _textView.tintColor = [UIColor lightGrayColor];
        if (_textView.contentSize.height >= _textView.frame.size.height) {
            [_textView setUserInteractionEnabled:YES];
        }
        _textView.textContainerInset = UIEdgeInsetsMake(9.0, 100, 0, 0);
    }
    return _textView;
}

- (UIImageView *)textView_imageView
{
    if (_textView_imageView == nil) {
        _textView_imageView = [[UIImageView alloc] init];
        _textView_imageView.image = [UIImage originalWithImage:@"big-input"];
    }
    return _textView_imageView;
}

- (UILabel *)title_label
{
    if (_title_label == nil) {
        _title_label = [[UILabel alloc] init];
        _title_label.text = @"属          性";
        _title_label.font = [UIFont systemFontOfSize:13.0];
        _title_label.textColor = kColor2f2f;
    }
    return _title_label;
}

- (UIImageView *)star_imageView
{
    if (_star_imageView == nil) {
        _star_imageView = [[UIImageView alloc] init];
        _star_imageView.image = [UIImage originalWithImage:@"xinghao"];
    }
    return _star_imageView;
}



@end
