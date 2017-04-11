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
#import "XFJFindTeamTasksItem.h"
#import "XFJTaskRowsItem.h"
#import "HomeViewController.h"
#import "JTNavigationController.h"
#import "XFJMineTeamViewController.h"

@interface XFJPleaseAppraiseViewController () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableDictionary *dictionary;
    NSMutableSet *set;
}

@property (nonatomic, strong) UILabel *title_label;
@property (nonatomic, strong) UIScrollView *assessmentScroll_view;
@property (nonatomic, strong) XFJAssessmentTeamTopView *assessmentTeamTopView;
@property (nonatomic, strong) XFJOpinionAndSuggestView *opinionAndSuggestView;
@property (nonatomic, strong) XFJCommitView *commitView;
@property (nonatomic, strong) UITableView *signAppraise_tableView;
@property (nonatomic, strong) NSMutableArray <XFJFindTeamTasksItem *> *findTeamTasksItem;
@property (nonatomic, strong) NSMutableArray <XFJTaskRowsItem *> *TaskRowsItemArray;
//接收传递过来的分数值
@property (nonatomic, assign) NSInteger teamScore;
//接收传递过来的输入框参数值
@property (nonatomic, strong) NSString *commit_text;
//分数1
@property (nonatomic, assign) NSInteger teamScore1;
//分数2
@property (nonatomic, assign) NSInteger teamScore2;
//分数3
@property (nonatomic, assign) NSInteger teamScore3;
//景区id
@property (nonatomic, assign) NSInteger attractionsId;
@property (nonatomic, strong) NSMutableArray *totalStarArray;

/**  */
@property (nonatomic, strong) NSMutableArray *starDataArray;
@property (nonatomic, strong) NSMutableDictionary *starsDict;
@end

@implementation XFJPleaseAppraiseViewController

#pragma mark - starDataArray
- (NSMutableArray *)starDataArray
{
    if (nil == _starDataArray) {
        _starDataArray = [NSMutableArray array];
    }
    return _starDataArray;
}
- (NSMutableDictionary *)starsDict
{
    if (nil == _starsDict) {
        _starsDict = [NSMutableDictionary dictionary];
    }
    return _starsDict;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //获取景区名字的接口调用
    [self requestWithTeamForNname];
    [self setInitWithNav];
    
    dictionary = [NSMutableDictionary dictionary];
    set = [NSMutableSet set];
    
}



- (void)requestWithTeamForNname
{
    NSDictionary *dictParams = @{
                                 @"id":[NSString stringWithFormat:@"%zd",self.teamId]
                                 };
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:FINDTEAMINFOTASKSURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSMutableArray *findArray = [responseObject objectForKey:@"rows"];
            wself.findTeamTasksItem = [XFJFindTeamTasksItem mj_objectArrayWithKeyValuesArray:findArray];
            for (NSInteger i = 0;i < findArray.count ; i++) {
                NSDictionary *dict = [findArray[0] objectForKey:@"tasks"];
                wself.TaskRowsItemArray = [XFJTaskRowsItem mj_objectArrayWithKeyValuesArray:dict];
            }
            [wself.signAppraise_tableView reloadData];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"---------+++++++++没得到后台返回的值,打印错误信息是 :%@",error);
        }
    }];
}

- (NSMutableArray <XFJFindTeamTasksItem *> *)findTeamTasksItem
{
    if (_findTeamTasksItem == nil) {
        _findTeamTasksItem = [NSMutableArray array];
    }
    return _findTeamTasksItem;
}

- (NSMutableArray *)totalStarArray
{
    if (_totalStarArray == nil) {
        _totalStarArray = [NSMutableArray array];
    }
    return _totalStarArray;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.assessmentScroll_view addSubview:self.commitView];
    [self.commitView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.signAppraise_tableView.mas_bottom);
        make.height.mas_equalTo(100.0);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
    }];
}

- (void)setInitWithNav
{
    self.navigationItem.titleView = self.title_label;
    [self.view addSubview:self.assessmentScroll_view];
    [self.assessmentScroll_view addSubview:self.assessmentTeamTopView];
    [self.assessmentScroll_view addSubview:self.opinionAndSuggestView];
    [self.assessmentScroll_view addSubview:self.signAppraise_tableView];
    __weak __typeof(self)wself = self;
    self.commitView.teamEvaluateBlock = ^() {
        [wself commitEvaluate_buttonClick];
    };
    self.assessmentTeamTopView.commitStarBlock = ^(NSString *startScore){
        wself.teamScore = [startScore intValue];
    };
    self.opinionAndSuggestView.textViewTextBlock = ^(NSString *textView_text) {
        wself.commit_text = textView_text;
    };
}
#pragma mark - 提交评论
- (void)commitEvaluate_buttonClick
{
    NSDictionary *dictParams;
    [self.totalStarArray removeAllObjects];
    if (set.count > 0) {
        NSArray *dataArray = [set allObjects];
        NSDictionary *dictionarys = dataArray[0];
        for (NSString *key in [dictionarys allKeys]) {
            [self.totalStarArray addObject:dictionarys[key]];
            NSLog(@"******%@", self.totalStarArray);
        }
        //转成json格式给服务器发送
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.totalStarArray options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        dictParams = @{
                                     @"teamId":[NSString stringWithFormat:@"%zd",self.teamId],
                                     @"teamScore":[NSString stringWithFormat:@"%zd",self.teamScore],//团队评分
                                     @"teamComment":[NSString stringWithFormat:@"%@",self.commit_text],//团队评论
                                     @"attrJson":jsonString//设施设备
                                     };
    } else {
        for (XFJTaskRowsItem *item in self.TaskRowsItemArray) {
            NSDictionary *dict = @{
                                   @"teamId":[NSString stringWithFormat:@"%zd",self.teamId],//团队id
                                   @"attractionsId":[NSString stringWithFormat:@"%zd",item.attractionsId],
                                   @"ssScore":@10,//景区服务
                                   @"ehScore":@10,//环境卫生
                                   @"feScore":@10 //设施设备
                                   };
            [self.totalStarArray addObject:dict];
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.totalStarArray options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            dictParams = @{
                           @"teamId":[NSString stringWithFormat:@"%zd",self.teamId],
                           @"teamScore":@5,//团队评分
                           @"teamComment":[NSString stringWithFormat:@"%@",self.commit_text],//团队评论
                           @"attrJson":jsonString//设施设备
                           };
            NSLog(@"+++++++++打印的提交评论时候的参数值是 :%@",dictParams);
        }
    }
    __weak __typeof(self)wself = self;
    NSLog(@"+++++++++>>>>>>>>>>打印的评论的提交参数是 :%@",dictParams);
    [GRNetRequestClass POST:EVALUATEURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            [MBProgressHUD showHudTipStr:@"评论成功!" contentColor:HidWithColorContentBlack];
            XFJMineTeamViewController *mineTeamViewController = [[XFJMineTeamViewController alloc] init];
            //发送通知刷新标题和评论列表
            [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESHCOMMENTNSNOTICA" object:nil];
            mineTeamViewController.strNumber = 4;
            [wself.navigationController popViewControllerAnimated:YES];
        }else {
            [MBProgressHUD showHudTipStr:@"评论失败!" contentColor:HidWithColorContentBlack];
            return ;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            [MBProgressHUD showHudTipStr:@"评论失败,可能是网络问题!" contentColor:HidWithColorContentBlack];
        }
    }];
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
        _assessmentScroll_view.contentSize = CGSizeMake(0, self.view.XFJ_Height * 1.3);
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
        _signAppraise_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 225.0, SCREEN_WIDTH, 0) style:UITableViewStylePlain];
        _signAppraise_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _signAppraise_tableView.delegate = self;
        _signAppraise_tableView.dataSource = self;
    }
    return _signAppraise_tableView;
}

- (XFJCommitView *)commitView
{
    if (_commitView == nil) {
        _commitView = [[XFJCommitView alloc] init];
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
    return [self.TaskRowsItemArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const cellID = @"cellID";
    XFJSignAppraiseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[XFJSignAppraiseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    __weak __typeof(self)wself = self;
    cell.teamScoreBlock1 = ^(NSString *scoreText1,NSInteger attractionsId1) {
        wself.teamScore1 = [scoreText1 intValue];
        wself.attractionsId = attractionsId1;
        [dic setValue:[NSString stringWithFormat:@"%ld", wself.teamScore1] forKey:@"scoreText1"];
        [dictionary setValue:dic forKey:[NSString stringWithFormat:@"%ld", wself.attractionsId]];
        if ([dic objectForKey:@"scoreText1"] != nil && [dic objectForKey:@"scoreText2"] != nil && [dic objectForKey:@"scoreText3"] != nil) {
            [self dictionaryParams];
        }
    };
    
    cell.teamScoreBlock2 = ^(NSString *scoreText2,NSInteger attractionsId2) {
        wself.teamScore2 = [scoreText2 intValue];
        wself.attractionsId = attractionsId2;
        [dic setValue:[NSString stringWithFormat:@"%ld", wself.teamScore2] forKey:@"scoreText2"];
        [dictionary setValue:dic forKey:[NSString stringWithFormat:@"%ld", wself.attractionsId]];
        if ([dic objectForKey:@"scoreText1"] != nil && [dic objectForKey:@"scoreText2"] != nil && [dic objectForKey:@"scoreText3"] != nil) {
            [self dictionaryParams];
        }
    };
    
    cell.teamScoreBlock3 = ^(NSString *scoreText3,NSInteger attractionsId3) {
        wself.teamScore3 = [scoreText3 intValue];
        wself.attractionsId = attractionsId3;
        [dic setValue:[NSString stringWithFormat:@"%ld", wself.teamScore3] forKey:@"scoreText3"];
        [dictionary setValue:dic forKey:[NSString stringWithFormat:@"%ld", wself.attractionsId]];
        if ([dic objectForKey:@"scoreText1"] != nil && [dic objectForKey:@"scoreText2"] != nil && [dic objectForKey:@"scoreText3"] != nil) {
            [self dictionaryParams];
        }
    };

    cell.findTeamTasksItemArray = self.TaskRowsItemArray[indexPath.row];
    return cell;
}

- (void)dictionaryParams
{
    NSDictionary *dict = @{
                           @"teamId":[NSString stringWithFormat:@"%zd",self.teamId],//团队id
                           @"attractionsId":[NSString stringWithFormat:@"%zd",self.attractionsId],//景区id
                           @"ssScore":[NSString stringWithFormat:@"%zd",self.teamScore1],//景区服务
                           @"ehScore":[NSString stringWithFormat:@"%zd",self.teamScore2],//环境卫生
                           @"feScore":[NSString stringWithFormat:@"%zd",self.teamScore3] //设施设备
                           };
    [dictionary setValue:dict forKey:[NSString stringWithFormat:@"%ld", self.attractionsId]];
    [set addObject:dictionary];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.signAppraise_tableView.frame = CGRectMake(0, 225.0, SCREEN_WIDTH, [self.TaskRowsItemArray count] * 180);
    self.assessmentScroll_view.contentSize = CGSizeMake(0, [self.TaskRowsItemArray count] * 350);
    return 180.0;
}






@end
