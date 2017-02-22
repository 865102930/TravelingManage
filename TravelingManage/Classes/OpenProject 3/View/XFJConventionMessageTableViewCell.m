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

@interface XFJConventionMessageTableViewCell() <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView *line_view;

@property (nonatomic, strong) UIImageView *conventionMessage_imageView;

@property (nonatomic, strong) UILabel *conventionMessage_label;

@property (nonatomic, strong) UITextField *groupText_field;

@property (nonatomic, strong) UITextField *groupTime_field;

@property (nonatomic, strong) UITextField *travelServiceName_field;

@property (nonatomic, strong) UITableView *check_traveView;

@property (nonatomic, strong) NSMutableArray<XFJFindTravelAgencyListItem *> *findTravelAgencyList_array;

@end

@implementation XFJConventionMessageTableViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initControlWithConventionMessage];
        [self setUpConventionMessageWithMas];
    }
    return self;
}

#pragma mark - 初始化控件
- (void)initControlWithConventionMessage
{
    [self addSubview:self.line_view];
    [self addSubview:self.conventionMessage_imageView];
    [self addSubview:self.conventionMessage_label];
    [self addSubview:self.groupText_field];
    [self addSubview:self.groupTime_field];
    [self addSubview:self.travelServiceName_field];
}

#pragma mark - 布局控件
- (void)setUpConventionMessageWithMas
{
    [self.line_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.height.mas_equalTo(3.0);
        make.right.mas_equalTo(self.mas_right);
    }];
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
    [self.groupTime_field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.groupText_field.mas_bottom).mas_offset(9.0);
        make.left.mas_equalTo(self.groupText_field.mas_left);
        make.right.mas_equalTo(self.groupText_field.mas_right);
        make.height.mas_equalTo(self.groupText_field.mas_height);
    }];
    [self.travelServiceName_field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.groupTime_field.mas_bottom).mas_offset(9.0);
        make.left.mas_equalTo(self.groupTime_field.mas_left);
        make.right.mas_equalTo(self.groupTime_field.mas_right);
        make.height.mas_equalTo(self.groupTime_field.mas_height);
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

- (UIImageView *)conventionMessage_imageView
{
    if (_conventionMessage_imageView == nil) {
        _conventionMessage_imageView = [[UIImageView alloc] init];
        _conventionMessage_imageView.image = [UIImage originalWithImage:@"information-"];
    }
    return _conventionMessage_imageView;
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
        [_groupText_field addTarget:self action:@selector(groupText_endText:) forControlEvents:UIControlEventEditingDidEnd];
        _groupText_field.tag = 10000;
    }
    return _groupText_field;
}

- (void)groupText_endText:(UITextField *)groupText_field
{
    if (groupText_field.tag == 10000) {
        NSLog(@"++++++++++++获取到用户输入的团队编号是:%@",groupText_field.text);
        self.groupName_text = groupText_field.text;
    }else if (groupText_field.tag == 10001) {
        NSLog(@"++++++++++++获取到用户输入的出团时间是:%@",groupText_field.text);
        self.groupTime_text = groupText_field.text;
    }
}

- (UITextField *)groupTime_field
{
    if (_groupTime_field == nil) {
        _groupTime_field = [UITextField textBackGroundImage:@"input-box-" titleName:@"出 团 日 期" rightImage:@"xinghao" placeholder:@"2017-02-23"];
        [_groupTime_field addTarget:self action:@selector(groupText_endText:) forControlEvents:UIControlEventEditingDidEnd];
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

- (UITableView *)check_traveView
{
    if (_check_traveView == nil) {
        _check_traveView = [[UITableView alloc] init];
        _check_traveView.delegate = self;
        _check_traveView.dataSource = self;
        _check_traveView.backgroundColor = [UIColor whiteColor];
        [_check_traveView.layer setBorderWidth:1.0];
        _check_traveView.layer.borderColor = kBorderColor.CGColor;
    }
    return _check_traveView;
}


#pragma mark - 当输入框有值的改变的时候调用
- (void)textField_change:(UITextField *)text_field
{
    self.travelName = text_field.text;
    [self setUpCreatTraveTableView];
    NSDictionary *dictParaments = @{
                                    @"taName":text_field.text
                                    };
    __weak __typeof(self)wself = self;
    [[NetWorkManager shareManager] requestWithType:HttpRequestTypePost withUrlString:CHECKOUTTRAVENAMEURL withParaments:dictParaments withSuccessBlock:^(id object) {
        if (object) {
            NSLog(@"查询成功----------%@",object);
            NSMutableArray *arrayWithTraveList = [object objectForKey:@"rows"];
            wself.findTravelAgencyList_array = [XFJFindTravelAgencyListItem mj_objectArrayWithKeyValuesArray:arrayWithTraveList];
            dispatch_async(dispatch_get_main_queue(), ^{
                [wself.check_traveView reloadData];
            });
        }
    } withFailureBlock:^(NSError *error) {
        if (error) {
            NSLog(@"查询失败---------%@",error);
            [MBProgressHUD showHudTipStr:@"网络错误" contentColor:HidWithColorContentBlack];
        }
    } progress:^(float progress) {
    }];
}

#pragma mark - 创建旅行社显示框
- (void)setUpCreatTraveTableView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.check_traveView];
    [self.check_traveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.travelServiceName_field.mas_bottom).mas_offset(2.0);
        make.left.mas_equalTo(self.travelServiceName_field.mas_left);
        make.right.mas_equalTo(self.travelServiceName_field.mas_right);
        make.height.mas_equalTo(33 * 6);
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
    return [self.findTravelAgencyList_array count];
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
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.findTravelAgencyList_array[indexPath.row].taName];
    return cell;
}

#pragma mark - cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.travelServiceName_field.text = self.findTravelAgencyList_array[indexPath.row].taName;
    [self.check_traveView removeFromSuperview];
}


#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33.0;
}




@end
