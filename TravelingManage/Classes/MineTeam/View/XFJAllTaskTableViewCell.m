//
//  XFJAllTaskTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/15.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJAllTaskTableViewCell.h"

@interface XFJAllTaskTableViewCell()

@property (nonatomic, strong) UIView *line_view;

@property (nonatomic, strong) UILabel *teamNumber_label;

@property (nonatomic, strong) UILabel *teamNumber_label2;

@property (nonatomic, strong) UIView *contentBackGround_view;

@property (nonatomic, strong) UILabel *teamPeople_label;

@property (nonatomic, strong) UILabel *teamPeople_label2;

@property (nonatomic, strong) UILabel *travelServiceName_label;

@property (nonatomic, strong) UILabel *travelServiceName_label2;

@property (nonatomic, strong) UILabel *startTeamTime_label;

@property (nonatomic, strong) UILabel *startTeamTime_label2;

@property (nonatomic, strong) UILabel *taskStatus_label;

@property (nonatomic, strong) UIButton *status_button;

@end

@implementation XFJAllTaskTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpContentWithAllTask];
        [self setUpContentAllTaskWithMas];
    }
    return self;
}

- (void)setUpContentWithAllTask
{
    [self addSubview:self.line_view];
    [self addSubview:self.teamNumber_label];
    [self addSubview:self.teamNumber_label2];
    [self addSubview:self.contentBackGround_view];
    [self addSubview:self.teamPeople_label];
    [self addSubview:self.teamPeople_label2];
    [self addSubview:self.travelServiceName_label];
    [self addSubview:self.travelServiceName_label2];
    [self addSubview:self.startTeamTime_label2];
    [self addSubview:self.startTeamTime_label];
    [self addSubview:self.taskStatus_label];
}

- (void)setUpContentAllTaskWithMas
{
    [self.line_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.height.mas_equalTo(7.0);
        make.right.mas_equalTo(self.mas_right);
    }];
    [self.teamNumber_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line_view.mas_bottom).mas_offset(14.0);
        make.left.mas_equalTo(self.mas_left).mas_offset(17.0);
        make.width.mas_equalTo(80.0);
    }];
    [self.teamNumber_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.teamNumber_label.mas_right).mas_offset(5.0);
        make.centerY.mas_equalTo(self.teamNumber_label.mas_centerY);
    }];
    [self.contentBackGround_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line_view.mas_bottom).mas_offset(39.0);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(74.0);
    }];
    [self.teamPeople_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentBackGround_view.mas_top).mas_offset(13.0);
        make.left.mas_equalTo(self.contentBackGround_view.mas_left).mas_offset(17.0);
        make.width.mas_equalTo(80.0);
    }];
    [self.teamPeople_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.teamPeople_label.mas_right).mas_offset(5.0);
        make.centerY.mas_equalTo(self.teamPeople_label.mas_centerY);
    }];
    [self.travelServiceName_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.teamPeople_label.mas_bottom).mas_offset(16.0);
        make.left.mas_equalTo(self.contentBackGround_view.mas_left).mas_offset(17.0);
        make.width.mas_equalTo(80.0);
    }];
    [self.travelServiceName_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.travelServiceName_label.mas_right).mas_offset(5.0);
        make.centerY.mas_equalTo(self.travelServiceName_label.mas_centerY);
    }];
    [self.startTeamTime_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentBackGround_view.mas_top).mas_offset(13.0);
        make.right.mas_equalTo(self.contentBackGround_view.mas_right).mas_offset(-17.0);
        make.width.mas_equalTo(80.0);
    }];
    [self.startTeamTime_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.startTeamTime_label2.mas_top);
        make.right.mas_equalTo(self.startTeamTime_label2.mas_left).mas_offset(-10);
    }];
}

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = kColoreeee;
    }
    return _line_view;
}

- (UILabel *)teamNumber_label
{
    if (_teamNumber_label == nil) {
        _teamNumber_label = [[UILabel alloc] init];
        _teamNumber_label.textAlignment = NSTextAlignmentLeft;
        _teamNumber_label.text = [NSString stringWithFormat:@"团 队 编 号:"];
        _teamNumber_label.textColor = kColor5858;
        _teamNumber_label.font = [UIFont systemFontOfSize:14.0];
    }
    return _teamNumber_label;
}

- (UILabel *)teamNumber_label2
{
    if (_teamNumber_label2 == nil) {
        _teamNumber_label2 = [[UILabel alloc] init];
        _teamNumber_label2.textAlignment = NSTextAlignmentLeft;
        _teamNumber_label2.text = [NSString stringWithFormat:@"0000"];
        _teamNumber_label2.textColor = kColor2b2b;
        _teamNumber_label2.font = [UIFont systemFontOfSize:14.0];
    }
    return _teamNumber_label2;
}

- (UIView *)contentBackGround_view
{
    if (_contentBackGround_view == nil) {
        _contentBackGround_view = [[UIView alloc] init];
        _contentBackGround_view.backgroundColor = kColorF7F7;
    }
    return _contentBackGround_view;
}

- (UILabel *)teamPeople_label
{
    if (_teamPeople_label == nil) {
        _teamPeople_label = [[UILabel alloc] init];
        _teamPeople_label.textAlignment = NSTextAlignmentLeft;
        _teamPeople_label.text = [NSString stringWithFormat:@"团 队 人 数:"];
        _teamPeople_label.textColor = kColor5858;
        _teamPeople_label.font = [UIFont systemFontOfSize:14.0];
    }
    return _teamPeople_label;
}

- (UILabel *)teamPeople_label2
{
    if (_teamPeople_label2 == nil) {
        _teamPeople_label2 = [[UILabel alloc] init];
        _teamPeople_label2.textAlignment = NSTextAlignmentLeft;
        _teamPeople_label2.text = [NSString stringWithFormat:@"22人"];
        _teamPeople_label2.textColor = kColor2b2b;
        _teamPeople_label2.font = [UIFont systemFontOfSize:14.0];
    }
    return _teamPeople_label2;
}

- (UILabel *)travelServiceName_label
{
    if (_travelServiceName_label == nil) {
        _travelServiceName_label = [[UILabel alloc] init];
        _travelServiceName_label.textAlignment = NSTextAlignmentLeft;
        _travelServiceName_label.text = [NSString stringWithFormat:@"旅行社名称:"];
        _travelServiceName_label.textColor = kColor5858;
        _travelServiceName_label.font = [UIFont systemFontOfSize:14.0];
    }
    return _travelServiceName_label;
}

- (UILabel *)travelServiceName_label2
{
    if (_travelServiceName_label2 == nil) {
        _travelServiceName_label2 = [[UILabel alloc] init];
        _travelServiceName_label2.textAlignment = NSTextAlignmentLeft;
        _travelServiceName_label2.text = [NSString stringWithFormat:@"张全蛋旅社"];
        _travelServiceName_label2.textColor = kColor2b2b;
        _travelServiceName_label2.font = [UIFont systemFontOfSize:14.0];
    }
    return _travelServiceName_label2;
}

- (UILabel *)startTeamTime_label2
{
    if (_startTeamTime_label2 == nil) {
        _startTeamTime_label2 = [[UILabel alloc] init];
        _startTeamTime_label2.textAlignment = NSTextAlignmentLeft;
        _startTeamTime_label2.text = [NSString stringWithFormat:@"2017-02-23"];
        _startTeamTime_label2.textColor = kColor2b2b;
        _startTeamTime_label2.font = [UIFont systemFontOfSize:14.0];
    }
    return _startTeamTime_label2;
}

- (UILabel *)startTeamTime_label
{
    if (_startTeamTime_label == nil) {
        _startTeamTime_label = [[UILabel alloc] init];
        _startTeamTime_label.textAlignment = NSTextAlignmentLeft;
        _startTeamTime_label.text = [NSString stringWithFormat:@"出 团 日 期:"];
        _startTeamTime_label.textColor = kColor5858;
        _startTeamTime_label.font = [UIFont systemFontOfSize:14.0];
    }
    return _startTeamTime_label;
}



- (UILabel *)taskStatus_label
{
    if (_taskStatus_label == nil) {
        _taskStatus_label = [[UILabel alloc] init];
//        _taskStatus_label.text = [NSString stringWithFormat:<#(nonnull NSString *), ...#>]
        
        
        
    }
    return _taskStatus_label;
}
+ (CGFloat)cellHeight
{
    return 170.0;
}

@end
