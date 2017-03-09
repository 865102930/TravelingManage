//
//  XFJFirestAttributeTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/7.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJFirestAttributeTableViewCell.h"

@interface XFJFirestAttributeTableViewCell()

@property (nonatomic, strong) UITextField *quality_field;

@end

@implementation XFJFirestAttributeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
        _quality_field = [UITextField textBackGroundImage:@"input-box-" titleName:@"属          性" rightImage:@"xinghao" placeholder:@"单行输入"];
        [_quality_field addTarget:self action:@selector(firestTextField:) forControlEvents:UIControlEventEditingDidEnd];
    }
    return _quality_field;
}

- (void)firestTextField:(UITextField *)textField
{
    NSLog(@"这是获取到的用户的单行输入的最终值:%@",textField.text);
}




@end
