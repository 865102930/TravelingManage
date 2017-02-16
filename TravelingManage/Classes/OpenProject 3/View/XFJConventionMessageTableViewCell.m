//
//  XFJConventionMessageTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/10.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJConventionMessageTableViewCell.h"
#import <Masonry.h>

@interface XFJConventionMessageTableViewCell()

@property (nonatomic, strong) UIImageView *conventionMessage_imageView;

@property (nonatomic, strong) UILabel *conventionMessage_label;

@property (nonatomic, strong) UITextField *groupText_field;

@property (nonatomic, strong) UITextField *groupTime_field;

@property (nonatomic, strong) UITextField *travelServiceName_field;

@end

@implementation XFJConventionMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initControlWithConventionMessage];
        [self setUpConventionMessageWithMas];
    }
    return self;
}

#pragma mark - 初始化控件
- (void)initControlWithConventionMessage
{
    [self addSubview:self.conventionMessage_imageView];
    [self addSubview:self.conventionMessage_label];
    [self addSubview:self.groupText_field];
    [self addSubview:self.groupTime_field];
    [self addSubview:self.travelServiceName_field];
}

#pragma mark - 布局控件
- (void)setUpConventionMessageWithMas
{
    [self.conventionMessage_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24.0);
        make.left.mas_equalTo(18.0);
        make.height.mas_equalTo(15.0);
        make.width.mas_equalTo(13.0);
    }];
    [self.conventionMessage_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.conventionMessage_imageView.mas_centerY);
        make.left.mas_equalTo(self.conventionMessage_imageView.mas_right).mas_offset(10.0);
    }];
    [self.groupText_field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.conventionMessage_imageView.mas_bottom).mas_offset(16.0);
        make.left.mas_equalTo(self.conventionMessage_imageView.mas_left);
        make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
        make.height.mas_equalTo(38.0);
    }];
    [self.groupTime_field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.groupText_field.mas_bottom).mas_offset(9.0);
        make.left.mas_equalTo(self.groupText_field.mas_left);
        make.right.mas_equalTo(self.groupText_field.mas_right);
        make.height.mas_equalTo(self.groupText_field.mas_height);
    }];
    [self.travelServiceName_field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.groupTime_field.mas_bottom).mas_offset(9.0);
        make.left.mas_equalTo(self.groupTime_field.mas_left);
        make.right.mas_equalTo(self.groupTime_field.mas_right);
        make.height.mas_equalTo(self.groupTime_field.mas_height);
    }];
}

- (UIImageView *)conventionMessage_imageView
{
    if (_conventionMessage_imageView == nil) {
        _conventionMessage_imageView = [[UIImageView alloc] init];
        _conventionMessage_imageView.image = [UIImage originalWithImage:@"information-"];
    }
    return _conventionMessage_imageView;
}

- (UILabel *)conventionMessage_label
{
    if (_conventionMessage_label == nil) {
        _conventionMessage_label = [[UILabel alloc] init];
        _conventionMessage_label.text = @"常规信息";
        _conventionMessage_label.textColor = kColorff47;
        [_conventionMessage_label setFont:[UIFont systemFontOfSize:15.0]];
        _conventionMessage_label.textAlignment = NSTextAlignmentLeft;
    }
    return _conventionMessage_label;
}

- (UITextField *)groupText_field
{
    if (_groupText_field == nil) {
        _groupText_field = [UITextField textBackGroundImage:@"input-box-" titleName:@"团 队 编 号" rightImage:@"xinghao" placeholder:@"请输入团队编号"];
    }
    return _groupText_field;
}

- (UITextField *)groupTime_field
{
    if (_groupTime_field == nil) {
        _groupTime_field = [UITextField textBackGroundImage:@"input-box-" titleName:@"出 团 日 期" rightImage:@"xinghao" placeholder:@"2017-02-23"];
    }
    return _groupTime_field;
}

- (UITextField *)travelServiceName_field
{
    if (_travelServiceName_field == nil) {
        _travelServiceName_field = [UITextField textBackGroundImage:@"input-box-" titleName:@"旅行社名称" rightImage:@"xinghao" placeholder:@"请输入旅行社名"];
    }
    return _travelServiceName_field;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

+ (CGFloat)cellHeight
{
    return 195;
}





@end
