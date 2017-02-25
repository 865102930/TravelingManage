//
//  XFJHotelView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/26.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJHotelView.h"

@interface XFJHotelView()

@property (nonatomic, strong) UIView *redCircel_view;
@property (nonatomic, strong) UILabel *hotelName_label;
@property (nonatomic, strong) UITextField *hotelText_field;
@property (nonatomic, strong) UILabel *peopleName_label;

@property (nonatomic, strong) UIView *blueCircel_view;
@property (nonatomic, strong) UILabel *romeName_label;
@property (nonatomic, strong) UITextField *romeText_field;
@property (nonatomic, strong) UILabel *rome_label;

@end

@implementation XFJHotelView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.redCircel_view];
        [self.redCircel_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(36.0);
            make.left.mas_equalTo(29.0);
            make.height.width.mas_equalTo(6.0);
        }];
    }
    return self;
}

- (UIView *)redCircel_view
{
    if (_redCircel_view == nil) {
        _redCircel_view = [[UIView alloc] init];
        _redCircel_view.backgroundColor = kColorff47;
        _redCircel_view.layer.cornerRadius = 6.0;
        _redCircel_view.layer.borderColor = kColorff47.CGColor;
        _redCircel_view.layer.borderWidth = 0.5;
    }
    return _redCircel_view;
}

@end
