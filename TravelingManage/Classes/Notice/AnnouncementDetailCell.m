//
//  AnnouncementDetailCell.m
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/15.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "AnnouncementDetailCell.h"
static NSString * const AnnouncementDetailCellID = @"AnnouncementDetailCellID";
@implementation AnnouncementDetailCell

+ (instancetype)initWithTableView:(UITableView *)tableView {
    AnnouncementDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:AnnouncementDetailCellID];
    if (cell == nil) {
        cell = [[AnnouncementDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AnnouncementDetailCellID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.conentLabe];
        [self.contentView addSubview:self.lineV];
        [self.contentView addSubview:self.timeLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(16);
    }];
    
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    
    [self.conentLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.lineV.mas_bottom).offset(11);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-18);
        make.top.equalTo(self.contentView).offset(18);
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init ];
        _titleLabel.textColor = kColor2f2f;
        _titleLabel.font = [UIFont fontWithName:PingFang size:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)conentLabe{
    if (!_conentLabe) {
        _conentLabe = [[UILabel alloc] init ];
        _conentLabe.textColor = kColor2f2f;
        _conentLabe.font = [UIFont fontWithName:PingFang size:14];
        _conentLabe.textAlignment = NSTextAlignmentLeft;
        _conentLabe.numberOfLines = 0;
    }
    return _conentLabe;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init ];
        _timeLabel.textColor = kColorACAC;
        _timeLabel.font = [UIFont fontWithName:PingFang size:13];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

- (UIView *)lineV{
    if (!_lineV) {
        _lineV = [[UIView alloc] init];
        _lineV.backgroundColor = [UIColor colorWithRed:47/ 255.0 green:47/ 255.0 blue:47/ 255.0 alpha:0.1];
    }
    return _lineV;
}

@end
