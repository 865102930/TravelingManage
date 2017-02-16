//
//  XFJStarTaskTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/14.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJStarTaskTableViewCell.h"

@interface XFJStarTaskTableViewCell()

@property (nonatomic, strong) UIView *line_view;

@property (nonatomic, strong) UIButton *startTask_button;

@end

@implementation XFJStarTaskTableViewCell

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self addSubview:self.line_view];
//        [self addSubview:self.startTask_button];
//        [self.line_view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.mas_top);
//            make.left.mas_equalTo(self.mas_left);
//            make.height.mas_equalTo(3.0);
//            make.right.mas_equalTo(self.mas_right);
//        }];
//        [self.startTask_button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(19.0);
//            make.top.mas_equalTo(24.0);
//            make.right.mas_equalTo(-19.0);
//            make.height.mas_equalTo(42.0);
//        }];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.line_view];
        [self addSubview:self.startTask_button];
        [self.line_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(self.mas_left);
            make.height.mas_equalTo(3.0);
            make.right.mas_equalTo(self.mas_right);
        }];
        [self.startTask_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(19.0);
            make.top.mas_equalTo(24.0);
            make.right.mas_equalTo(-19.0);
            make.height.mas_equalTo(42.0);
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

- (UIButton *)startTask_button
{
    if (_startTask_button == nil) {
        _startTask_button = [UIButton buttonWithType:UIButtonTypeCustom];
        _startTask_button.layer.cornerRadius = 4.0;
        _startTask_button.backgroundColor = kColorff47;
        _startTask_button.layer.borderColor = kColorff47.CGColor;
        _startTask_button.layer.borderWidth = 1.0;
        [_startTask_button setTitle:@"开始任务" forState:UIControlStateNormal];
        _startTask_button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_startTask_button setTitleColor:kColorFFFF forState:UIControlStateNormal];
        [_startTask_button addTarget:self action:@selector(startTaskButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startTask_button;
}

- (void)startTaskButtonClick
{
    if (self.startTaskButtonBlock) {
        self.startTaskButtonBlock();
    }
}
+ (CGFloat)cellHeight
{
    return 100.0;
}

@end
