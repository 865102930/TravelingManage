//
//  XFJTeamMessageBottomView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/4.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJTeamMessageBottomView.h"
#import "XFJTeamMessageTableViewCell.h"

@interface XFJTeamMessageBottomView() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *line_view;

@property (nonatomic, strong) UIImageView *carPhotos_imageView;
@property (nonatomic, strong) UILabel *carPhotos_label;

@property (nonatomic, strong) UITableView *visitMessage_tableView;
@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic, strong) NSMutableArray *arrayTask;

@end

@implementation XFJTeamMessageBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.line_view];
        [self addSubview:self.carPhotos_imageView];
        [self addSubview:self.carPhotos_label];
        [self addSubview:self.visitMessage_tableView];
        [self addSubview:self.sureButton];
        [self.line_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(2.0);
        }];
        [self.carPhotos_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.line_view.mas_bottom).mas_offset(9.0);
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.width.mas_equalTo(10.0);
            make.height.mas_equalTo(12.0);
        }];
        [self.carPhotos_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.carPhotos_imageView.mas_right).mas_offset(8.0);
            make.centerY.mas_equalTo(self.carPhotos_imageView.mas_centerY);
        }];
        [self.sureButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.visitMessage_tableView.mas_bottom).mas_offset(40.0);
            make.height.mas_equalTo(33.0);
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
        }];
    }
    return self;
}

- (UIImageView *)carPhotos_imageView
{
    if (_carPhotos_imageView == nil) {
        _carPhotos_imageView = [[UIImageView alloc] init];
        _carPhotos_imageView.image = [UIImage originalWithImage:@"information-"];
    }
    return _carPhotos_imageView;
}

- (UILabel *)carPhotos_label
{
    if (_carPhotos_label == nil) {
        _carPhotos_label = [[UILabel alloc] init];
        _carPhotos_label.text = @"游览信息";
        _carPhotos_label.font = [UIFont fontWithName:PingFang size:13.0];
        _carPhotos_label.textColor = kColorFF38;
    }
    return _carPhotos_label;
}

- (NSMutableArray *)arrayTask
{
    if (_arrayTask == nil) {
        _arrayTask = [NSMutableArray array];
    }
    return _arrayTask;
}

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = kColoreeee;
    }
    return _line_view;
}

- (UIButton *)sureButton
{
    if (_sureButton == nil) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitle:@"确认提交" forState:UIControlStateNormal];
        [_sureButton setTitleColor:kColorFFFF forState:UIControlStateNormal];
        _sureButton.backgroundColor = kColorff47;
        _sureButton.layer.cornerRadius = 8.0;
    }
    return _sureButton;
}

- (void)setTaskRowsItemArray:(NSMutableArray<XFJTaskRowsItem *> *)taskRowsItemArray
{
    _taskRowsItemArray = taskRowsItemArray;
    NSLog(@"在这里打印的cell的个数是 :%zd",[taskRowsItemArray count]);
}

- (UITableView *)visitMessage_tableView
{
    if (_visitMessage_tableView == nil) {
        _visitMessage_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 150) style:UITableViewStylePlain];
        _visitMessage_tableView.delegate = self;
        _visitMessage_tableView.dataSource = self;
        _visitMessage_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _visitMessage_tableView.backgroundColor = [UIColor clearColor];
    }
    return _visitMessage_tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayTask count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *const cellID = @"cellID";
    XFJTeamMessageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[XFJTeamMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.taskRowsItem = self.arrayTask[indexPath.row];
    NSLog(@"这里打印到的景点信息是:%@",self.arrayTask[indexPath.row]);
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62.0;
}

@end
