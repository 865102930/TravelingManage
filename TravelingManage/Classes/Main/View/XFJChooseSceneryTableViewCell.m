//
//  XFJChooseSceneryTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/11.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJChooseSceneryTableViewCell.h"

@interface XFJChooseSceneryTableViewCell()
@property (nonatomic, strong) UIView *line_view;
@property (nonatomic, strong) UILabel *sceneryContent_label;
@property (nonatomic, assign) BOOL isChooseButton;

@end

@implementation XFJChooseSceneryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.sceneryContent_button];
        [self.contentView addSubview:self.line_view];
        [self.contentView addSubview:self.sceneryContent_label];
        [self.sceneryContent_button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.width.mas_equalTo(14.0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-33.0);
        }];
        [self.line_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15.0);
            make.right.mas_equalTo(-15.0);
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        [self.sceneryContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        self.isChooseButton = YES;
    }
    return self;
}

- (UIButton *)sceneryContent_button
{
    if (_sceneryContent_button == nil) {
        _sceneryContent_button = [UIButton buttonWithType:UIButtonTypeCustom];
        _sceneryContent_button.layer.cornerRadius = 7.0;
        _sceneryContent_button.layer.borderColor = RedColor.CGColor;
        _sceneryContent_button.layer.borderWidth = 0.5;
        [_sceneryContent_button addTarget:self action:@selector(sceneryContent_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sceneryContent_button;
}

- (void)sceneryContent_buttonClick:(UIButton *)button
{
    if (self.chichButtonChooseBlock) {
        self.chichButtonChooseBlock(button);
    }
}

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = kColoreeee;
    }
    return _line_view;
}

- (UILabel *)sceneryContent_label
{
    if (_sceneryContent_label == nil) {
        _sceneryContent_label = [[UILabel alloc] init];
        _sceneryContent_label.textColor = [UIColor blackColor];
        _sceneryContent_label.font = [UIFont fontWithName:PingFang size:14.0];
        _sceneryContent_label.textAlignment = NSTextAlignmentLeft;
    }
    return _sceneryContent_label;
}

+ (CGFloat)cellHeight
{
    return 80;
}

- (void)setFindAttractionsListItem:(XFJFindAttractionsListItem *)findAttractionsListItem
{
    _findAttractionsListItem = findAttractionsListItem;
    self.sceneryContent_label.text = [NSString stringWithFormat:@"%@",findAttractionsListItem.attractionsName];
    
}

- (void)setFindAttractionsListItem2:(XFJFindAttractionsListItem *)findAttractionsListItem2
{
    _findAttractionsListItem2 = findAttractionsListItem2;
    [self.sceneryContent_button setImage:[UIImage originalWithImage:@"selected-g"] forState:UIControlStateNormal];
}


@end
