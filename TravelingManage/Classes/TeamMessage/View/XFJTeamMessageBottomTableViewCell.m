//
//  XFJTeamMessageBottomTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/20.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJTeamMessageBottomTableViewCell.h"

@interface XFJTeamMessageBottomTableViewCell()

@property (nonatomic, strong) UIImageView *titleMessage_imageView;

@property (nonatomic, strong) UILabel *titleMessage_label;

@end

@implementation XFJTeamMessageBottomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleMessage_imageView];
        [self addSubview:self.titleMessage_label];
        [self.titleMessage_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(17.0);
            make.left.mas_equalTo(18.0);
            make.height.mas_equalTo(15.0);
            make.width.mas_equalTo(13.0);
        }];
        [self.titleMessage_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleMessage_imageView.mas_top);
            make.left.mas_equalTo(self.titleMessage_imageView.mas_right).mas_offset(10.0);
        }];
    }
    return self;
}

- (UIImageView *)titleMessage_imageView
{
    if (_titleMessage_imageView == nil) {
        _titleMessage_imageView = [[UIImageView alloc] init];
        _titleMessage_imageView.image = [UIImage originalWithImage:@"information-"];
    }
    return _titleMessage_imageView;
}

- (UILabel *)titleMessage_label
{
    if (_titleMessage_label == nil) {
        _titleMessage_label = [[UILabel alloc] init];
        _titleMessage_label.textColor = kColorff47;
        _titleMessage_label.font = [UIFont systemFontOfSize:15.0];
    }
    return _titleMessage_label;
}

+ (CGFloat)cellHeight
{
    return 300.0;
}


@end
