//
//  XFJCheckBoxTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJCheckBoxTableViewCell.h"

@interface XFJCheckBoxTableViewCell()

@property (nonatomic, strong) UIView *line_view;
@property (nonatomic, assign) BOOL isChoose;
@property (nonatomic, strong) UILabel *titltContent_label;

@end

@implementation XFJCheckBoxTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.check_button];
        [self addSubview:self.line_view];
        [self addSubview:self.titltContent_label];
        [self.check_button mas_updateConstraints:^(MASConstraintMaker *make) {
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
        [self.titltContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        self.isChoose = YES;
    }
    return self;
}


- (UIButton *)check_button
{
    if (_check_button == nil) {
        _check_button = [UIButton buttonWithType:UIButtonTypeCustom];
        _check_button.layer.cornerRadius = 7.0;
        _check_button.layer.borderColor = RedColor.CGColor;
        _check_button.layer.borderWidth = 0.5;
        [_check_button addTarget:self action:@selector(choose_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _check_button;
}

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = kColoreeee;
    }
    return _line_view;
}

- (UILabel *)titltContent_label
{
    if (_titltContent_label == nil) {
        _titltContent_label = [[UILabel alloc] init];
        _titltContent_label.textColor = [UIColor blackColor];
        _titltContent_label.font = [UIFont fontWithName:PingFang size:14.0];
        _titltContent_label.textAlignment = NSTextAlignmentLeft;
    }
    return _titltContent_label;
}

- (void)choose_buttonClick:(UIButton *)button
{
//    if (self.isChoose) {
//        [self.check_button setImage:[UIImage originalWithImage:@"choice"] forState:UIControlStateNormal];
//        if (self.choose_buttonClickBlock) {
//            self.choose_buttonClickBlock(button);
//        }
//        self.isChoose = NO;
//    }else {
//        [self.check_button setImage:[UIImage originalWithImage:@""] forState:UIControlStateNormal];
//        if (self.remove_buttonClickBlock) {
//            self.remove_buttonClickBlock(button);
//        }
//        self.isChoose = YES;
//    }
}

+ (CGFloat)cellHeight
{
    return 80;
}

- (void)setFindParamsSystemListDoubleItem:(XFJFindParamsSystemListDoubleItem *)findParamsSystemListDoubleItem
{
    _findParamsSystemListDoubleItem = findParamsSystemListDoubleItem;
    self.titltContent_label.text = [NSString stringWithFormat:@"%@",findParamsSystemListDoubleItem.name];
}

@end
