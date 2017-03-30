//
//  XFJEigthAttributeTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//


#import "XFJEigthAttributeTableViewCell.h"

@interface XFJEigthAttributeTableViewCell() <UITextFieldDelegate>

@property (nonatomic, strong) UIButton *quality_button;
@property (nonatomic, strong) UILabel *quality_label;
@property (nonatomic, strong) UILabel *qualityContent_label;
@property (nonatomic, strong) UIButton *four_button;
@property (nonatomic, strong) NSString *types;

@end

@implementation XFJEigthAttributeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.quality_button];
        [self.quality_button addSubview:self.four_button];
        [self.quality_button addSubview:self.quality_label];
        [self.quality_button addSubview:self.qualityContent_label];
        [self.quality_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(9.0);
            make.left.mas_equalTo(self.mas_left).mas_equalTo(18.0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
            make.height.mas_equalTo(35.0);
        }];
        [self.quality_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.quality_button.mas_left).mas_offset(15.0);
            make.centerY.mas_equalTo(self.quality_button.mas_centerY);
        }];
        [self.qualityContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.quality_label.mas_right).mas_offset(25.0);
            make.centerY.mas_equalTo(self.quality_button.mas_centerY);
        }];
        [self.four_button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.quality_button.mas_right).mas_offset(-10.0);
            make.height.with.mas_equalTo(11.0);
            make.top.mas_equalTo(self.quality_button.mas_top).mas_offset(13.0);
        }];
    }
    return self;
}

- (UIButton *)quality_button
{
    if (_quality_button == nil) {
        _quality_button = [UIButton buttonWithType:UIButtonTypeCustom];
        _quality_button.layer.borderColor = kBorderColor.CGColor;
        _quality_button.layer.borderWidth = 0.5;
        _quality_button.layer.cornerRadius = 3.0;
        _quality_button.clipsToBounds = YES;
        _quality_button.layer.masksToBounds = YES;
        [_quality_button addTarget:self action:@selector(chooseMessageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _quality_button;
}

- (UILabel *)quality_label
{
    if (_quality_label == nil) {
        _quality_label = [[UILabel alloc] init];
        _quality_label.font = [UIFont fontWithName:PingFang size:13.0];
        _quality_label.textColor = kColor2f2f;
    }
    return _quality_label;
}

- (UILabel *)qualityContent_label
{
    if (_qualityContent_label == nil) {
        _qualityContent_label = [[UILabel alloc] init];
        _qualityContent_label.font = [UIFont fontWithName:PingFang size:14.0];
        _qualityContent_label.textColor = kColor2f2f;
    }
    return _qualityContent_label;
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
    if (self.presentMaskViewBlock) {
        self.presentMaskViewBlock(self.teamAttr);
    }
}

- (void)setAttributeStr:(NSString *)attributeStr
{
    _attributeStr = attributeStr;
    if (attributeStr == nil) {
        self.qualityContent_label.text = [NSString stringWithFormat:@"%@",@"请选择属性"];
    }else {
        NSString *attributeStr1 = [attributeStr stringByReplacingOccurrencesOfString:@"&" withString:@","];
        self.qualityContent_label.text = [NSString stringWithFormat:@"%@",attributeStr1];
    }
}


- (void)setTeamAttr:(NSString *)teamAttr
{
    _teamAttr = teamAttr;
    self.types = teamAttr;
}

- (void)setFindCustomAttrListItemArray:(XFJFindCustomAttrListItem *)findCustomAttrListItemArray
{
    _findCustomAttrListItemArray = findCustomAttrListItemArray;
    self.quality_label.text = [NSString stringWithFormat:@"%@",findCustomAttrListItemArray.userName];
}


@end
