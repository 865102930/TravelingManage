//
//  XFJAnnouncementViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/10.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJAnnouncementViewController.h"
#import "AnnouncementDetailViewController.h"
#import "PageButton.h"
#import "AnnouncementModel.h"
#import "AnnouncementCell.h"

@interface XFJAnnouncementViewController ()
@property (nonatomic, strong) NSMutableArray<AnnouncementModel *> *announcementModels;
@end

@implementation XFJAnnouncementViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = BackgroudColor;
    self.tableView.contentInset = UIEdgeInsetsMake(67, 0, 48, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = NO;
    [self loadData];
}

//加载数据
//- (void)loadData{
//    [[NetWorkManager shareManager] requestWithType:HttpRequestTypePost withUrlString:ANNOUNCEMENTLIST withParaments:nil withSuccessBlock:^(id object) {
//        NSMutableArray *dictArr = object[@"rows"];
//        NSLog(@"%@",dictArr);
////        _announcementModel = [AnnouncementModel mj_objectArrayWithKeyValuesArray:dictArr];
//        
//    } withFailureBlock:^(NSError *error) {
//        
//    } progress:^(float progress) {
//        
//    }];
//}

- (void)loadData{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:ANNOUNCEMENTLIST parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
      
        NSArray *dictArr = responseObject[@"rows"];
        _announcementModels = [AnnouncementModel mj_objectArrayWithKeyValuesArray:dictArr];
        [self.tableView reloadData];
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == NSURLErrorCancelled) return;
        
    }];
}


#pragma mark   ----------tableViewDelegate datasource----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.announcementModels.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnnouncementCell *cell = [AnnouncementCell initWithTableView:tableView];
    cell.indexPath = indexPath;
    AnnouncementModel * model = self.announcementModels[indexPath.row];
    cell.titleLabel.text = model.announcementTitle;
    cell.timeLabel.text = model.createtime;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentLabel.text = model.announcementDetail;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cell.contentLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [cell.contentLabel.text length])];
    cell.contentLabel.attributedText = attributedString;
    [cell.contentLabel sizeToFit];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnnouncementModel * model = self.announcementModels[indexPath.row];
    AnnouncementDetailViewController *detailVC = [[AnnouncementDetailViewController alloc] init];
    detailVC.Id = model.AnnouncementModel_id;
    [self.navigationController pushViewController:detailVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 165 + 8;
}

@end
