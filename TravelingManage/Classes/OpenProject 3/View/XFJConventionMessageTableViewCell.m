//
//  XFJConventionMessageTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/10.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJConventionMessageTableViewCell.h"
#import "XFJFindTravelAgencyListItem.h"
#import <Masonry.h>
#import "GFCalendar.h"
#import "XFJMaskView.h"

@interface XFJConventionMessageTableViewCell() <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView *line_view;

@property (nonatomic, strong) UIImageView *conventionMessage_imageView;

@property (nonatomic, strong) UILabel *conventionMessage_label;

@property (nonatomic, strong) UITextField *groupText_field;

@property (nonatomic, strong) UITextField *groupTime_field;

@property (nonatomic, strong) UITextField *travelServiceName_field;

@property (nonatomic, strong) UITableView *check_traveView;

@property (nonatomic, strong) NSMutableArray<XFJFindTravelAgencyListItem *> *findTravelAgencyList_array;

@property (nonatomic, strong) UIButton *goalAttribute_button;

@property (nonatomic, strong) UILabel *goalAttribute_label;

@property (nonatomic, strong) UIImageView *goalAttribute_imageViewLeft;

@property (nonatomic, strong) UILabel *goalAttributeContent_label;

@property (nonatomic, strong) XFJMaskView *maskView1;

@property (nonatomic, strong) NSMutableArray <XFJFindTravelAgencyListItem *> *result;

@end

@implementation XFJConventionMessageTableViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initControlWithConventionMessage];
        [self setUpConventionMessageWithMas];
        __weak __typeof(self)wself = self;
        self.maskView1.maskBlock = ^() {
            [wself.maskView1 removeFromSuperview];
        };
    }
    return self;
}

#pragma mark - 初始化控件
- (void)initControlWithConventionMessage
{
//    [self addSubview:self.line_view];
    [self addSubview:self.conventionMessage_imageView];
    [self addSubview:self.conventionMessage_label];
    [self addSubview:self.groupText_field];
//    [self addSubview:self.groupTime_field];
    [self addSubview:self.goalAttribute_button];
    [self.goalAttribute_button addSubview:self.goalAttribute_label];
    [self.goalAttribute_button addSubview:self.goalAttribute_imageViewLeft];
    [self.goalAttribute_button addSubview:self.goalAttributeContent_label];
    [self addSubview:self.travelServiceName_field];
}

#pragma mark - 布局控件
- (void)setUpConventionMessageWithMas
{
//    [self.line_view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.mas_top);
//        make.left.mas_equalTo(self.mas_left);
//        make.height.mas_equalTo(3.0);
//        make.right.mas_equalTo(self.mas_right);
//    }];
    [self.conventionMessage_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24.0);
        make.left.mas_equalTo(18.0);
        make.height.mas_equalTo(15.0);
        make.width.mas_equalTo(13.0);
    }];
    [self.conventionMessage_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.conventionMessage_imageView.mas_centerY);
        make.left.mas_equalTo(self.conventionMessage_imageView.mas_right).mas_offset(10.0);
    }];
    [self.groupText_field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.conventionMessage_imageView.mas_bottom).mas_offset(16.0);
        make.left.mas_equalTo(self.conventionMessage_imageView.mas_left);
        make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
        make.height.mas_equalTo(38.0);
    }];
//    [self.groupTime_field mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.groupText_field.mas_bottom).mas_offset(9.0);
//        make.left.mas_equalTo(self.groupText_field.mas_left);
//        make.right.mas_equalTo(self.groupText_field.mas_right);
//        make.height.mas_equalTo(self.groupText_field.mas_height);
//    }];
    [self.goalAttribute_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.groupText_field.mas_bottom).mas_offset(9.0);
        make.left.mas_equalTo(self.groupText_field.mas_left);
        make.right.mas_equalTo(self.groupText_field.mas_right);
        make.height.mas_equalTo(self.groupText_field.mas_height);
    }];
    [self.goalAttribute_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.goalAttribute_button.mas_centerY);
        make.left.mas_equalTo(self.goalAttribute_button.mas_left).mas_offset(15.0);
    }];
    [self.goalAttribute_imageViewLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goalAttribute_button.mas_top).mas_offset(13.0);
        make.left.mas_equalTo(self.goalAttribute_label.mas_right).mas_offset(5.0);
        make.height.mas_equalTo(5.0);
        make.width.mas_equalTo(5.0);
    }];
    [self.travelServiceName_field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goalAttribute_button.mas_bottom).mas_offset(9.0);
        make.left.mas_equalTo(self.goalAttribute_button.mas_left);
        make.right.mas_equalTo(self.goalAttribute_button.mas_right);
        make.height.mas_equalTo(self.goalAttribute_button.mas_height);
    }];
    [self.goalAttributeContent_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goalAttribute_imageViewLeft.mas_right).mas_offset(18.0);
        make.centerY.mas_equalTo(self.goalAttribute_label.mas_centerY);
    }];
}

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = kColoreeee;
    }
    return _line_view;
}

- (XFJMaskView *)maskView1
{
    if (_maskView1 == nil) {
        _maskView1 = [[XFJMaskView alloc] initWithFrame:CGRectZero];
    }
    return _maskView1;
}

- (UIImageView *)conventionMessage_imageView
{
    if (_conventionMessage_imageView == nil) {
        _conventionMessage_imageView = [[UIImageView alloc] init];
        _conventionMessage_imageView.image = [UIImage originalWithImage:@"information-"];
    }
    return _conventionMessage_imageView;
}

- (NSMutableArray <XFJFindTravelAgencyListItem *> *)result
{
    if (_result == nil) {
        _result = [NSMutableArray array];
    }
    return _result;
}

- (UILabel *)conventionMessage_label
{
    if (_conventionMessage_label == nil) {
        _conventionMessage_label = [[UILabel alloc] init];
        _conventionMessage_label.text = @"常规信息";
        _conventionMessage_label.textColor = kColorff47;
        [_conventionMessage_label setFont:[UIFont systemFontOfSize:15.0]];
        _conventionMessage_label.textAlignment = NSTextAlignmentLeft;
    }
    return _conventionMessage_label;
}

- (UITextField *)groupText_field
{
    if (_groupText_field == nil) {
        _groupText_field = [UITextField textBackGroundImage:@"input-box-" titleName:@"团 队 编 号" rightImage:@"xinghao" placeholder:@"请输入团队编号"];
        [_groupText_field addTarget:self action:@selector(groupText_endText:) forControlEvents:UIControlEventEditingChanged];
        [_groupText_field becomeFirstResponder];
        _groupText_field.tag = 10000;
    }
    return _groupText_field;
}

- (void)groupText_endText:(UITextField *)groupText_field
{
    if (groupText_field.tag == 10000) {
        NSLog(@"++++++++++++获取到用户输入的团队编号是:%@",groupText_field.text);
        if (groupText_field.text.length > 10) {
            [MBProgressHUD showHudTipStr:@"请输入10位以内的编号!" contentColor:HidWithColorContentBlack];
            return;
        }else {
            self.groupName_text = groupText_field.text;
        }
    }else if (groupText_field.tag == 10001) {
        NSLog(@"++++++++++++获取到用户输入的出团时间是:%@",groupText_field.text);
    }
}

- (UIButton *)goalAttribute_button
{
    if (_goalAttribute_button == nil) {
        _goalAttribute_button = [UIButton buttonWithType:UIButtonTypeCustom];
        _goalAttribute_button.layer.borderColor = kBorderColor.CGColor;
        _goalAttribute_button.layer.borderWidth = 0.5;
        _goalAttribute_button.layer.cornerRadius = 3.0;
        _goalAttribute_button.clipsToBounds = YES;
        _goalAttribute_button.layer.masksToBounds = YES;
        [_goalAttribute_button addTarget:self action:@selector(goalAttributeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goalAttribute_button;
}

- (void)goalAttributeButtonClick
{
    [self.groupText_field resignFirstResponder];
    CGFloat width = self.bounds.size.width - 20.0;
    CGPoint origin = CGPointMake(10.0, 64.0 + 70.0);
    GFCalendarView *calendar = [[GFCalendarView alloc] initWithFrameOrigin:origin width:width];
    calendar.backgroundColor = [UIColor whiteColor];
    // 点击某一天的回调
    __weak __typeof(self)wself = self;
    calendar.didSelectDayHandler = ^(NSInteger year, NSInteger month, NSInteger day) {
        [wself.maskView1 removeFromSuperview];
        NSLog(@"----------------选择的时间是 :%zd/%zd/%zd",year, month, day);
        wself.groupTime_text = [NSString stringWithFormat:@"%zd/%zd/%zd",year,month,day];
        wself.goalAttributeContent_label.text = [NSString stringWithFormat:@"%zd/%zd/%zd",year,month,day];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskView1];
    [self.maskView1 addSubview:calendar];
}

- (UILabel *)goalAttribute_label
{
    if (_goalAttribute_label == nil) {
        _goalAttribute_label = [[UILabel alloc] init];
        _goalAttribute_label.text = @"出 团 日 期";
        _goalAttribute_label.textColor = kColor2f2f;
        _goalAttribute_label.font = [UIFont systemFontOfSize:13.0];
    }
    return _goalAttribute_label;
}

- (UIImageView *)goalAttribute_imageViewLeft
{
    if (_goalAttribute_imageViewLeft == nil) {
        _goalAttribute_imageViewLeft = [[UIImageView alloc] init];
        _goalAttribute_imageViewLeft.image = [UIImage originalWithImage:@"xinghao"];
    }
    return _goalAttribute_imageViewLeft;
}

- (UILabel *)goalAttributeContent_label
{
    if (_goalAttributeContent_label == nil) {
        _goalAttributeContent_label = [[UILabel alloc] init];
        _goalAttributeContent_label.text = @"请选择出团日期";
        _goalAttributeContent_label.textColor = kColor2f2f;
        _goalAttributeContent_label.font = [UIFont systemFontOfSize:14.0];
    }
    return _goalAttributeContent_label;
}

- (UITextField *)groupTime_field
{
    if (_groupTime_field == nil) {
        _groupTime_field = [UITextField textBackGroundImage:@"input-box-" titleName:@"出 团 日 期" rightImage:@"xinghao" placeholder:@"2017/02/23"];
        [_groupTime_field addTarget:self action:@selector(groupText_endText:) forControlEvents:UIControlEventEditingChanged];
        _groupTime_field.tag = 10001;
    }
    return _groupTime_field;
}

- (UITextField *)travelServiceName_field
{
    if (_travelServiceName_field == nil) {
        _travelServiceName_field = [UITextField textBackGroundImage:@"input-box-" titleName:@"旅行社名称" rightImage:@"xinghao" placeholder:@"请输入旅行社名"];
        [_travelServiceName_field addTarget:self action:@selector(textField_change:) forControlEvents:UIControlEventEditingChanged];
        _travelServiceName_field.tag = 10002;
    }
    return _travelServiceName_field;
}

- (NSMutableArray <XFJFindTravelAgencyListItem *> *)findTravelAgencyList_array
{
    if (_findTravelAgencyList_array == nil) {
        _findTravelAgencyList_array = [NSMutableArray array];
    }
    return _findTravelAgencyList_array;
}

- (void)setFindTeamInfoByStateItem:(XFJFindTeamInfoByStateItem *)findTeamInfoByStateItem
{
    _findTeamInfoByStateItem = findTeamInfoByStateItem;
    self.groupText_field.text = [NSString stringWithFormat:@"%@",findTeamInfoByStateItem.teamNo];
    self.groupTime_field.text = [NSString stringWithFormat:@"%@",findTeamInfoByStateItem.teamDate];
    self.travelServiceName_field.text = [NSString stringWithFormat:@"%@",findTeamInfoByStateItem.travelAgencyName];
}

- (UITableView *)check_traveView
{
    if (_check_traveView == nil) {
        _check_traveView = [[UITableView alloc] init];
        _check_traveView.delegate = self;
        _check_traveView.dataSource = self;
        _check_traveView.backgroundColor = [UIColor whiteColor];
        [_check_traveView.layer setBorderWidth:1.0];
        _check_traveView.layer.borderColor = kBorderColor.CGColor;
        _check_traveView.layer.cornerRadius = 5.0;
    }
    return _check_traveView;
}


#pragma mark - 当输入框有值的改变的时候调用
- (void)textField_change:(UITextField *)text_field
{
    NSDictionary *dictParaments = @{
                                    @"taName":text_field.text
                                    };
    __weak __typeof(self)wself = self;
    [[NetWorkManager shareManager] requestWithType:HttpRequestTypePost withUrlString:CHECKOUTTRAVENAMEURL withParaments:dictParaments withSuccessBlock:^(id object) {
        if (object) {
            NSLog(@"查询成功----------%@",object);
            NSMutableArray *arrayWithTraveList = [object objectForKey:@"rows"];
            wself.findTravelAgencyList_array = [XFJFindTravelAgencyListItem mj_objectArrayWithKeyValuesArray:arrayWithTraveList];
            [wself searchBarTextDidChange:text_field.text];
        }
    } withFailureBlock:^(NSError *error) {
        if (error) {
            NSLog(@"查询失败---------%@",error);
            [MBProgressHUD showHudTipStr:@"网络错误" contentColor:HidWithColorContentBlack];
        }
    } progress:^(float progress) {
    }];
}
#pragma mark - 根据输入的文字来筛选

-(void)searchBarTextDidChange:(NSString *)searchText
{
    self.result = nil;
    for (int i = 0; i < self.findTravelAgencyList_array.count; i++) {
        NSString *string = self.findTravelAgencyList_array[i].taName;
        if (string.length >= searchText.length) {
            if([self.findTravelAgencyList_array[i].taName rangeOfString:searchText].location != NSNotFound){
                [self.result addObject:self.findTravelAgencyList_array[i]];
            }
        }
    }
    if (self.result.count != 0) {
        [self setUpCreatTraveTableView];
        [self.check_traveView reloadData];
    }
}


#pragma mark - 创建旅行社显示框
- (void)setUpCreatTraveTableView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.check_traveView];
    [self.check_traveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.travelServiceName_field.mas_bottom);
        make.left.mas_equalTo(self.travelServiceName_field.mas_left).mas_offset(95);
        make.right.mas_equalTo(self.travelServiceName_field.mas_right);
        if (self.result.count > 5) {
            make.height.mas_equalTo(196.0);
        }else {
            make.height.mas_equalTo(33 * self.result.count);
        }
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma makr - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.result count];
}

#pragma makr - cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.preservesSuperviewLayoutMargins = NO;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.result[indexPath.row].taName];
    return cell;
}

#pragma mark - cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.travelServiceName_field.text = self.result[indexPath.row].taName;
    self.travelName = self.result[indexPath.row].findTravelAgencyList_id;//findTravelAgencyList_id
    NSLog(@"self.travelName类型的值是:%zd",self.travelName);
    [self.check_traveView removeFromSuperview];
}


#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 33.0;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.check_traveView removeFromSuperview];
}






@end
