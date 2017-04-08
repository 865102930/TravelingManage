//
//  XFJChooseScreneryTitleTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/30.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJChooseScreneryTitleTableViewCell.h"

@interface XFJChooseScreneryTitleTableViewCell()

@property (nonatomic, strong) UILabel *screneryTitle_label;
@property (nonatomic, strong) UIView *screneryTitleBottom_view;

@end

@implementation XFJChooseScreneryTitleTableViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.screneryTitle_label];
        [self addSubview:self.screneryTitleBottom_view];
        [self.screneryTitle_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [self.screneryTitleBottom_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(1.0);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
    }
    return self;
}

- (UILabel *)screneryTitle_label
{
    if (_screneryTitle_label == nil) {
        _screneryTitle_label = [[UILabel alloc] init];
        _screneryTitle_label.font = [UIFont fontWithName:PingFang size:15.0];
        _screneryTitle_label.textColor = kColor0000;
    }
    return _screneryTitle_label;
}

- (UIView *)screneryTitleBottom_view
{
    if (_screneryTitleBottom_view == nil) {
        _screneryTitleBottom_view = [[UIView alloc] init];
        _screneryTitleBottom_view.backgroundColor = kColoreeee;
    }
    return _screneryTitleBottom_view;
}

- (void)screneryTitle:(NSString *)title_label
{
    self.screneryTitle_label.text = [NSString stringWithFormat:@"%@",title_label];
}

@end
