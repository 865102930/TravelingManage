//
//  XFJSignMessageTopVeiw.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/2.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJSignMessageTopVeiw.h"

@interface XFJSignMessageTopVeiw()

@property (nonatomic, strong) UILabel *scenery_laebl;
@property (nonatomic, strong) UIImageView *peopleTotal_imageView;
@property (nonatomic, strong) UILabel *peopleContent_label;

@end

@implementation XFJSignMessageTopVeiw

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kColor8F8F;
        [self addSubview:self.scenery_laebl];
        [self addSubview:self.peopleContent_label];
        [self addSubview:self.peopleTotal_imageView];
        [self.scenery_laebl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(11.0);
            make.left.mas_equalTo(12.0);
        }];
        [self.peopleContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-12.0);
            make.centerY.mas_equalTo(self.scenery_laebl.mas_centerY);
        }];
        [self.peopleTotal_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.peopleContent_label.mas_left).mas_offset(-12);
            make.centerY.mas_equalTo(self.scenery_laebl.mas_centerY);
            make.width.height.mas_equalTo(14.0);
        }];
    }
    return self;
}

- (UILabel *)scenery_laebl
{
    if (_scenery_laebl == nil) {
        _scenery_laebl = [[UILabel alloc] init];
        _scenery_laebl.textColor = kColorFFFF;
        _scenery_laebl.font = [UIFont fontWithName:PingFang size:14.0];
    }
    return _scenery_laebl;
}

- (UIImageView *)peopleTotal_imageView
{
    if (_peopleTotal_imageView == nil) {
        _peopleTotal_imageView = [[UIImageView alloc] init];
        _peopleTotal_imageView.image = [UIImage originalWithImage:@"team"];
    }
    return _peopleTotal_imageView;
}

- (UILabel *)peopleContent_label
{
    if (_peopleContent_label == nil) {
        _peopleContent_label = [[UILabel alloc] init];
        _peopleContent_label.textColor = kColorFFFF;
        _peopleContent_label.font = [UIFont fontWithName:PingFang size:14.0];
    }
    return _peopleContent_label;
}

- (void)setLaterTeamControlItem:(XFJLaterTeamControlItem *)laterTeamControlItem
{
    _laterTeamControlItem = laterTeamControlItem;
    
}

- (void)setTaskRowsItem:(XFJTaskRowsItem *)taskRowsItem
{
    _taskRowsItem = taskRowsItem;
    self.peopleContent_label.text = [NSString stringWithFormat:@"%zd人",taskRowsItem.checkinNumber];
    self.scenery_laebl.text = [NSString stringWithFormat:@"%@",taskRowsItem.attractionsName];
}



@end
