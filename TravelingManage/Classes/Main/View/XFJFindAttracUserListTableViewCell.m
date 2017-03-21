//
//  XFJFindAttracUserListTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/21.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJFindAttracUserListTableViewCell.h"

@interface XFJFindAttracUserListTableViewCell()

@property (nonatomic, strong) UILabel *content_label;
@property (nonatomic, strong) UIView *line_view;

@end

@implementation XFJFindAttracUserListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.content_label];
        [self addSubview:self.line_view];
        [self.content_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [self.line_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15.0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15.0);
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
    }
    return self;
}

- (UILabel *)content_label
{
    if (_content_label == nil) {
        _content_label = [[UILabel alloc] init];
        _content_label.textColor = kColor0000;
        _content_label.font = [UIFont fontWithName:PingFang size:13.0];
        _content_label.textAlignment = NSTextAlignmentCenter;
    }
    return _content_label;
}

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = kColoreeee;
    }
    return _line_view;
}

- (void)setFindAttracUserListItem:(XFJFindAttracUserListItem *)findAttracUserListItem
{
    _findAttracUserListItem = findAttracUserListItem;
    self.content_label.text = [NSString stringWithFormat:@"%@",findAttracUserListItem.userName];
}

@end
