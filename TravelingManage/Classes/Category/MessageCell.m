//
//  MessageCell.m
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/13.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "MessageCell.h"
static NSString * const MessageCellID = @"MessageCellID";
@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (instancetype)initWithTableView:(UITableView *)tableView {
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:MessageCellID];
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MessageCellID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.circleView];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.enterIntoImage];
        [self.contentView addSubview:self.deleteView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
   
    [self.circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(18);
        make.top.equalTo(self.contentView).offset(19);
        make.size.mas_equalTo(CGSizeMake(6, 6));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView).offset(36);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.left.equalTo(self.contentView).offset(18);
    }];
   
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-18);
        make.top.equalTo(self.contentView).offset(18);
    }];
   
    [self.enterIntoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-18);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(13);
    }];
    
    self.deleteView.frame =CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, 78);
    
    [self.deleteView addSubview:_deleteButton];
    self.deleteButton.frame = CGRectMake(30, 20, 26, 37);
}

- (UIView *)deleteView{
    if (!_deleteView) {
        _deleteView = [[UIView alloc] init];
        _deleteView.backgroundColor = RedColor;
    }
    return _deleteView;
}

- (UILabel *)titleLabel//标题
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont fontWithName:PingFang size:15];
        _titleLabel.textColor = [UIColor colorWithHexString:@"2F2F2F"];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel//原因内容
{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont fontWithName:PingFang size:14];
        _contentLabel.textColor = kColor6565;
    }
    return _contentLabel;
}

- (UIView *)circleView //圆圈
{
    if (!_circleView) {
        _circleView = [[UIView alloc] init];
        _circleView.backgroundColor = RedColor;
        _circleView.layer.masksToBounds = YES;
        _circleView.layer.cornerRadius = 3;
    }
    return _circleView;
}

- (UILabel *)timeLabel //时间
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont fontWithName:PingFang size:12];
        _timeLabel.textColor = kColor959595;
        _timeLabel.text = @"2017-01-07";
    }
    return _timeLabel;
    
}

- (UIImageView *)enterIntoImage{
    if (!_enterIntoImage){
        _enterIntoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"enter"]];
    }
    return _enterIntoImage;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    }
    return _deleteButton;
}

@end
