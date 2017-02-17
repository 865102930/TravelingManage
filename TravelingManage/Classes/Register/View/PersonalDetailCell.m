//
//  PersonalDetailCell.m
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/16.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "PersonalDetailCell.h"
static NSString * const PersonalDetailCellID = @"PersonalDetailCellID";
@implementation PersonalDetailCell


+ (instancetype)initWithTableView:(UITableView *)tableView {
    PersonalDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:PersonalDetailCellID];
    if (cell == nil) {
        cell = [[PersonalDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PersonalDetailCellID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.content];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(18);
        make.top.equalTo(self.contentView).offset(18);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(17);
        make.right.equalTo(self.contentView).offset(-18);
    }];

}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init ];
        _title.textColor = kColor6565;
        _title.font = [UIFont fontWithName:PingFang size:14];
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}

- (UILabel *)content{
    if (!_content) {
        _content = [[UILabel alloc] init ];
        _content.textColor = kColor2f2f;
        _content.font = [UIFont fontWithName:PingFang size:15];
        _content.textAlignment = NSTextAlignmentLeft;
        _content.numberOfLines = 0;
    }
    return _content;
}

@end
