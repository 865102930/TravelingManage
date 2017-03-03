//
//  AnnouncementCell.m
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/13.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "AnnouncementCell.h"
#import "AnnouncementModel.h"

static NSString * const AnnouncementCellID = @"AnnouncementCellID";
@implementation AnnouncementCell

+ (instancetype)initWithTableView:(UITableView *)tableView {
    AnnouncementCell *cell = [tableView dequeueReusableCellWithIdentifier:AnnouncementCellID];
    if (cell == nil) {
        cell = [[AnnouncementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AnnouncementCellID];
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
        [self.contentView addSubview:self.grayView];
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
        make.right.equalTo(self.contentView).offset(-18);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-18);
        make.top.equalTo(self.contentView).offset(18);
    }];
    
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(8);
    }];
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
        _contentLabel.numberOfLines = 4;
    }
    return _contentLabel;
}

- (UIView *)circleView //圆圈
{
    if (!_circleView) {
        _circleView = [[UIView alloc] init];
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
    }
    return _timeLabel;
    
}

- (UIView *)grayView{
    if (!_grayView){
        _grayView = [[UIView alloc] init];
        _grayView.backgroundColor = BackgroudColor;
    }
    return _grayView;
}

- (void)setAnnouncementM:(AnnouncementModel *)announcementM{
    _announcementM = announcementM;
    _titleLabel.text = announcementM.announcementTitle;
    _timeLabel.text = announcementM.createtime;
    _contentLabel.text = announcementM.announcementDetail;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_contentLabel.text length])];
    _contentLabel.attributedText = attributedString;
    [_contentLabel sizeToFit];
  
    if ([announcementM.isread isEqualToString:@"0"]){
        _circleView.backgroundColor = RedColor;
    }else {
        _circleView.backgroundColor = [UIColor grayColor];
    }
    
}

@end
