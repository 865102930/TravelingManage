//
//  XFJPleaseAppraiseViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/6.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

//跳转到评价控制器

#import "XFJPleaseAppraiseViewController.h"
#import "XFJAssessmentTeamTopView.h"
#import "XFJOpinionAndSuggestView.h"
#import "XFJSignAppraiseTableViewCell.h"
#import "XFJCommitView.h"

@interface XFJPleaseAppraiseViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *title_label;
@property (nonatomic, strong) UIScrollView *assessmentScroll_view;
@property (nonatomic, strong) XFJAssessmentTeamTopView *assessmentTeamTopView;
@property (nonatomic, strong) XFJOpinionAndSuggestView *opinionAndSuggestView;
@property (nonatomic, strong) XFJCommitView *commitView;
@property (nonatomic, strong) UITableView *signAppraise_tableView;

@end

@implementation XFJPleaseAppraiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setInitWithNav];
}

- (void)setInitWithNav
{
    self.navigationItem.titleView = self.title_label;
    [self.view addSubview:self.assessmentScroll_view];
    [self.assessmentScroll_view addSubview:self.assessmentTeamTopView];
    [self.assessmentScroll_view addSubview:self.opinionAndSuggestView];
    [self.assessmentScroll_view addSubview:self.signAppraise_tableView];
    [self.assessmentScroll_view addSubview:self.commitView];
}

- (UILabel *)title_label
{
    if (_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.XFJ_centerX, 6, 100, 44)];
        _title_label.text = @"对此次带团的评价";
        _title_label.textColor = kColor6565;
        _title_label.textAlignment = NSTextAlignmentCenter;
    }
    return _title_label;
}

- (UIScrollView *)assessmentScroll_view
{
    if (_assessmentScroll_view == nil) {
        _assessmentScroll_view = [[UIScrollView alloc] init];
        _assessmentScroll_view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 1.2 * self.view.XFJ_Height);
        _assessmentScroll_view.contentSize = CGSizeMake(0, self.view.XFJ_Height * 2.5);
        _assessmentScroll_view.backgroundColor = kColoreeee;
        _assessmentScroll_view.showsHorizontalScrollIndicator = NO;
        _assessmentScroll_view.scrollEnabled = YES;
    }
    return _assessmentScroll_view;
}

- (XFJAssessmentTeamTopView *)assessmentTeamTopView
{
    if (_assessmentTeamTopView == nil) {
        _assessmentTeamTopView = [[XFJAssessmentTeamTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45.0)];
        _assessmentTeamTopView.backgroundColor = [UIColor whiteColor];
    }
    return _assessmentTeamTopView;
}

- (XFJOpinionAndSuggestView *)opinionAndSuggestView
{
    if (_opinionAndSuggestView == nil) {
        _opinionAndSuggestView = [[XFJOpinionAndSuggestView alloc] initWithFrame:CGRectMake(0, 45.0, SCREEN_WIDTH, 180.0)];
        _opinionAndSuggestView.backgroundColor = [UIColor whiteColor];
    }
    return _opinionAndSuggestView;
}

- (UITableView *)signAppraise_tableView
{
    if (_signAppraise_tableView == nil) {
        _signAppraise_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 225.0, SCREEN_WIDTH, 350) style:UITableViewStylePlain];
        _signAppraise_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _signAppraise_tableView.delegate = self;
        _signAppraise_tableView.dataSource = self;
    }
    return _signAppraise_tableView;
}

- (XFJCommitView *)commitView
{
    if (_commitView == nil) {
        _commitView = [[XFJCommitView alloc] initWithFrame:CGRectMake(0, self.signAppraise_tableView.XFJ_Height + 225, SCREEN_WIDTH, 100)];
        _commitView.backgroundColor = [UIColor whiteColor];
    }
    return _commitView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const cellID = @"cellID";
    XFJSignAppraiseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[XFJSignAppraiseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180.0;
}





@end
