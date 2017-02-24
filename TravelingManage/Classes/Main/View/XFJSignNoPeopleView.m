//
//  XFJSignNoPeopleView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/24.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJSignNoPeopleView.h"

@interface XFJSignNoPeopleView()

@property (nonatomic, strong) UIImageView *peopleNumber_imageView;

@property (nonatomic, strong) UILabel *peopleNumber_label;

@property (nonatomic, strong) UILabel *peopleName_label;

@property (nonatomic, strong) UIImageView *time_imageView;

@property (nonatomic, strong) UILabel *timeCantent_label;

@property (nonatomic, strong) UILabel *hour_label;

@property (nonatomic, strong) UIButton *signNo_button;

@end

@implementation XFJSignNoPeopleView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.peopleNumber_imageView];
        [self addSubview:self.peopleNumber_label];
        self.backgroundColor = [UIColor whiteColor];
        [self.peopleNumber_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(29.0);
            make.left.mas_equalTo(21.0);
            make.height.width.mas_equalTo(16.0);
        }];
        [self.peopleNumber_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(32.0);
            make.left.mas_equalTo(self.peopleNumber_imageView.mas_right).mas_offset(16.0);
        }];
        
    }
    return self;
}

#pragma mark - 人数
- (UIImageView *)peopleNumber_imageView
{
    if (_peopleNumber_imageView == nil) {
        _peopleNumber_imageView = [[UIImageView alloc] init];
        _peopleNumber_imageView.image = [UIImage originalWithImage:@"renshu"];
    }
    return _peopleNumber_imageView;
}

#pragma mark - 人数的内容
- (UILabel *)peopleNumber_label
{
    if (_peopleNumber_label == nil) {
        _peopleNumber_label = [[UILabel alloc] init];
        _peopleNumber_label.textColor = kColorff47;
        _peopleNumber_label.font = [UIFont fontWithName:PingFang size:14.0];
        _peopleNumber_label.backgroundColor = [UIColor blueColor];
    }
    return _peopleNumber_label;
}



@end
