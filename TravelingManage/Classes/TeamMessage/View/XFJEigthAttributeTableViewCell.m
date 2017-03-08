//
//  XFJEigthAttributeTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//


#import "XFJEigthAttributeTableViewCell.h"

@interface XFJEigthAttributeTableViewCell() <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *quality_field;
@property (nonatomic, strong) UIButton *four_button;

@end

@implementation XFJEigthAttributeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.quality_field];
        [self.quality_field addSubview:self.four_button];
        [self.quality_field mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(9.0);
            make.left.mas_equalTo(self.mas_left).mas_equalTo(18.0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
            make.height.mas_equalTo(35.0);
        }];
        [self.four_button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.quality_field.mas_right).mas_offset(-10.0);
            make.height.with.mas_equalTo(11.0);
            make.top.mas_equalTo(self.quality_field.mas_top).mas_offset(13.0);
        }];
    }
    return self;
}

- (UITextField *)quality_field
{
    if (_quality_field == nil) {
        _quality_field = [UITextField textBackGroundImage:@"input-box-" titleName:@"属          性" rightImage:@"xinghao" placeholder:@"请选择属性"];
        _quality_field.delegate = self;
    }
    return _quality_field;
}

- (UIButton *)four_button
{
    if (_four_button == nil) {
        _four_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_four_button setImage:[UIImage originalWithImage:@"choice-list-"] forState:UIControlStateNormal];
        [_four_button addTarget:self action:@selector(chooseMessageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _four_button;
}

- (void)chooseMessageButtonClick
{
    NSLog(@"主人~~您点击了单选框按钮!!");
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}


@end
