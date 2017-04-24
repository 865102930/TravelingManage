//
//  XFJSecondAttributeTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/7.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

/*  输入数字
 *  输入数字
 *  输入数字
 */

#import "XFJSecondAttributeTableViewCell.h"

@interface XFJSecondAttributeTableViewCell()

@property (nonatomic, strong) UITextField *quality_field;

@end

@implementation XFJSecondAttributeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.quality_field.delegate = self;
        [self addSubview:self.quality_field];
        
        [self.quality_field mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(9.0);
            make.left.mas_equalTo(self.mas_left).mas_equalTo(18.0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
            make.height.mas_equalTo(35.0);
        }];
    }
    return self;
}

- (UITextField *)quality_field
{
    if (_quality_field == nil) {
        _quality_field = [UITextField textBackGroundImage:@"input-box-" titleName:@"数字" rightImage:@"xinghao" placeholder:@"只可输入数字"];
    }
    return _quality_field;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.numberTextBlock(textField.text, self.teamAttr);
}

@end
