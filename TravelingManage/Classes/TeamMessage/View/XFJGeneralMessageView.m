//
//  XFJGeneralMessageView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/4.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJGeneralMessageView.h"

@interface XFJGeneralMessageView()
@property (nonatomic, strong) UIView *line_view;
//常规信息图片
@property (nonatomic, strong) UIImageView *general_imageView;
//常规信息文字
@property (nonatomic, strong) UILabel *general_label;
@property (nonatomic, strong) UIView *middle_view;

@property (nonatomic, strong) UILabel *teamNumber_label;//团队编号
@property (nonatomic, strong) UILabel *teamNumberContent_label;//团队编号内容
@property (nonatomic, strong) UILabel *traveingName_label;//旅行社名称
@property (nonatomic, strong) UILabel *traveingNameContent_label;//旅行社内容
@property (nonatomic, strong) UILabel *carNumber_label;//车牌号
@property (nonatomic, strong) UILabel *carNumberContent_label;//车牌号内容
@property (nonatomic, strong) UILabel *whereAreFrom_label;//客源地
@property (nonatomic, strong) UILabel *whereAreFromContent_label;//客源地内容
@property (nonatomic, strong) UILabel *end_label;//目的属性
@property (nonatomic, strong) UILabel *endContent_label;//目的属性内容
@property (nonatomic, strong) UILabel *teamPeopleNumber_label;//团队人数
@property (nonatomic, strong) UILabel *teamPeopleNumberContent_label;//团队人数内容
@property (nonatomic, strong) UILabel *teamProperty_label;//团队属性
@property (nonatomic, strong) UILabel *teamPropertyContent_label;//团队属性内容
@property (nonatomic, strong) UILabel *teamDay_label;//行程天数
@property (nonatomic, strong) UILabel *teamDayContent_label;//行程天数内容
@property (nonatomic, strong) UILabel *outTeamTime_label;//出团日期
@property (nonatomic, strong) UILabel *outTeamTimeContent_label;//出团日期内容
@end

@implementation XFJGeneralMessageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.line_view];
        [self addSubview:self.general_imageView];
        [self addSubview:self.general_label];
        [self addSubview:self.middle_view];
        [self addSubview:self.teamNumber_label];
        [self addSubview:self.traveingName_label];
        [self addSubview:self.carNumber_label];
        [self addSubview:self.whereAreFrom_label];
        [self addSubview:self.end_label];
        [self addSubview:self.teamPeopleNumber_label];
        [self addSubview:self.teamProperty_label];
        [self addSubview:self.teamDay_label];
        [self addSubview:self.outTeamTime_label];
        [self addSubview:self.teamNumberContent_label];
        [self addSubview:self.traveingNameContent_label];
        [self addSubview:self.carNumberContent_label];
        [self addSubview:self.whereAreFromContent_label];
        [self addSubview:self.endContent_label];
        [self addSubview:self.teamPeopleNumberContent_label];
        [self addSubview:self.teamPropertyContent_label];
        [self addSubview:self.teamDayContent_label];
        [self addSubview:self.outTeamTimeContent_label];
        
        [self.line_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(2.0);
        }];
        [self.general_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.line_view.mas_bottom).mas_offset(9.0);
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.width.mas_equalTo(10.0);
            make.height.mas_equalTo(12.0);
        }];
        [self.general_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.general_imageView.mas_right).mas_offset(8.0);
            make.centerY.mas_equalTo(self.general_imageView.mas_centerY);
        }];
        [self.middle_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(0.5);
            make.top.mas_equalTo(self.general_label.mas_bottom).mas_offset(8.0);
        }];
        [self.teamNumber_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.top.mas_equalTo(self.middle_view.mas_bottom).mas_offset(11.0);
        }];
        [self.traveingName_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.top.mas_equalTo(self.teamNumber_label.mas_bottom).mas_offset(12.0);
        }];
        [self.carNumber_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.traveingName_label.mas_bottom).mas_offset(12.0);
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
        }];
        [self.whereAreFrom_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.top.mas_equalTo(self.carNumber_label.mas_bottom).mas_offset(12.0);
        }];
        [self.end_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.top.mas_equalTo(self.whereAreFrom_label.mas_bottom).mas_offset(12.0);
        }];
        [self.teamPeopleNumber_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.top.mas_equalTo(self.end_label.mas_bottom).mas_offset(12.0);
        }];
        [self.teamProperty_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.end_label.mas_top);
        }];
        [self.teamDay_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.teamPeopleNumber_label.mas_top);
        }];
        [self.outTeamTime_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.teamNumber_label.mas_top);
        }];
        [self.teamNumberContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.teamNumber_label.mas_right).mas_offset(20.0);
            make.centerY.mas_equalTo(self.teamNumber_label.mas_centerY);
        }];
        [self.traveingNameContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.traveingName_label.mas_centerY);
            make.left.mas_equalTo(self.traveingName_label.mas_right).mas_equalTo(20.0);
        }];
        [self.carNumberContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.carNumber_label.mas_centerY);
            make.left.mas_equalTo(self.carNumber_label.mas_right).mas_equalTo(20.0);
        }];
        [self.whereAreFromContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.whereAreFrom_label.mas_centerY);
            make.left.mas_equalTo(self.whereAreFrom_label.mas_right).mas_equalTo(20.0);
        }];
        [self.endContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.end_label.mas_centerY);
            make.left.mas_equalTo(self.end_label.mas_right).mas_equalTo(20.0);
        }];
        [self.teamPeopleNumberContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.teamPeopleNumber_label.mas_centerY);
            make.left.mas_equalTo(self.teamPeopleNumber_label.mas_right).mas_equalTo(20.0);
        }];
        [self.teamPropertyContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.teamProperty_label.mas_centerY);
            make.left.mas_equalTo(self.teamProperty_label.mas_right).mas_equalTo(20.0);
        }];
        [self.teamDayContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.teamDay_label.mas_centerY);
            make.left.mas_equalTo(self.teamDay_label.mas_right).mas_equalTo(20.0);
        }];
        [self.outTeamTimeContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.outTeamTime_label.mas_centerY);
            make.left.mas_equalTo(self.outTeamTime_label.mas_right).mas_equalTo(20.0);
        }];
    }
    return self;
}

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = kColoreeee;
    }
    return _line_view;
}

- (UIImageView *)general_imageView
{
    if (_general_imageView == nil) {
        _general_imageView = [[UIImageView alloc] init];
        _general_imageView.image = [UIImage originalWithImage:@"information-"];
    }
    return _general_imageView;
}

- (UILabel *)general_label
{
    if (_general_label == nil) {
        _general_label = [[UILabel alloc] init];
        _general_label.text = @"常规信息";
        _general_label.font = [UIFont fontWithName:PingFang size:13.0];
        _general_label.textColor = kColorFF38;
    }
    return _general_label;
}

- (UIView *)middle_view
{
    if (_middle_view == nil) {
        _middle_view = [[UIView alloc] init];
        _middle_view.backgroundColor = kColoreeee;
    }
    return _middle_view;
}

- (UILabel *)teamNumber_label
{
    if (_teamNumber_label == nil) {
        _teamNumber_label = [[UILabel alloc] init];
        _teamNumber_label.text = @"团 队 编 号";
        _teamNumber_label.font = [UIFont fontWithName:PingFang size:12.0];
        _teamNumber_label.textColor = kColor6262;
    }
    return _teamNumber_label;
}

- (UILabel *)traveingName_label
{
    if (_traveingName_label == nil) {
        _traveingName_label = [[UILabel alloc] init];
        _traveingName_label.text = @"旅行社名称";
        _traveingName_label.font = [UIFont fontWithName:PingFang size:12.0];
        _traveingName_label.textColor = kColor6262;
    }
    return _traveingName_label;
}

- (UILabel *)carNumber_label
{
    if (_carNumber_label == nil) {
        _carNumber_label = [[UILabel alloc] init];
        _carNumber_label.text = @"车   牌   号";
        _carNumber_label.font = [UIFont fontWithName:PingFang size:12.0];
        _carNumber_label.textColor = kColor6262;
    }
    return _carNumber_label;
}

- (UILabel *)whereAreFrom_label
{
    if (_whereAreFrom_label == nil) {
        _whereAreFrom_label = [[UILabel alloc] init];
        _whereAreFrom_label.text = @"客   源   地";
        _whereAreFrom_label.font = [UIFont fontWithName:PingFang size:12.0];
        _whereAreFrom_label.textColor = kColor6262;
    }
    return _whereAreFrom_label;
}

- (UILabel *)end_label
{
    if (_end_label == nil) {
        _end_label = [[UILabel alloc] init];
        _end_label.text = @"目 的 属 性";
        _end_label.font = [UIFont fontWithName:PingFang size:12.0];
        _end_label.textColor = kColor6262;
    }
    return _end_label;
}

- (UILabel *)teamPeopleNumber_label
{
    if (_teamPeopleNumber_label == nil) {
        _teamPeopleNumber_label = [[UILabel alloc] init];
        _teamPeopleNumber_label.text = @"团 队 人 数";
        _teamPeopleNumber_label.font = [UIFont fontWithName:PingFang size:12.0];
        _teamPeopleNumber_label.textColor = kColor6262;
    }
    return _teamPeopleNumber_label;
}

- (UILabel *)teamProperty_label
{
    if (_teamProperty_label == nil) {
        _teamProperty_label = [[UILabel alloc] init];
        _teamProperty_label.text = @"团 队 性 质";
        _teamProperty_label.font = [UIFont fontWithName:PingFang size:12.0];
        _teamProperty_label.textColor = kColor6262;
    }
    return _teamProperty_label;
}

- (UILabel *)teamDay_label
{
    if (_teamDay_label == nil) {
        _teamDay_label = [[UILabel alloc] init];
        _teamDay_label.text = @"行 程 天 数";
        _teamDay_label.font = [UIFont fontWithName:PingFang size:12.0];
        _teamDay_label.textColor = kColor6262;
    }
    return _teamDay_label;
}

- (UILabel *)outTeamTime_label
{
    if (_outTeamTime_label == nil) {
        _outTeamTime_label = [[UILabel alloc] init];
        _outTeamTime_label.text = @"出 团 日 期";
        _outTeamTime_label.font = [UIFont fontWithName:PingFang size:12.0];
        _outTeamTime_label.textColor = kColor6262;
    }
    return _outTeamTime_label;
}

- (UILabel *)teamNumberContent_label
{
    if (_teamNumberContent_label == nil) {
        _teamNumberContent_label = [[UILabel alloc] init];
        _teamNumberContent_label.font = [UIFont fontWithName:PingFang size:13.0];
        _teamNumberContent_label.textColor = kColor2f2f;
    }
    return _teamNumberContent_label;
}
- (UILabel *)traveingNameContent_label
{
    if (_traveingNameContent_label == nil) {
        _traveingNameContent_label = [[UILabel alloc] init];
        _traveingNameContent_label.font = [UIFont fontWithName:PingFang size:13.0];
        _traveingNameContent_label.textColor = kColor2f2f;
    }
    return _traveingNameContent_label;
}

- (UILabel *)carNumberContent_label
{
    if (_carNumberContent_label == nil) {
        _carNumberContent_label = [[UILabel alloc] init];
        _carNumberContent_label.font = [UIFont fontWithName:PingFang size:13.0];
        _carNumberContent_label.textColor = kColor2f2f;
    }
    return _carNumberContent_label;
}

- (UILabel *)whereAreFromContent_label
{
    if (_whereAreFromContent_label == nil) {
        _whereAreFromContent_label = [[UILabel alloc] init];
        _whereAreFromContent_label.font = [UIFont fontWithName:PingFang size:13.0];
        _whereAreFromContent_label.textColor = kColor2f2f;
    }
    return _whereAreFromContent_label;
}

- (UILabel *)endContent_label
{
    if (_endContent_label == nil) {
        _endContent_label = [[UILabel alloc] init];
        _endContent_label.font = [UIFont fontWithName:PingFang size:13.0];
        _endContent_label.textColor = kColor2f2f;
    }
    return _endContent_label;
}

- (UILabel *)teamPeopleNumberContent_label
{
    if (_teamPeopleNumberContent_label == nil) {
        _teamPeopleNumberContent_label = [[UILabel alloc] init];
        _teamPeopleNumberContent_label.font = [UIFont fontWithName:PingFang size:13.0];
        _teamPeopleNumberContent_label.textColor = kColor2f2f;
    }
    return _teamPeopleNumberContent_label;
}

- (UILabel *)teamPropertyContent_label
{
    if (_teamPropertyContent_label == nil) {
        _teamPropertyContent_label = [[UILabel alloc] init];
        _teamPropertyContent_label.font = [UIFont fontWithName:PingFang size:13.0];
        _teamPropertyContent_label.textColor = kColor2f2f;
    }
    return _teamPropertyContent_label;
}

- (UILabel *)teamDayContent_label
{
    if (_teamDayContent_label == nil) {
        _teamDayContent_label = [[UILabel alloc] init];
        _teamDayContent_label.font = [UIFont fontWithName:PingFang size:13.0];
        _teamDayContent_label.textColor = kColor2f2f;
    }
    return _teamDayContent_label;
}

- (UILabel *)outTeamTimeContent_label
{
    if (_outTeamTimeContent_label == nil) {
        _outTeamTimeContent_label = [[UILabel alloc] init];
        _outTeamTimeContent_label.font = [UIFont fontWithName:PingFang size:13.0];
        _outTeamTimeContent_label.textColor = kColor2f2f;
    }
    return _outTeamTimeContent_label;
}

- (void)setFindTeamTasksItem:(NSMutableArray<XFJFindTeamTasksItem *> *)findTeamTasksItem
{
    _findTeamTasksItem = findTeamTasksItem;
    //团队编号
    self.teamNumberContent_label.text = [NSString stringWithFormat:@"%zd",findTeamTasksItem[0].teamNo];
    //旅行社名称
     self.traveingNameContent_label.text = [NSString stringWithFormat:@"%@",findTeamTasksItem[0].travelAgencyName];
    //车牌号
    self.carNumberContent_label.text = [NSString stringWithFormat:@"%@",findTeamTasksItem[0].vehicleNo];
    //客源地
    self.whereAreFromContent_label.text = [NSString stringWithFormat:@"%@%@%@",findTeamTasksItem[0].province,findTeamTasksItem[0].city,findTeamTasksItem[0].area];
    //目的属性
    self.endContent_label.text = [NSString stringWithFormat:@"%@",findTeamTasksItem[0].teamAttrVal];
    //团队人数
    self.teamPeopleNumberContent_label.text = [NSString stringWithFormat:@"%zd",findTeamTasksItem[0].teamNum];
    //团队性质
    self.teamPropertyContent_label.text = [NSString stringWithFormat:@"%@",findTeamTasksItem[0].teamNatureVal];
    //行程天数
    self.teamDayContent_label.text = [NSString stringWithFormat:@"%zd",findTeamTasksItem[0].teamDay];
    //出团日期
    self.outTeamTimeContent_label.text = [NSString stringWithFormat:@"%@",findTeamTasksItem[0].teamDate];
}



@end
