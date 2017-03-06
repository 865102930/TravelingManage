//
//  XFJPleasePerfectMessageTopView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/6.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJPleasePerfectMessageTopView.h"

@interface XFJPleasePerfectMessageTopView()

@property (nonatomic, strong) UIView *line_view;
@property (nonatomic, strong) UILabel *carNumber_label;
@property (nonatomic, strong) UILabel *carNumberContent_label;
@property (nonatomic, strong) UILabel *peopleWhereAreFrom_label;
@property (nonatomic, strong) UILabel *peopleWhereAreFromContent_label;
@property (nonatomic, strong) UILabel *openTeamTime_label;
@property (nonatomic, strong) UILabel *openTeamTimeContent_label;


@end

@implementation XFJPleasePerfectMessageTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.line_view];
        [self addSubview:self.carNumber_label];
        [self addSubview:self.carNumberContent_label];
        [self addSubview:self.peopleWhereAreFromContent_label];
        [self addSubview:self.peopleWhereAreFrom_label];
        [self addSubview:self.openTeamTime_label];
        [self addSubview:self.openTeamTimeContent_label];
        
        [self.line_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(2.0);
        }];
        [self.carNumber_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.top.mas_equalTo(self.line_view.mas_bottom).mas_offset(20.0);
        }];
        [self.carNumberContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.carNumber_label.mas_right).mas_offset(10.0);
            make.centerY.mas_equalTo(self.carNumber_label.mas_centerY);
        }];
        [self.peopleWhereAreFromContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-17.0);
            make.centerY.mas_equalTo(self.carNumber_label.mas_centerY);
        }];
        [self.peopleWhereAreFrom_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.peopleWhereAreFromContent_label.mas_centerY);
            make.right.mas_equalTo(self.peopleWhereAreFromContent_label.mas_left).mas_offset(-10.0);
        }];
        [self.openTeamTime_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.carNumber_label.mas_bottom).mas_offset(15.0);
            make.left.mas_equalTo(self.carNumber_label.mas_left);
        }];
        [self.openTeamTimeContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.openTeamTime_label.mas_centerY);
            make.left.mas_equalTo(self.openTeamTime_label.mas_right).mas_offset(10.0);
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

- (UILabel *)carNumber_label
{
    if (_carNumber_label == nil) {
        _carNumber_label = [[UILabel alloc] init];
        _carNumber_label.text = [NSString stringWithFormat:@"车牌号:"];
        _carNumber_label.font = [UIFont fontWithName:PingFang size:12.0];
        _carNumber_label.textColor = kColor6262;
    }
    return _carNumber_label;
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

- (UILabel *)peopleWhereAreFromContent_label
{
    if (_peopleWhereAreFromContent_label == nil) {
        _peopleWhereAreFromContent_label = [[UILabel alloc] init];
        _peopleWhereAreFromContent_label.font = [UIFont fontWithName:PingFang size:13.0];
        _peopleWhereAreFromContent_label.textColor = kColor2f2f;
    }
    return _peopleWhereAreFromContent_label;
}

- (UILabel *)peopleWhereAreFrom_label
{
    if (_peopleWhereAreFrom_label == nil) {
        _peopleWhereAreFrom_label = [[UILabel alloc] init];
        _peopleWhereAreFrom_label.text = [NSString stringWithFormat:@"客源地:"];
        _peopleWhereAreFrom_label.font = [UIFont fontWithName:PingFang size:12.0];
        _peopleWhereAreFrom_label.textColor = kColor6262;
    }
    return _peopleWhereAreFrom_label;
}

- (UILabel *)openTeamTime_label
{
    if (_openTeamTime_label == nil) {
        _openTeamTime_label = [[UILabel alloc] init];
        _openTeamTime_label.text = [NSString stringWithFormat:@"开团时间:"];
        _openTeamTime_label.font = [UIFont fontWithName:PingFang size:12.0];
        _openTeamTime_label.textColor = kColor6262;
    }
    return _openTeamTime_label;
}

- (UILabel *)openTeamTimeContent_label
{
    if (_openTeamTimeContent_label == nil) {
        _openTeamTimeContent_label = [[UILabel alloc] init];
        _openTeamTimeContent_label.font = [UIFont fontWithName:PingFang size:13.0];
        _openTeamTimeContent_label.textColor = kColor2f2f;
    }
    return _openTeamTimeContent_label;
}

- (void)setFindTeamTasksItem:(NSMutableArray<XFJFindTeamTasksItem *> *)findTeamTasksItem
{
    _findTeamTasksItem = findTeamTasksItem;
    self.carNumberContent_label.text = [NSString stringWithFormat:@"%@",findTeamTasksItem[0].vehicleNo];
    self.peopleWhereAreFromContent_label.text = [NSString stringWithFormat:@"%@%@%@",findTeamTasksItem[0].province,findTeamTasksItem[0].city,findTeamTasksItem[0].area];
    self.openTeamTimeContent_label.text = [NSString stringWithFormat:@"%@",findTeamTasksItem[0].teamDate];
}


@end
