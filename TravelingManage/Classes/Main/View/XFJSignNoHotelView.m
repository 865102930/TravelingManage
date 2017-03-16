//
//  XFJSignNoHotelView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/26.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJSignNoHotelView.h"

@interface XFJSignNoHotelView()

@property (nonatomic, strong) UIImageView *people_imageView;
@property (nonatomic, strong) UILabel *peopleContent_label;
@property (nonatomic, strong) UILabel *peopleName_label;

@property (nonatomic, strong) UIImageView *house_imageView;
@property (nonatomic, strong) UILabel *houseContent_label;
@property (nonatomic, strong) UILabel *houseName_label;

@property (nonatomic, strong) UIView *cuttingLine_view;

@property (nonatomic, strong) UILabel *inHouseDay_label;
@property (nonatomic, strong) UILabel *inHouseTimeContent_label;
@property (nonatomic, strong) UILabel *inHouseTime_label;

@property (nonatomic, strong) UIButton *inHouseSign_button;


@end

@implementation XFJSignNoHotelView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.people_imageView];
        [self addSubview:self.peopleContent_label];
        [self addSubview:self.peopleName_label];
        [self addSubview:self.house_imageView];
        [self addSubview:self.houseContent_label];
        [self addSubview:self.houseName_label];
        [self addSubview:self.inHouseDay_label];
        [self addSubview:self.inHouseTimeContent_label];
        [self addSubview:self.inHouseTime_label];
        [self addSubview:self.cuttingLine_view];
        [self addSubview:self.inHouseSign_button];
        [self.people_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(26.0);
            make.left.mas_equalTo(self.mas_left).mas_offset(27.0);
            make.height.with.mas_equalTo(14.0);
        }];
        [self.peopleContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.people_imageView.mas_centerY);
            make.left.mas_equalTo(self.people_imageView.mas_right).mas_offset(12.0);
        }];
        [self.peopleName_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.peopleContent_label.mas_right).mas_offset(7.0);
            make.centerY.mas_equalTo(self.people_imageView.mas_centerY);
        }];
        [self.house_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.peopleName_label.mas_right).mas_offset(17.0);
            make.centerY.mas_equalTo(self.people_imageView.mas_centerY);
            make.height.width.mas_equalTo(14.0);
        }];
        [self.houseContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.house_imageView.mas_right).mas_offset(12.0);
            make.centerY.mas_equalTo(self.people_imageView.mas_centerY);
        }];
        [self.houseName_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.houseContent_label.mas_right).mas_offset(7.0);
            make.centerY.mas_equalTo(self.people_imageView.mas_centerY);
        }];
        [self.inHouseDay_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-27.0);
            make.centerY.mas_equalTo(self.people_imageView.mas_centerY);
        }];
        [self.inHouseTimeContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.inHouseDay_label.mas_left).mas_offset(-7.0);
            make.centerY.mas_equalTo(self.people_imageView.mas_centerY);
        }];
        [self.inHouseTime_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.inHouseTimeContent_label.mas_left).mas_offset(-17.0);
            make.centerY.mas_equalTo(self.people_imageView.mas_centerY);
        }];
        [self.cuttingLine_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.people_imageView.mas_centerY);
            make.width.mas_equalTo(0.3);
            make.height.mas_equalTo(14.0);
            make.right.mas_equalTo(self.inHouseTime_label.mas_left).mas_offset(-10);
        }];
        [self.inHouseSign_button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.people_imageView.mas_bottom).mas_offset(25.0);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
        }];
    };
    return self;
}

- (UIImageView *)people_imageView
{
    if (_people_imageView == nil) {
        _people_imageView = [[UIImageView alloc] init];
        _people_imageView.image = [UIImage originalWithImage:@"group-"];
    }
    return _people_imageView;
}

-(UILabel *)peopleContent_label
{
    if (_peopleContent_label == nil) {
        _peopleContent_label = [[UILabel alloc] init];
        _peopleContent_label.textColor = RedColor;
        _peopleContent_label.font = [UIFont fontWithName:PingFang size:14.0];
        _peopleContent_label.textAlignment = NSTextAlignmentLeft;
    }
    return _peopleContent_label;
}

- (UILabel *)peopleName_label
{
    if (_peopleName_label == nil) {
        _peopleName_label = [[UILabel alloc] init];
        _peopleName_label.text = [NSString stringWithFormat:@"%@",@"人"];
        _peopleName_label.textColor = kColor6F6F;
        _peopleName_label.font = [UIFont fontWithName:PingFang size:13];
        _peopleName_label.textAlignment = NSTextAlignmentLeft;
    }
    return _peopleName_label;
}

- (UIImageView *)house_imageView
{
    if (_house_imageView == nil) {
        _house_imageView = [[UIImageView alloc] init];
        _house_imageView.image = [UIImage originalWithImage:@"house-"];
    }
    return _house_imageView;
}

- (UILabel *)houseContent_label
{
    if (_houseContent_label == nil) {
        _houseContent_label = [[UILabel alloc] init];
//        _houseContent_label.text = [NSString stringWithFormat:@"%@",@"30"];
        _houseContent_label.textColor = RedColor;
        _houseContent_label.font = [UIFont fontWithName:PingFang size:14.0];
        _houseContent_label.textAlignment = NSTextAlignmentLeft;
    }
    return _houseContent_label;
}

- (UILabel *)houseName_label
{
    if (_houseName_label == nil) {
        _houseName_label = [[UILabel alloc] init];
        _houseName_label = [[UILabel alloc] init];
        _houseName_label.text = [NSString stringWithFormat:@"%@",@"间"];
        _houseName_label.textColor = kColor6F6F;
        _houseName_label.font = [UIFont fontWithName:PingFang size:13];
        _houseName_label.textAlignment = NSTextAlignmentLeft;
    }
    return _houseName_label;
}

- (UIView *)cuttingLine_view
{
    if (_cuttingLine_view == nil) {
        _cuttingLine_view = [[UIView alloc] init];
        _cuttingLine_view.backgroundColor = kColor6F6F;
    }
    return _cuttingLine_view;
}

- (UILabel *)inHouseDay_label
{
    if (_inHouseDay_label == nil) {
        _inHouseDay_label = [[UILabel alloc] init];
        _inHouseDay_label.text = [NSString stringWithFormat:@"%@",@"天"];
        _inHouseDay_label.textColor = kColor6F6F;
        _inHouseDay_label.font = [UIFont fontWithName:PingFang size:13];
        _inHouseDay_label.textAlignment = NSTextAlignmentLeft;
    }
    return _inHouseDay_label;
}

- (UILabel *)inHouseTimeContent_label
{
    if (_inHouseTimeContent_label == nil) {
        _inHouseTimeContent_label = [[UILabel alloc] init];
        //这里是将控制器中的小时数量转化为天数然后在赋值
//        _inHouseTimeContent_label.text = [NSString stringWithFormat:@"%@",@"3"];
        _inHouseTimeContent_label.textColor = RedColor;
        _inHouseTimeContent_label.font = [UIFont fontWithName:PingFang size:14.0];
        _inHouseTimeContent_label.textAlignment = NSTextAlignmentLeft;
    }
    return _inHouseTimeContent_label;
}

- (UILabel *)inHouseTime_label
{
    if (_inHouseTime_label == nil) {
        _inHouseTime_label = [[UILabel alloc] init];
        _inHouseTime_label.text = [NSString stringWithFormat:@"%@",@"已入住"];
        _inHouseTime_label.textColor = kColor6F6F;
        _inHouseTime_label.font = [UIFont fontWithName:PingFang size:13];
        _inHouseTime_label.textAlignment = NSTextAlignmentLeft;
    }
    return _inHouseTime_label;
}

- (UIButton *)inHouseSign_button
{
    if (_inHouseSign_button == nil) {
        _inHouseSign_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_inHouseSign_button setTitle:@"签退" forState:UIControlStateNormal];
        _inHouseSign_button.backgroundColor = kColorACAC;
        _inHouseSign_button.titleLabel.textColor = kColorFFFF;
        _inHouseSign_button.layer.cornerRadius = 4.0;
        _inHouseSign_button.layer.borderColor = kColorACAC.CGColor;
        _inHouseSign_button.layer.borderWidth = 0.5;
        [_inHouseSign_button addTarget:self action:@selector(hotelSignNoButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _inHouseSign_button;
}

- (void)hotelSignNoButton
{
    NSLog(@"主人~~您点击了酒店签退按钮~~");
    if (self.hotelSignNoButtonClickBlock) {
        self.hotelSignNoButtonClickBlock();
    }
}

- (void)setHotelSignPeopleCount:(NSString *)hotelSignPeopleCount
{
    _hotelSignPeopleCount = hotelSignPeopleCount;
    self.peopleContent_label.text = [NSString stringWithFormat:@"%@",hotelSignPeopleCount];
}

- (void)setHotelSignRoomCount:(NSString *)hotelSignRoomCount
{
    _hotelSignRoomCount = hotelSignRoomCount;
    self.houseContent_label.text = [NSString stringWithFormat:@"%@",hotelSignRoomCount];
}

- (void)setHotelStayDay:(NSInteger)hotelStayDay
{
    _hotelStayDay = hotelStayDay;
    self.inHouseTimeContent_label.text = [NSString stringWithFormat:@"%zd",hotelStayDay];
}

- (void)setFindTeamTaskItem:(XFJFindTeamTaskItem *)findTeamTaskItem
{
    _findTeamTaskItem = findTeamTaskItem;
    self.peopleContent_label.text = [NSString stringWithFormat:@"%zd",findTeamTaskItem.checkinNumber];
    self.houseContent_label.text = [NSString stringWithFormat:@"%zd",findTeamTaskItem.rooms];
}



@end
