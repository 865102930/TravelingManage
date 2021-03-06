//
//  XFJTeamInformationTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/14.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJTeamInformationTableViewCell.h"
#import "XFJTeamPropertiesItem.h"


@interface XFJTeamInformationTableViewCell() <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *line_View;

@property (nonatomic, strong) UIImageView *teamInformation_imageView;

@property (nonatomic, strong) UILabel *teamInformation_label;

@property (nonatomic, strong) UITextField *teamNumber_field;

//团队性质
@property (nonatomic, strong) UIButton *teamProperties_button;

@property (nonatomic, strong) UILabel *teamProperties_label;

@property (nonatomic, strong) UIImageView *teamProperties_imageViewLeft;

@property (nonatomic, strong) UILabel *teamPropertiesContent_label;

@property (nonatomic, strong) UIImageView *teamProperties_imageViewRight;

@property (nonatomic, strong) UITextField *journeyDay_field;

@property (nonatomic, strong) UITableView *teamDescription_tablewView;

@property (nonatomic, strong) NSMutableArray<XFJTeamPropertiesItem *> *teamDescriptionArray;

@end

@implementation XFJTeamInformationTableViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self requestTeamProperties];
        [self addSubview:self.line_View];
        [self addSubview:self.teamInformation_imageView];
        [self addSubview:self.teamInformation_label];
        [self addSubview:self.teamNumber_field];
        [self addSubview:self.teamProperties_button];
        [self addSubview:self.teamProperties_label];
        [self addSubview:self.teamProperties_imageViewLeft];
        [self addSubview:self.teamPropertiesContent_label];
        [self addSubview:self.teamProperties_imageViewRight];
        [self addSubview:self.journeyDay_field];
        [self.line_View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(self.mas_left);
            make.height.mas_equalTo(3.0);
            make.right.mas_equalTo(self.mas_right);
        }];
        [self.teamInformation_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(24.0);
            make.left.mas_equalTo(18.0);
            make.height.mas_equalTo(15.0);
            make.width.mas_equalTo(13.0);
        }];
        [self.teamInformation_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.teamInformation_imageView.mas_centerY);
            make.left.mas_equalTo(self.teamInformation_imageView.mas_right).mas_offset(10.0);
        }];
        [self.teamNumber_field mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.teamInformation_imageView.mas_bottom).mas_offset(16.0);
            make.left.mas_equalTo(self.teamInformation_imageView.mas_left);
            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
            make.height.mas_equalTo(38.0);
        }];
        [self.teamProperties_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.teamNumber_field.mas_bottom).mas_offset(9.0);
            make.left.mas_equalTo(self.teamNumber_field.mas_left);
            make.right.mas_equalTo(self.teamNumber_field.mas_right);
            make.height.mas_equalTo(38.0);
        }];
        [self.teamProperties_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.teamProperties_button.mas_centerY);
            make.left.mas_equalTo(self.teamProperties_button.mas_left).mas_offset(15.0);
        }];
        [self.teamProperties_imageViewLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.teamProperties_button.mas_top).mas_offset(13.0);
            make.left.mas_equalTo(self.teamProperties_label.mas_right).mas_offset(1.0);
            make.height.mas_equalTo(5.0);
            make.width.mas_equalTo(5.0);
        }];
        [self.teamProperties_imageViewRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.teamProperties_button.mas_right).mas_offset(-2);
            make.centerY.mas_equalTo(self.teamProperties_button.mas_centerY);
            make.height.mas_equalTo(6.0);
            make.width.mas_equalTo(8.0);
        }];
        [self.teamPropertiesContent_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.teamProperties_imageViewLeft.mas_right).mas_offset(18.0);
            make.centerY.mas_equalTo(self.teamProperties_label.mas_centerY);
        }];
        [self.journeyDay_field mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.teamProperties_button.mas_bottom).mas_offset(9.0);
            make.left.mas_equalTo(self.teamProperties_button.mas_left);
            make.right.mas_equalTo(self.teamProperties_button.mas_right);
            make.height.mas_equalTo(38.0);
        }];
    }
    return self;
}

- (void)requestTeamProperties
{
    NSDictionary *dictParaments = @{
                                    @"state":@"1"
                                    };
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:TEAMNUMBERQUERYURL params:dictParaments success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSLog(@"++++++==========----获取到的团队性质的值是:%@",responseObject);
            NSMutableArray *teamArray = [responseObject objectForKey:@"rows"];
            wself.teamDescriptionArray = [XFJTeamPropertiesItem mj_objectArrayWithKeyValuesArray:teamArray];
            [wself.teamDescription_tablewView reloadData];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            [MBProgressHUD showHudTipStr:@"网络错误" contentColor:HidWithColorContentBlack];
        }
    }];
}

- (UIView *)line_View
{
    if (_line_View == nil) {
        _line_View = [[UIView alloc] init];
        _line_View.backgroundColor = kColoreeee;
    }
    return _line_View;
}

- (UIImageView *)teamInformation_imageView
{
    if (_teamInformation_imageView == nil) {
        _teamInformation_imageView = [[UIImageView alloc] init];
        _teamInformation_imageView.image = [UIImage originalWithImage:@"information-"];
    }
    return _teamInformation_imageView;
}

- (UILabel *)teamInformation_label
{
    if (_teamInformation_label == nil) {
        _teamInformation_label = [[UILabel alloc] init];
        _teamInformation_label.text = @"团队信息";
        _teamInformation_label.textColor = kColorff47;
        [_teamInformation_label setFont:[UIFont systemFontOfSize:15.0]];
        _teamInformation_label.textAlignment = NSTextAlignmentLeft;
    }
    return _teamInformation_label;
}

- (UITextField *)teamNumber_field
{
    if (_teamNumber_field == nil) {
        _teamNumber_field = [UITextField textBackGroundImage:@"input-box-" titleName:@"团 队 人 数" rightImage:@"xinghao" placeholder:@"请输入团队人数"];
        [_teamNumber_field addTarget:self action:@selector(teamNumber_endText:) forControlEvents:UIControlEventEditingChanged];
        _teamNumber_field.keyboardType = UIKeyboardTypeNumberPad;
        _teamNumber_field.tag = 10003;
    }
    return _teamNumber_field;
}

- (UIButton *)teamProperties_button
{
    if (_teamProperties_button == nil) {
        _teamProperties_button = [UIButton buttonWithType:UIButtonTypeCustom];
        _teamProperties_button.layer.borderColor = kBorderColor.CGColor;
        _teamProperties_button.layer.borderWidth = 0.5;
        _teamProperties_button.layer.cornerRadius = 3.0;
        _teamProperties_button.clipsToBounds = YES;
        _teamProperties_button.layer.masksToBounds = YES;
        [_teamProperties_button addTarget:self action:@selector(teamPropertiesButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _teamProperties_button;
}
- (void)teamPropertiesButtonClick
{
    NSLog(@"主人,您点击了团队性质~~");
    [self addSubview:self.teamDescription_tablewView];
    [self.teamDescription_tablewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.teamProperties_button.mas_left).mas_offset(95.0);
        make.right.mas_equalTo(self.teamProperties_button.mas_right);
        make.top.mas_equalTo(self.teamProperties_button.mas_bottom);
        if (self.teamDescriptionArray.count > 5) {
            make.height.mas_equalTo(196.0);
        }else {
            make.height.mas_equalTo(self.teamDescriptionArray.count * 33.0);
        }
    }];
    self.teamProperties_imageViewRight.image = [UIImage originalWithImage:@"triangle"];
}

- (UITableView *)teamDescription_tablewView
{
    if (_teamDescription_tablewView == nil) {
        _teamDescription_tablewView = [[UITableView alloc] init];
        _teamDescription_tablewView.delegate = self;
        _teamDescription_tablewView.dataSource = self;
        _teamDescription_tablewView.backgroundColor = [UIColor whiteColor];
        [_teamDescription_tablewView.layer setBorderWidth:1.0];
        _teamDescription_tablewView.layer.borderColor = kBorderColor.CGColor;
        _teamDescription_tablewView.layer.cornerRadius = 5.0;
        _teamDescription_tablewView.rowHeight = 38.0;
        _teamDescription_tablewView.tag = 1000;
    }
    return _teamDescription_tablewView;
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    UITableView *firTableView = [self viewWithTag:1000];
    if (view == nil) {
        CGPoint tempoint = [firTableView convertPoint:point fromView:self];
        if (CGRectContainsPoint(firTableView.bounds, tempoint))
        {
            view = firTableView;
        }
    }
    return view;
}

- (UILabel *)teamProperties_label
{
    if (_teamProperties_label == nil) {
        _teamProperties_label = [[UILabel alloc] init];
        _teamProperties_label.text = @"团 队 性 质";
        _teamProperties_label.textColor = kColor2f2f;
        _teamProperties_label.font = [UIFont systemFontOfSize:13.0];
    }
    return _teamProperties_label;
}

- (UIImageView *)teamProperties_imageViewLeft
{
    if (_teamProperties_imageViewLeft == nil) {
        _teamProperties_imageViewLeft = [[UIImageView alloc] init];
        _teamProperties_imageViewLeft.image = [UIImage originalWithImage:@"xinghao"];
    }
    return _teamProperties_imageViewLeft;
}

- (UIImageView *)teamProperties_imageViewRight
{
    if (_teamProperties_imageViewRight == nil) {
        _teamProperties_imageViewRight = [[UIImageView alloc] init];
        _teamProperties_imageViewRight.image = [UIImage originalWithImage:@"Triangle-"];
    }
    return _teamProperties_imageViewRight;
}

- (UILabel *)teamPropertiesContent_label
{
    if (_teamPropertiesContent_label == nil) {
        _teamPropertiesContent_label = [[UILabel alloc] init];
        _teamPropertiesContent_label.text = @"请选择团队性质";
        _teamPropertiesContent_label.textColor = kColor2f2f;
        _teamPropertiesContent_label.font = [UIFont systemFontOfSize:14.0];
    }
    return _teamPropertiesContent_label;
}

- (UITextField *)journeyDay_field
{
    if (_journeyDay_field == nil) {
        _journeyDay_field = [UITextField textBackGroundImage:@"input-box-" titleName:@"行 程 天 数" rightImage:@"xinghao" placeholder:@"请输入行程天数"];
        [_journeyDay_field addTarget:self action:@selector(teamNumber_endText:) forControlEvents:UIControlEventEditingChanged];
        _journeyDay_field.keyboardType = UIKeyboardTypeNumberPad;
        _journeyDay_field.tag = 10004;
    }
    return _journeyDay_field;
}

- (void)teamNumber_endText:(UITextField *)text_field
{
    if (text_field.tag == 10003) {
        self.teamPeople_number = text_field.text;
    }else {
        self.teamDay = text_field.text;
    }
}

- (void)setFindTeamInfoByStateItem:(XFJFindTeamInfoByStateItem *)findTeamInfoByStateItem
{
    _findTeamInfoByStateItem = findTeamInfoByStateItem;
    self.teamNumber_field.text = [NSString stringWithFormat:@"%zd",findTeamInfoByStateItem.teamNum];
    self.journeyDay_field.text = findTeamInfoByStateItem.teamDay;
    self.teamPeople_number = [NSString stringWithFormat:@"%zd",findTeamInfoByStateItem.teamNum];
    self.teamDay = findTeamInfoByStateItem.teamDay;
    [self alreadyOpenWithFindTeamInfoByStateItem:findTeamInfoByStateItem];
}

#pragma mark - 重新开团中的团队性质
- (void)alreadyOpenWithFindTeamInfoByStateItem:(XFJFindTeamInfoByStateItem *)findTeamInfoByStateItem
{
    NSDictionary *dictParaments = @{
                                    @"state":@"1"
                                    };
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:TEAMNUMBERQUERYURL params:dictParaments success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSLog(@"++++++==========----获取到的团队性质的值是:%@",responseObject);
            NSMutableArray *teamArray = [responseObject objectForKey:@"rows"];
            wself.teamDescriptionArray = [XFJTeamPropertiesItem mj_objectArrayWithKeyValuesArray:teamArray];
            for (NSInteger i = 0; i < wself.teamDescriptionArray.count; i++) {
                NSString *paramVal = [NSString stringWithFormat:@"%zd",wself.teamDescriptionArray[i].paramVal];
                if (paramVal == findTeamInfoByStateItem.teamNature) {
                    self.teamPropertiesContent_label.text = self.teamDescriptionArray[i].paramName;
                    self.teamNature = [NSString stringWithFormat:@"%zd",wself.teamDescriptionArray[i].paramVal];
                    return;
                }
            }
            [wself.teamDescription_tablewView reloadData];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            [MBProgressHUD showHudTipStr:@"网络错误" contentColor:HidWithColorContentBlack];
        }
    }];
}

#pragma mark - 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.teamDescriptionArray count];
}

#pragma mark - cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.preservesSuperviewLayoutMargins = NO;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.teamDescriptionArray[indexPath.row].paramName];
    return cell;
}

#pragma mark - cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.teamProperties_imageViewRight.image = [UIImage originalWithImage:@"Triangle-"];
    NSString *indeStr = [NSString stringWithFormat:@"%@",self.teamDescriptionArray[indexPath.row].paramName];
    self.teamPropertiesContent_label.text = indeStr;
    self.teamNature = [NSString stringWithFormat:@"%zd",self.teamDescriptionArray[indexPath.row].paramVal];
    NSLog(@"这里获取到的是用户点击的行号数:%zd",self.teamNature);
    [self.teamDescription_tablewView removeFromSuperview];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38.0;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.teamDescription_tablewView removeFromSuperview];
    self.teamProperties_imageViewRight.image = [UIImage originalWithImage:@"Triangle-"];
}

@end
