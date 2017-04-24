//
//  XFJFourAttributeTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

/*
 *  单选框
 *  单选框
 *  单选框
 */

#import "XFJFourAttributeTableViewCell.h"

#define const_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define const_ScreenHeight [UIScreen mainScreen].bounds.size.height
#define const_ScreenChinge(A) (A) * [UIScreen mainScreen].bounds.size.width/375

@interface XFJFourAttributeTableViewCell() <UITextFieldDelegate>


@property (nonatomic, strong) UIButton *four_button;
@property (nonatomic, strong) NSString *types;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *startImageView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@end

@implementation XFJFourAttributeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatUI];
        
    }
    return self;
}


- (void)creatUI {
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(const_ScreenChinge(18), const_ScreenChinge(9), const_ScreenWidth - const_ScreenChinge(36), const_ScreenChinge(40))];
    self.backgroundImageView.image = [UIImage imageNamed:@"input-box-"];
    self.backgroundImageView.userInteractionEnabled = YES;
    [self addSubview:self.backgroundImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(const_ScreenChinge(18), const_ScreenChinge(9), const_ScreenChinge(40), const_ScreenChinge(22))];
    self.titleLabel.text = @"单选框";
    self.titleLabel.font = [UIFont systemFontOfSize:const_ScreenChinge(13)];
    [self.backgroundImageView addSubview:self.titleLabel];
    
    self.startImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + const_ScreenChinge(9), CGRectGetMidY(self.titleLabel.frame) - const_ScreenChinge(3), const_ScreenChinge(6), const_ScreenChinge(6))];
    self.startImageView.image = [UIImage imageNamed:@"xinghao"];
    [self.backgroundImageView addSubview:self.startImageView];
    
    self.quality_field = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.startImageView.frame) + const_ScreenChinge(9), CGRectGetMinY(self.titleLabel.frame), CGRectGetWidth(self.backgroundImageView.frame) - CGRectGetMaxX(self.startImageView.frame) - const_ScreenChinge(50), CGRectGetHeight(self.titleLabel.frame))];
    self.quality_field.placeholder = @"请输入属性";
    self.quality_field.userInteractionEnabled = NO;
    self.quality_field.font = [UIFont systemFontOfSize:const_ScreenChinge(13)];
    [self.backgroundImageView addSubview:self.quality_field];
//    self.quality_field.textColor = kColorBCBC;
    
    _four_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_four_button setImage:[UIImage originalWithImage:@"choice-list-"] forState:UIControlStateNormal];
    [_four_button addTarget:self action:@selector(chooseMessageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.four_button.frame = CGRectMake(CGRectGetWidth(self.backgroundImageView.frame) - const_ScreenChinge(20), CGRectGetMidY(self.titleLabel.frame) - const_ScreenChinge(5.5), const_ScreenChinge(11), const_ScreenChinge(11));
    [self.backgroundImageView addSubview:self.four_button];
    
}


//- (UITextField *)quality_field
//{
//    if (_quality_field == nil) {
//        _quality_field = [UITextField textBackGroundImage:@"input-box-" titleName:@"单选框" rightImage:@"xinghao" placeholder:@"请选择属性"];
//        _quality_field.delegate = self;
//    }
//    return _quality_field;
//}

//- (UIButton *)four_button
//{
//    if (_four_button == nil) {
//        _four_button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_four_button setImage:[UIImage originalWithImage:@"choice-list-"] forState:UIControlStateNormal];
//        [_four_button addTarget:self action:@selector(chooseMessageButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        self.four_button.frame = CGRectMake(CGRectGetMaxX(self.backgroundImageView.frame) - 30, CGRectGetMinY(self.titleLabel.frame) - 10, 20, 20);
//    }
//    return _four_button;
//}

- (void)chooseMessageButtonClick
{
    NSLog(@"主人~~您点击了复选框按钮!!");
    if (self.presentMaskViewBlock) {
        self.presentMaskViewBlock(self.teamAttr);
        NSLog(@"++++++++++获取到的teamAttr值是 :%@",self.teamAttr);
    }
}



@end
