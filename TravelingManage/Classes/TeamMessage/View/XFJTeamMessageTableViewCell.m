//
//  XFJTeamMessageTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/4.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJTeamMessageTableViewCell.h"

@interface XFJTeamMessageTableViewCell()

@property (nonatomic, strong) UIView *line_view;
@property (nonatomic, strong) UILabel *sceneryMessage_label;
@property (nonatomic, strong) UIImageView *peopleTitle_imageView;
@property (nonatomic, strong) UILabel *peopleContent_label;
@property (nonatomic, strong) UILabel *people_label;
@property (nonatomic, strong) UIImageView *timtTitle_imageView;
@property (nonatomic, strong) UILabel *hourContent_label;
@property (nonatomic, strong) UILabel *hour_label;
@property (nonatomic, strong) UILabel *mintesContent_label;
@property (nonatomic, strong) UILabel *mintes_label;
@property (nonatomic, strong) UIButton *return_button;

@end

@implementation XFJTeamMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = kColorF7F7;
        [self addSubview:self.sceneryMessage_label];
        [self addSubview:self.line_view];
        [self addSubview:self.return_button];
        [self addSubview:self.mintes_label];
        [self addSubview:self.mintesContent_label];
        [self addSubview:self.hour_label];
        [self addSubview:self.hourContent_label];
        [self addSubview:self.timtTitle_imageView];
        [self addSubview:self.people_label];
        [self addSubview:self.peopleContent_label];
        [self addSubview:self.peopleTitle_imageView];
        [self.sceneryMessage_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
        }];
        [self.line_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(3.0);
        }];
        [self.return_button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.sceneryMessage_label.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
            make.height.mas_equalTo(12.0);
            make.width.mas_equalTo(12.0);
        }];
        [self.mintes_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.sceneryMessage_label.mas_centerY);
            make.right.mas_equalTo(self.return_button.mas_left).mas_offset(-9.0);
        }];
        [self.mintesContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.sceneryMessage_label.mas_centerY);
            make.right.mas_equalTo(self.mintes_label.mas_left).mas_offset(-3.0);
        }];
        [self.hour_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.sceneryMessage_label.mas_centerY);
            make.right.mas_equalTo(self.mintesContent_label.mas_left).mas_offset(-3.0);
        }];
        [self.hourContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.sceneryMessage_label.mas_centerY);
            make.right.mas_equalTo(self.hour_label.mas_left).mas_offset(-3.0);
        }];
        [self.timtTitle_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.sceneryMessage_label.mas_centerY);
            make.right.mas_equalTo(self.hourContent_label.mas_left).mas_offset(-6.0);
            make.height.mas_equalTo(16.0);
            make.width.mas_equalTo(15.0);
        }];
        [self.people_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.sceneryMessage_label.mas_centerY);
            make.right.mas_equalTo(self.timtTitle_imageView.mas_left).mas_offset(-5.0);
        }];
        [self.peopleContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.sceneryMessage_label.mas_centerY);
            make.right.mas_equalTo(self.people_label.mas_left).mas_offset(-5.0);
        }];
        [self.peopleTitle_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.sceneryMessage_label.mas_centerY);
            make.right.mas_equalTo(self.peopleContent_label.mas_left).mas_offset(-5.0);
        }];
    }
    return self;
}

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = [UIColor whiteColor];
    }
    return _line_view;
}

- (UILabel *)sceneryMessage_label
{
    if (_sceneryMessage_label == nil) {
        _sceneryMessage_label = [[UILabel alloc] init];
        _sceneryMessage_label.font = [UIFont fontWithName:PingFang size:14.0];
        _sceneryMessage_label.textColor = kColor2f2f;
        _sceneryMessage_label.numberOfLines = 0;
    }
    return _sceneryMessage_label;
}

- (UIImageView *)peopleTitle_imageView
{
    if (_peopleTitle_imageView == nil) {
        _peopleTitle_imageView = [[UIImageView alloc] init];
        _peopleTitle_imageView.image = [UIImage originalWithImage:@"number"];
    }
    return _peopleTitle_imageView;
}

- (UIButton *)return_button
{
    if (_return_button == nil) {
        _return_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_return_button setImage:[UIImage originalWithImage:@"enter"] forState:UIControlStateNormal];
    }
    return _return_button;
}

- (UILabel *)mintes_label
{
    if (_mintes_label == nil) {
        _mintes_label = [[UILabel alloc] init];
        _mintes_label.text = @"分";
        _mintes_label.textColor = kColor6F6F;
        _mintes_label.font = [UIFont fontWithName:PingFang size:14.0];
    }
    return _mintes_label;
}

- (UILabel *)mintesContent_label
{
    if (_mintesContent_label == nil) {
        _mintesContent_label = [[UILabel alloc] init];
        _mintesContent_label.font = [UIFont fontWithName:PingFang size:14.0];
        _mintesContent_label.textColor = kColorff47;
    }
    return _mintesContent_label;
}

- (UILabel *)hour_label
{
    if (_hour_label == nil) {
        _hour_label = [[UILabel alloc] init];
        _hour_label.text = @"时";
        _hour_label.textColor = kColor6F6F;
        _hour_label.font = [UIFont fontWithName:PingFang size:14.0];
    }
    return _hour_label;
}

- (UILabel *)hourContent_label
{
    if (_hourContent_label == nil) {
        _hourContent_label = [[UILabel alloc] init];
        _hourContent_label.font = [UIFont fontWithName:PingFang size:14.0];
        _hourContent_label.textColor = kColorff47;
    }
    return _hourContent_label;
}

- (UIImageView *)timtTitle_imageView
{
    if (_timtTitle_imageView == nil) {
        _timtTitle_imageView = [[UIImageView alloc] init];
        _timtTitle_imageView.image = [UIImage originalWithImage:@"time"];
    }
    return _timtTitle_imageView;
}

- (UILabel *)people_label
{
    if (_people_label == nil) {
        _people_label = [[UILabel alloc] init];
        _people_label.text = @"人";
        _people_label.textColor = kColor6F6F;
        _people_label.font = [UIFont fontWithName:PingFang size:14.0];
    }
    return _people_label;
}

- (UILabel *)peopleContent_label
{
    if (_peopleContent_label == nil) {
        _peopleContent_label = [[UILabel alloc] init];
        _peopleContent_label.font = [UIFont fontWithName:PingFang size:14.0];
        _peopleContent_label.textColor = kColorff47;
    }
    return _peopleContent_label;
}

- (void)setTaskRowsItem:(XFJTaskRowsItem *)taskRowsItem
{
    _taskRowsItem = taskRowsItem;
    //景点
    self.sceneryMessage_label.text = [NSString stringWithFormat:@"%@",taskRowsItem.attractionsName];
    //签到人数
    self.peopleContent_label.text = [NSString stringWithFormat:@"%zd",taskRowsItem.checkinNumber];
    if ([taskRowsItem.attractionsTime intValue] == 0) {
        self.mintesContent_label.text = @"0";
        self.hourContent_label.text = @"0";
    }else {
        NSString *teamDateStr = [NSString stringWithFormat:@"%@",taskRowsItem.attractionsTime];
        NSArray *timeDateArray = [teamDateStr componentsSeparatedByString:@"."];
        self.hourContent_label.text = [NSString stringWithFormat:@"%@",timeDateArray[0]];
        
//        NSLog(@"=========%f",[teamDateStr floatValue] % i);
//        self.mintesContent_label.text = [NSString stringWithFormat:@"%d",(int)mintesContent_label * 60];
    }
    NSLog(@"----------景点信息是 :%@",taskRowsItem.attractionsName);
    
}



@end
