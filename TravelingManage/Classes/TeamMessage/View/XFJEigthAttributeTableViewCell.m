//
//  XFJEigthAttributeTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

/*  多选框
 *  多选框
 *  多选框
 *  多选框
 */

#import "XFJEigthAttributeTableViewCell.h"

#define const_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define const_ScreenHeight [UIScreen mainScreen].bounds.size.height
#define const_ScreenChinge(A) (A) * [UIScreen mainScreen].bounds.size.width/375

@interface XFJEigthAttributeTableViewCell() <UITextFieldDelegate>


@property (nonatomic, strong) UILabel *quality_label;
@property (nonatomic, strong) UIButton *four_button;
@property (nonatomic, strong) NSString *types;

@end

@implementation XFJEigthAttributeTableViewCell

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        [self addSubview:self.quality_button];
//        [self.quality_button addSubview:self.four_button];
//        [self.quality_button addSubview:self.quality_label];
//        [self.quality_button addSubview:self.qualityContent_label];
//        [self.quality_button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.mas_top).mas_offset(9.0);
//            make.left.mas_equalTo(self.mas_left).mas_equalTo(18.0);
//            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
//            make.height.mas_equalTo(35.0);
//        }];
//        [self.quality_label mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.quality_button.mas_left).mas_offset(15.0);
//            make.centerY.mas_equalTo(self.quality_button.mas_centerY);
//        }];
//        [self.qualityContent_label mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.quality_label.mas_right).mas_offset(25.0);
//            make.centerY.mas_equalTo(self.quality_button.mas_centerY);
//        }];
//        [self.four_button mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(self.quality_button.mas_right).mas_offset(-10.0);
//            make.height.with.mas_equalTo(11.0);
//            make.top.mas_equalTo(self.quality_button.mas_top).mas_offset(13.0);
//        }];
//    }
//    return self;
//}
//
//- (UIButton *)quality_button
//{
//    if (_quality_button == nil) {
//        _quality_button = [UIButton buttonWithType:UIButtonTypeCustom];
//        _quality_button.layer.borderColor = kBorderColor.CGColor;
//        _quality_button.layer.borderWidth = 0.5;
//        _quality_button.layer.cornerRadius = 3.0;
//        _quality_button.clipsToBounds = YES;
//        _quality_button.layer.masksToBounds = YES;
//        [_quality_button addTarget:self action:@selector(chooseMessageButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _quality_button;
//}
//
//- (UILabel *)quality_label
//{
//    if (_quality_label == nil) {
//        _quality_label = [[UILabel alloc] init];
//        _quality_label.font = [UIFont fontWithName:PingFang size:13.0];
//        _quality_label.textColor = kColor2f2f;
//    }
//    return _quality_label;
//}
//
//- (UILabel *)qualityContent_label
//{
//    if (_qualityContent_label == nil) {
//        _qualityContent_label = [[UILabel alloc] init];
//        _qualityContent_label.font = [UIFont fontWithName:PingFang size:14.0];
//        _qualityContent_label.textColor = kColor2f2f;
//    }
//    return _qualityContent_label;
//}
//
//- (UIButton *)four_button
//{
//    if (_four_button == nil) {
//        _four_button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_four_button setImage:[UIImage originalWithImage:@"choice-list-"] forState:UIControlStateNormal];
//        [_four_button addTarget:self action:@selector(chooseMessageButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _four_button;
//}
//
//- (void)chooseMessageButtonClick
//{
//    NSLog(@"主人~~您点击了多选框按钮!!");
//    if (self.presentMaskViewBlock) {
//        self.presentMaskViewBlock(self.teamAttr);
//    }
//}
//
//- (void)setAttributeStr:(NSString *)attributeStr
//{
//    _attributeStr = attributeStr;
//    if (attributeStr == nil) {
//        self.qualityContent_label.text = [NSString stringWithFormat:@"%@",@"请选择属性"];
//    }else {
//        NSString *attributeStr1 = [attributeStr stringByReplacingOccurrencesOfString:@"&" withString:@","];
//        self.qualityContent_label.text = [NSString stringWithFormat:@"%@",attributeStr1];
//    }
//}
//
//
//- (void)setTeamAttr:(NSString *)teamAttr
//{
//    _teamAttr = teamAttr;
//    self.types = teamAttr;
//}
//
//- (void)setFindCustomAttrListItemArray:(XFJFindCustomAttrListItem *)findCustomAttrListItemArray
//{
//    _findCustomAttrListItemArray = findCustomAttrListItemArray;
//    self.quality_label.text = [NSString stringWithFormat:@"%@",findCustomAttrListItemArray.userName];
//}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    UIImageView *picImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"input-box-"]];
    picImageView.userInteractionEnabled = YES;
    picImageView.frame = CGRectMake(const_ScreenChinge(18), const_ScreenChinge(9), const_ScreenWidth - const_ScreenChinge(36), const_ScreenChinge(40));
    [self addSubview:picImageView];
    
    self.quality_label = [[UILabel alloc] init];
    self.quality_label.text = @"多选框";
    self.quality_label.font = [UIFont systemFontOfSize:const_ScreenChinge(13)];
    self.quality_label.frame = CGRectMake(const_ScreenChinge(18), const_ScreenChinge(9), const_ScreenChinge(40), const_ScreenChinge(22));
    [picImageView addSubview:self.quality_label];
    
    UIImageView *startImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xinghao"]];
    startImg.frame = CGRectMake(CGRectGetMaxX(self.quality_label.frame) + const_ScreenChinge(5), CGRectGetMidY(self.quality_label.frame) - const_ScreenChinge(3), const_ScreenChinge(6), const_ScreenChinge(6));
    [picImageView addSubview:startImg];
    
    self.qualityContent_label = [[UILabel alloc] init];
    self.qualityContent_label.font = [UIFont systemFontOfSize:const_ScreenChinge(13)];
    self.qualityContent_label.frame = CGRectMake(CGRectGetMinX(startImg.frame) + const_ScreenChinge(18), CGRectGetMinY(self.quality_label.frame), CGRectGetWidth(picImageView.frame) - CGRectGetMaxX(startImg.frame) - const_ScreenChinge(50), CGRectGetHeight(self.quality_label.frame));
    [picImageView addSubview:self.qualityContent_label];
    
    self.four_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.four_button.frame = CGRectMake(CGRectGetWidth(picImageView.frame) - const_ScreenChinge(30), CGRectGetMidY(self.qualityContent_label.frame) - const_ScreenChinge(10), const_ScreenChinge(20), const_ScreenChinge(20));
    [self.four_button setImage:[UIImage imageNamed:@"choice-list-"] forState:UIControlStateNormal];
    [self.four_button addTarget:self action:@selector(chooseMessageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [picImageView addSubview:self.four_button];
    
}

#pragma mark - 点击事件

- (void)chooseMessageButtonClick {
    NSLog(@"主人~~您点击了多选框按钮!!");
    if (self.presentMaskViewBlock) {
        self.presentMaskViewBlock(self.teamAttr);
    }
}

@end
