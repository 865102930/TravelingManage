//
//  XFJLeftViewTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJLeftViewTableViewCell.h"
#import <Masonry.h>

@interface XFJLeftViewTableViewCell()

//背景图片
@property (nonatomic, strong) UIView *whiteView;
//装控件的view
@property (nonatomic, strong) UIView *backGroundView;
//红线
@property (nonatomic, strong) UIView *redView;
//团队编号
@property (nonatomic, strong) UILabel *team_number;
//团队人数
@property (nonatomic, strong) UILabel *numberOf_team;
//客源地
@property (nonatomic, strong) UILabel *tourists;
//车牌号
@property (nonatomic, strong) UILabel *licensePlate_number;

@end

@implementation XFJLeftViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //取消cell的选中状态
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpInitWithContent];
        [self initWithMasContent];
    }
    return self;
}

#pragma mark - 添加控件
- (void)setUpInitWithContent
{
    [self addSubview:self.whiteView];
    [self.whiteView addSubview:self.backGroundView];
    [self.backGroundView addSubview:self.redView];
    [self.backGroundView addSubview:self.team_number];
    [self.backGroundView addSubview:self.numberOf_team];
    [self.backGroundView addSubview:self.tourists];
    [self.backGroundView addSubview:self.licensePlate_number];
}

#pragma mark - 布局控件
- (void)initWithMasContent
{
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left).mas_offset(12.0);
        make.width.mas_equalTo(176.0);
        make.height.mas_equalTo(150.0);
    }];
    [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.whiteView.mas_top).mas_offset(10.0);
        make.left.mas_equalTo(self.mas_left).mas_offset(12.0);
        make.width.mas_equalTo(176.0);
        make.height.mas_equalTo(140.0);
    }];
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backGroundView.mas_top).mas_offset(0);
        make.left.mas_equalTo(self.backGroundView.mas_left);
        make.right.mas_equalTo(self.backGroundView.mas_right);
        make.height.mas_equalTo(1.0);
    }];
    [self.team_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.redView.mas_bottom).mas_offset(19.0);
        make.left.mas_equalTo(self.backGroundView.mas_left).mas_offset(10.0);
    }];
    [self.numberOf_team mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.team_number.mas_bottom).mas_offset(17.0);
        make.left.mas_equalTo(self.team_number.mas_left);
    }];
    [self.tourists mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numberOf_team.mas_bottom).mas_offset(17.0);
        make.left.mas_equalTo(self.numberOf_team.mas_left);
    }];
    [self.licensePlate_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tourists.mas_bottom).mas_offset(17.0);
        make.left.mas_equalTo(self.tourists.mas_left);
    }];
}

- (UIView *)whiteView
{
    if (_whiteView == nil) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}

- (UIView *)backGroundView
{
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] init];
        _backGroundView.backgroundColor = kColorF9F9;
    }
    return _backGroundView;
}

- (UIView *)redView
{
    if (_redView == nil) {
        _redView = [[UIView alloc] init];
        _redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}

- (UILabel *)team_number
{
    if (_team_number == nil) {
        _team_number = [[UILabel alloc] init];
        _team_number.textColor = kColor2f2f;
        [_team_number setFont:[UIFont systemFontOfSize:12.0]];
        _team_number.textAlignment = NSTextAlignmentLeft;
    }
    return _team_number;
}

- (UILabel *)numberOf_team
{
    if (_numberOf_team == nil) {
        _numberOf_team = [[UILabel alloc] init];
        _numberOf_team.textColor = kColor2f2f;
        [_numberOf_team setFont:[UIFont systemFontOfSize:12.0]];
        _numberOf_team.textAlignment = NSTextAlignmentLeft;
    }
    return _numberOf_team;
}

- (UILabel *)tourists
{
    if (_tourists == nil) {
        _tourists = [[UILabel alloc] init];
        _tourists.textColor = kColor2f2f;
        [_tourists setFont:[UIFont systemFontOfSize:12.0]];
        _tourists.textAlignment = NSTextAlignmentLeft;
        
    }
    return _tourists;
}

- (UILabel *)licensePlate_number
{
    if (_licensePlate_number == nil) {
        _licensePlate_number = [[UILabel alloc] init];
        _licensePlate_number.textColor = kColor2f2f;
        [_licensePlate_number setFont:[UIFont systemFontOfSize:12.0]];
        _licensePlate_number.textAlignment = NSTextAlignmentLeft;
        
    }
    return _licensePlate_number;
}

+ (CGFloat)cellHeight
{
    return 150;
}

- (void)setLeftFindTeamInfoItem:(XFJLeftFindTeamInfoItem *)leftFindTeamInfoItem
{
    _leftFindTeamInfoItem = leftFindTeamInfoItem;
    self.team_number.text = [NSString stringWithFormat:@"团队编号: %@",leftFindTeamInfoItem.teamNo];
    self.numberOf_team.text = [NSString stringWithFormat:@"团队人数: %@",leftFindTeamInfoItem.teamNum];
    self.tourists.text = [NSString stringWithFormat:@"客源地: %@%@%@",leftFindTeamInfoItem.province,leftFindTeamInfoItem.city,leftFindTeamInfoItem.area];
    self.licensePlate_number.text = [NSString stringWithFormat:@"车牌号: %@",leftFindTeamInfoItem.vehicleNo];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
