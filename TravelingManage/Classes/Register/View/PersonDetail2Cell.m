//
//  PersonDetail2Cell.m
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/16.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "PersonDetail2Cell.h"
static NSString * const PersonDetail2CellID= @"PersonDetail2CellID";
@implementation PersonDetail2Cell


+ (instancetype)initWithTableView:(UITableView *)tableView {
    PersonDetail2Cell *cell = [tableView dequeueReusableCellWithIdentifier:PersonDetail2CellID];
    if (cell == nil) {
        cell = [[PersonDetail2Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PersonDetail2CellID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.content];
        [self.contentView addSubview:self.rightImage];
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
   
    [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(18);
        make.right.equalTo(self.contentView).offset(-24);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(10);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(17);
        make.right.equalTo(self.rightImage.mas_left).offset(-17);
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

- (UIImageView *)rightImage{
    if (!_rightImage){
        _rightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"getInto"]];
    }
    return _rightImage;
}

@end
