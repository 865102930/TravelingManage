//
//  XFJCarNameTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/13.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJCarNameTableViewCell.h"
#import "XFJCarNumberItem.h"


@interface XFJCarNameTableViewCell()

@property (nonatomic, strong) UITextField *carName_field;

@property (nonatomic, strong) UIButton *carNmae_button;

@end

@implementation XFJCarNameTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initControlWithCarName];
        [self setUpConventionCarNameWithMas];
        [self tapkeyboardHide];
    }
    return self;
}

#pragma mark - 添加收拾来隐藏键盘
- (void)tapkeyboardHide
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.carNmae_button addGestureRecognizer:tapGestureRecognizer];
}

-(void)keyboardHide:(UITapGestureRecognizer *)tap{
    [self.carName_field resignFirstResponder];
}

- (void)initControlWithCarName
{
    [self addSubview:self.carName_field];
    [self addSubview:self.carNmae_button];
}

- (void)setUpConventionCarNameWithMas
{
    [self.carName_field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(5.0);
        make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
        make.width.mas_equalTo(231);
        make.height.mas_equalTo(38.0);
    }];
    [self.carNmae_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.carName_field.mas_top);
        make.height.width.mas_equalTo(37.0);
        make.left.mas_equalTo(self.carName_field.mas_right).mas_offset(9.0);
    }];
}

- (UITextField *)carName_field
{
    if (_carName_field == nil) {
        _carName_field = [UITextField textBackGroundImage:@"input-box2-" titleName:@"车    牌    号" rightImage:@"xinghao" placeholder:@"请输入车牌号"];
        [_carName_field addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingDidEnd];
    }
    return _carName_field;
}

- (void)textFieldEditChanged:(UITextField *)textField
{
    NSLog(@"主人,您获取到的输入框的值是 : %@",textField.text);
    self.str = textField.text;
    if (self.carNumberBlock) {
        self.carNumberBlock(textField.text);
    }
}

- (UIButton *)carNmae_button
{
    if (_carNmae_button == nil) {
        _carNmae_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_carNmae_button setImage:[UIImage originalWithImage:@"add-"] forState:UIControlStateNormal];
        [_carNmae_button addTarget:self action:@selector(addCarNameButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _carNmae_button.tag = 0;
    }
    return _carNmae_button;
}

- (void)addCarNameButtonClick:(UIButton *)buttonTag
{
    NSLog(@"添加一行车牌号码~~");
    
    if (self.addCellBlock) {
        self.addCellBlock(buttonTag.tag,self.carName_field.text,buttonTag);
    }
}


- (void)setCarNumberItemArray:(NSMutableArray<XFJCarNumberItem *> *)carNumberItemArray
{
    _carNumberItemArray = carNumberItemArray;
    if (carNumberItemArray.count == 0) {
        return;
    }
    if (self.isAddStrBool) {
        self.carName_field.text = [NSString stringWithFormat:@"%@",self.addStrNumber];
    }else {
        self.carName_field.text = [NSString stringWithFormat:@"%@",carNumberItemArray[0].plateHead];
    }
}

- (void)setAddStrNumber:(NSString *)addStrNumber
{
    _addStrNumber = addStrNumber;
}

- (void)setFindTeamInfoByStateItem:(XFJFindTeamInfoByStateItem *)findTeamInfoByStateItem
{
    _findTeamInfoByStateItem = findTeamInfoByStateItem;
}


- (void)setFindTeamCarItem:(XFJFindTeamCarItem *)findTeamCarItem
{
    _findTeamCarItem = findTeamCarItem;
    self.carName_field.text = findTeamCarItem.vehicleNo;
}




@end
