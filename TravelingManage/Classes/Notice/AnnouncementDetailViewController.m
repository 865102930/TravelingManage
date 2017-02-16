//
//  AnnouncementDetailViewController.m
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/13.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "AnnouncementDetailViewController.h"
#import "AnnouncementDetailModel.h"
#import "AnnouncementDetailCell.h"
#define navBarHeight 64
@interface AnnouncementDetailViewController ()
@property (nonatomic, strong) UILabel *title_label;
@end

@implementation AnnouncementDetailViewController
- (UILabel *)title_label {
    if (_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.XFJ_centerX, 6, 100, 44)];
        _title_label.text = @"公告详情";
        _title_label.textColor = kColor6565;
        _title_label.textAlignment = NSTextAlignmentCenter;
    }
    return _title_label;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackgroudColor;
    self.navigationItem.titleView = self.title_label;
    self.tableView.tableFooterView = [UITableView new];
    self.tableView.separatorStyle = NO;
    [self loadData];
}

- (void)loadData{
    NSString *Id = [NSString stringWithFormat:@"%ld", (long)self.Id];
    NSDictionary *parameters = @{
                                 @"Id" : Id
    };
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:ANNOUNCEMENT parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        NSArray *dictArr = responseObject[@"object"];
        _announcementDetailModel = [AnnouncementDetailModel mj_objectWithKeyValues:dictArr];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == NSURLErrorCancelled) return;
        
    }];
}


#pragma mark   ----------tableViewDelegate datasource----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnnouncementDetailCell *cell = [AnnouncementDetailCell initWithTableView:tableView];
    cell.titleLabel.text = self.announcementDetailModel.announcementTitle;
    cell.timeLabel.text = self.announcementDetailModel.createtime;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.conentLabe.text = self.announcementDetailModel.announcementDetail;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.announcementDetailModel.cellHeight;
}

@end
