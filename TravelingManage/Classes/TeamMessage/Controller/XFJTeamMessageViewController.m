//
//  XFJTeamMessageViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/4.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJTeamMessageViewController.h"
#import "XFJPleasePerfectView.h"
#import "XFJGeneralMessageView.h"
#import "XFJOtherMessagePerfectView.h"
#import "XFJCarPhotosWithPerfectView.h"
#import "TZImagePickerController.h"
#import "WSImagePickerView.h"
#import "WSPhotosBroseVC.h"
#import "XFJUpPhotosOpenTeamMessageView.h"
#import "XFJTeamMessageBottomView.h"
#import "XFJFindTeamTasksItem.h"
#import "XFJTaskRowsItem.h"
#import "XFJPleasePerfectMessageViewController.h"
#import "XFJPleaseAppraiseViewController.h"
#import "XFJFindCustomAttrListItem.h"
#import "XFJFirestAttributeTableViewCell.h"
#import "XFJSecondAttributeTableViewCell.h"
#import "XFJThirdAttributeTableViewCell.h"
#import "XFJFourAttributeTableViewCell.h"
#import "XFJFiveAttributeTableViewCell.h"
#import "XFJSixAttributeTableViewCell.h"
#import "XFJSevenTableViewCell.h"
#import "XFJEigthAttributeTableViewCell.h"
#import "XFJMaskView.h"
#import "XFJCheckBoxView.h"
#import "XFJMineTeamViewController.h"
#import "XFJSignMessageViewController.h"
#import "XFJFindTeamCarItem.h"
#import "XFJFindTeamCarImageItem.h"
#import "XFJTeamMessageTableViewCell.h"

#import "SingleListTableViewCell.h"
#import "FindTeamTaskModel.h"
#import "SingleListModel.h"
#import "MulitSelectTableViewCell.h"
#import "DropDownTableViewCell.h"
#import "XFJTaskRowsItem.h"

@interface XFJTeamMessageViewController () <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,XFJCarPhotosWithPerfectViewDelegate,XFJUpPhotosOpenTeamMessageViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    CGSize size;
    CGSize messageSize;
    UITableViewHeaderFooterView *footerView;// 第一分区区尾
    UITableViewHeaderFooterView *sectionOneHeader;// 第二分区区头
    NSIndexPath *singIndex;
    NSIndexPath *mulitIndex;
    NSIndexPath *dropIndex;
    BOOL isSelect;
    XFJFourAttributeTableViewCell *attributeCell;
    XFJFiveAttributeTableViewCell *fiveCell;
    XFJEigthAttributeTableViewCell *mulit_SelectCell;
    UIButton *sureButton;
    UIButton *sureAction;
    UIButton *dropDownButton;
    XFJTeamMessageTableViewCell *teamMessageCell;
}

@property (nonatomic, strong) UILabel *title_label;
@property (nonatomic, strong) UIScrollView *scroll_view;
@property (nonatomic, strong) XFJPleasePerfectView *pleasePerfectView;
@property (nonatomic, strong) XFJGeneralMessageView *generalMessageView;
@property (nonatomic, strong) XFJOtherMessagePerfectView *otherMessagePerfectView;
@property (nonatomic, strong) XFJCarPhotosWithPerfectView *carPhotosWithPerfectView;
@property (nonatomic, strong) XFJUpPhotosOpenTeamMessageView *upPhotosOpenTeamMessageView;
@property (nonatomic, strong) XFJTeamMessageBottomView *teamMessageBottomView;
@property (nonatomic, assign) NSInteger maxImageCount;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray <XFJFindTeamTasksItem *> *findTeamTasksItemArray;
@property (nonatomic, strong) NSMutableArray <XFJTaskRowsItem *> *taskRowsArray;
//自定义字段文本的内容
@property (nonatomic, strong) NSMutableArray <XFJFindCustomAttrListItem *> *findCustomAttrListItemArray;
//自定义属性
@property (nonatomic, strong) UITableView *attrList_tableView;
@property (nonatomic, strong) UIView *backGround_view;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSMutableArray *attrTypeArray;
@property (nonatomic, strong) XFJMaskView *maskView1;
@property (nonatomic, strong) XFJCheckBoxView *checkBoxView;
@property (nonatomic, strong) NSMutableArray *allBackArray;
@property (nonatomic, strong) NSMutableArray *allRootImage;
@property (nonatomic, strong) NSString *root;
@property (nonatomic, strong) NSString *voucherPicRoot;
@property (nonatomic, assign) NSInteger teamId;
//这个用来装所有的自定义信息的集合
@property (nonatomic, strong) NSMutableArray *allAttribute_array;
@property (nonatomic, strong) NSString *AttributeStr;
@property (nonatomic, strong) NSMutableArray <XFJFindTeamCarItem *> *findTeamCarItem_array;
@property (nonatomic, strong) NSMutableArray <XFJFindTeamCarImageItem *> *findTeamCarImageItem_array;
@property (nonatomic, strong) NSMutableArray *image_array;

@property (nonatomic, strong) NSMutableSet *dataSet;// 存储id
@property (nonatomic, strong) NSMutableArray *dataSource;// 过渡数组
@property (nonatomic, strong) NSArray *sectionArray;// 内嵌的tableView的分区数组
@property (nonatomic, strong) NSMutableArray *teamTaskArray;//内嵌的tableView的数据源数组
@property (nonatomic, strong) UITableView *backgroundTableView;// 底层的tableView
@property (nonatomic, strong) UITableViewHeaderFooterView *headerView;

@property (nonatomic, strong) UITableView *visitMessage_tableView; // 签到tableView
@property (nonatomic, strong) NSMutableArray <XFJFindTeamTasksItem *> *arrayTask;
@property (nonatomic, strong) NSMutableArray <XFJTaskRowsItem *> *TaskRowsItemArray;

@property (nonatomic, strong) UIView *singleChooseView;// 单选框
@property (nonatomic, strong) UITableView *singleTableView;// 单选框TableView
@property (nonatomic, strong) NSMutableArray *singleDatasource;

@property (nonatomic, strong) UIView *dropView;//下拉框
@property (nonatomic, strong) UITableView *dropTableView;//下拉框TableView

@property (nonatomic, strong) UIView *multi_SelectView;// 多选
@property (nonatomic, strong) UITableView *mulit_SelectTableView;// 多选的tableview

@property (nonatomic, strong) NSMutableDictionary *jsonDataSourceDic;
@property (nonatomic, strong) NSMutableSet *indexSet;
@property (nonatomic, strong) NSMutableArray *indexArray;
@property (nonatomic, strong) NSMutableArray *carPhotoArray;// 存放车辆图片上传之后的数据(图片URL)
@property (nonatomic, copy) NSString *picStr;

@property (nonatomic, strong) NSMutableArray *certificatePicArray;// 存放车辆图片上传之后的数据(图片URL)
@property (nonatomic, copy) NSString *certificateStr;
@property (nonatomic, copy) NSString *mulitStr;
@property (nonatomic, strong) NSArray *pictureArr;
@property (nonatomic, strong) NSMutableDictionary *isRequireDic;
@property (nonatomic, strong) NSMutableSet *keyArray;
@property (nonatomic, strong) NSMutableArray *cachePicArray;
@property (nonatomic, strong) NSMutableDictionary *imgPathDic;

@end

@implementation XFJTeamMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isSelect = NO;
    [self creatTableViewUI]; // 底层的视图
    self.dataSet = [NSMutableSet set];
    self.dataSource = [NSMutableArray array];
    self.sectionArray = [NSArray array];
    self.teamTaskArray = [NSMutableArray array];
    self.arrayTask = [NSMutableArray array];
    self.TaskRowsItemArray = [NSMutableArray array];
    self.singleDatasource = [NSMutableArray array];
    self.jsonDataSourceDic = [NSMutableDictionary dictionary];
    self.indexSet = [NSMutableSet set];
    self.indexArray = [NSMutableArray array];
    self.carPhotoArray = [NSMutableArray array];
    self.certificatePicArray = [NSMutableArray array];
    self.isRequireDic = [NSMutableDictionary dictionary];
    self.keyArray = [NSMutableSet set];
    self.cachePicArray = [NSMutableArray array];
    [self setInitWithNav];
    [self.backGround_view addSubview:self.carPhotosWithPerfectView];
    [self.backGround_view addSubview:self.upPhotosOpenTeamMessageView];
    self.imgPathDic = [NSMutableDictionary dictionary];
    
    
    //请求到的自定页面数据
    [self requestTeamMessage];
    
    //获取团队的车牌号
    [self requestCertificateImgWithTeamId];
    
    //获取车牌照片
    [self requestCarImageViewWithTeamId];
    
    // 获取签到点信息
    [self setFindTeamInfoByState_Id:self.findTeamInfoByState_Id];
    
    //请求自定义字段数据
    [self requestFindCustomAttrListMessage:self.findTeamInfoByState_Id];
    
    __weak __typeof(self)wself = self;
    self.checkBoxView.chooseCheckBoxBlock = ^(NSString *resultStr) {
        [wself.checkBoxView removeFromSuperview];
        [wself.maskView1 removeFromSuperview];
        wself.AttributeStr = resultStr;
        
        [wself.attrList_tableView reloadData];
    };
    self.checkBoxView.cancelMaskviewBlock = ^() {
        [wself.checkBoxView removeFromSuperview];
        [wself.maskView1 removeFromSuperview];
    };
    self.maskView1.maskBlock = ^() {
        [wself.maskView1 removeFromSuperview];
    };
    
    [self.attrList_tableView registerClass:[XFJFirestAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJFirestAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJSecondAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJSecondAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJThirdAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJThirdAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJFourAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJFourAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJFiveAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJFiveAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJSixAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJSixAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJSevenTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJSevenTableViewCell];
    [self.attrList_tableView registerClass:[XFJEigthAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJEigthAttributeTableViewCell];
}

// 创建最底层视图的UI
- (void)creatTableViewUI{
    self.backgroundTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [self.backgroundTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"backgroundCell"];
    sectionOneHeader = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"sectionOneHeader"];
    self.backgroundTableView.scrollEnabled = YES;
    self.backgroundTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundTableView.tableHeaderView = self.generalMessageView;
    self.backgroundTableView.delegate = self;
    self.backgroundTableView.dataSource = self;
    [self.view addSubview:self.backgroundTableView];
    
    self.singleChooseView = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x - 150, self.view.center.y - 80, 300, 160)];
    self.singleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.singleChooseView.frame), CGRectGetHeight(self.singleChooseView.frame)) style:UITableViewStylePlain];
    self.singleTableView.delegate = self;
    self.singleTableView.dataSource = self;
    [self.singleTableView registerClass:[SingleListTableViewCell class] forCellReuseIdentifier:@"singleCell"];
    
    self.multi_SelectView = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x - 150, self.view.center.y - 80, 300, 160)];
    self.mulit_SelectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.multi_SelectView.frame), CGRectGetHeight(self.multi_SelectView.frame)) style:UITableViewStylePlain];
    self.mulit_SelectTableView.delegate = self;
    self.mulit_SelectTableView.dataSource = self;
    [self.mulit_SelectTableView registerClass:[MulitSelectTableViewCell class] forCellReuseIdentifier:@"mulit_selectCell"];
    
    self.dropView = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x - 150, self.view.center.y - 80, 300, 160)];
    self.dropTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.multi_SelectView.frame), CGRectGetHeight(self.multi_SelectView.frame)) style:UITableViewStylePlain];
    self.dropTableView.delegate = self;
    self.dropTableView.dataSource = self;
    [self.dropTableView registerClass:[DropDownTableViewCell class] forCellReuseIdentifier:@"dropCell"];
    
    UIView *mulit_selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.multi_SelectView.frame), 60)];
    sureAction = [UIButton buttonWithType:UIButtonTypeCustom];
    sureAction.frame = CGRectMake(30, 20, CGRectGetWidth(mulit_selectView.frame) - 60, 20);
    [sureAction setTitle:@"确定" forState:UIControlStateNormal];
    sureAction.backgroundColor = [UIColor redColor];
    [sureAction setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureAction addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    sureAction.tag = 10000;
    [mulit_selectView addSubview:sureAction];
    self.mulit_SelectTableView.tableFooterView = mulit_selectView;
    [self.multi_SelectView addSubview:self.mulit_SelectTableView];
    
    
    UIView *singleListView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.singleChooseView.frame), 60)];
    sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(30, 20, CGRectGetWidth(singleListView.frame) - 60, 20);
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.backgroundColor = [UIColor redColor];
    sureButton.userInteractionEnabled = NO;
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [singleListView addSubview:sureButton];
    self.singleTableView.tableFooterView = singleListView;
    [self.singleChooseView addSubview:self.singleTableView];
    
    // 下拉
    UIView *dropDownView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.multi_SelectView.frame), 60)];
    dropDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dropDownButton.frame = CGRectMake(30, 20, CGRectGetWidth(dropDownView.frame) - 60, 20);
    [dropDownButton setTitle:@"确定" forState:UIControlStateNormal];
    dropDownButton.userInteractionEnabled = NO;
    dropDownButton.backgroundColor = [UIColor redColor];
    [dropDownButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dropDownButton addTarget:self action:@selector(dropAction:) forControlEvents:UIControlEventTouchUpInside];
    [dropDownView addSubview:dropDownButton];
    self.dropTableView.tableFooterView = dropDownView;
    [self.dropView addSubview:self.dropTableView];
    
    
    self.visitMessage_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) style:UITableViewStylePlain];
    self.visitMessage_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.visitMessage_tableView.scrollEnabled = NO;
    self.visitMessage_tableView.delegate = self;
    self.visitMessage_tableView.dataSource = self;
    UIView *signFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.layer.masksToBounds = YES;
    commitButton.layer.cornerRadius = 3;
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(clickCommitButton:) forControlEvents:UIControlEventTouchUpInside];
    commitButton.backgroundColor = [UIColor redColor];
    commitButton.frame = CGRectMake(20, 10, SCREEN_WIDTH - 40, 42);
    [signFooterView addSubview:commitButton];
    signFooterView.backgroundColor = kColoreeee;
    self.backgroundTableView.tableFooterView = signFooterView;
    [self.visitMessage_tableView registerClass:[XFJTeamMessageTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJTeamMessageTableViewCell];
    
}

- (void)setFindTeamInfoByState_Id:(NSInteger)findTeamInfoByState_Id
{
    _findTeamInfoByState_Id = findTeamInfoByState_Id;
    NSDictionary *dictParams = @{
                                 @"id":[NSString stringWithFormat:@"%zd",findTeamInfoByState_Id]
                                 };
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:FINDTEAMINFOTASKSURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSMutableArray *findArray = [responseObject objectForKey:@"rows"];
            wself.arrayTask = [XFJFindTeamTasksItem mj_objectArrayWithKeyValuesArray:findArray];
            for (NSInteger i = 0;i < findArray.count ; i++) {
                NSDictionary *dict = [findArray[0] objectForKey:@"tasks"];
                self.TaskRowsItemArray = [XFJTaskRowsItem mj_objectArrayWithKeyValuesArray:dict];
            }
            [wself.visitMessage_tableView reloadData];
            [self.backgroundTableView reloadData];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"++++++++获取团队信息资料失败的是 :%@",error);
        }
    }];
}


#pragma mark - 单选框的数据获取

- (void)requestGetfindParamDataWithStr:(NSString *)backStr {
    [GRNetRequestClass POST:FINDPARAMSSYSTEMLISTURL params:@{@"types":backStr} success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.singleDatasource removeAllObjects];
        [self.indexArray removeAllObjects];
        NSArray *rowsArray = responseObject[@"rows"];
        for (NSDictionary *dic in rowsArray) {
            SingleListModel *model = [[SingleListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            model.singleId = dic[@"id"];
            [self.singleDatasource addObject:model];
        }
        [self.singleTableView reloadData];
        [self.backgroundTableView reloadData];
        [self.mulit_SelectTableView reloadData];
        [self.dropTableView reloadData];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}


- (NSMutableArray *)allRootImage
{
    if (_allRootImage == nil) {
        _allRootImage = [NSMutableArray array];
    }
    return _allRootImage;
}

- (NSMutableArray *)allAttribute_array
{
    if (_allAttribute_array == nil) {
        _allAttribute_array = [NSMutableArray array];
    }
    return _allAttribute_array;
}

- (NSMutableArray <XFJFindTeamCarItem *> *)findTeamCarItem_array
{
    if (_findTeamCarItem_array == nil) {
        _findTeamCarItem_array = [NSMutableArray array];
    }
    return _findTeamCarItem_array;
}

- (NSMutableArray *)image_array
{
    if (_image_array == nil) {
        _image_array = [NSMutableArray array];
    }
    return _image_array;
}

- (NSMutableArray <XFJFindTeamCarImageItem *> *)findTeamCarImageItem_array
{
    if (_findTeamCarImageItem_array == nil) {
        _findTeamCarImageItem_array = [NSMutableArray array];
    }
    return _findTeamCarImageItem_array;
}


- (NSMutableArray <XFJFindCustomAttrListItem *> *)findCustomAttrListItemArray
{
    if (_findCustomAttrListItemArray == nil) {
        _findCustomAttrListItemArray = [NSMutableArray array];
    }
    return _findCustomAttrListItemArray;
}

- (XFJCheckBoxView *)checkBoxView
{
    if (_checkBoxView == nil) {
        _checkBoxView = [[XFJCheckBoxView alloc] initWithFrame:CGRectMake(50, 150, SCREEN_WIDTH - 2 * 50, SCREEN_HEIGHT - 2 * 150)];
        _checkBoxView.layer.borderWidth = 0.5;
        _checkBoxView.layer.cornerRadius = 8.0;
        _checkBoxView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _checkBoxView;
}

- (NSMutableArray *)allBackArray
{
    if (_allBackArray == nil) {
        _allBackArray = [NSMutableArray array];
    }
    return _allBackArray;
}

- (XFJMaskView *)maskView1
{
    if (_maskView1 == nil) {
        _maskView1 = [[XFJMaskView alloc] initWithFrame:CGRectZero];
    }
    return _maskView1;
}


#pragma mark - 确认提交和上传附件
- (void)sureAndCommitShow:(NSInteger)teamId
{
    UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"提交完成!\n欢迎对本次带团进行评价!" preferredStyle:UIAlertControllerStyleAlert];
    __weak __typeof(self)wself = self;
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
        [wself.navigationController popViewControllerAnimated:YES];
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"立即评价" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [wself jumpPleaseAppraise:teamId];
    }]];
    [self presentViewController:alertVc animated:NO completion:nil];
}

- (UIView *)backGround_view
{
    if (_backGround_view == nil) {
        _backGround_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 420)];
        _backGround_view.backgroundColor = [UIColor whiteColor];
    }
    return _backGround_view;
}

#pragma mark - 跳转到完善资料的控制器
- (void)jumpPleasePerfectMessage:(NSInteger)teamId
{
    XFJPleasePerfectMessageViewController *pleasePerfectMessageViewController = [[XFJPleasePerfectMessageViewController alloc] init];
    pleasePerfectMessageViewController.teamId = teamId;
    [self.navigationController pushViewController:pleasePerfectMessageViewController animated:YES];
}
#pragma mark - 跳转到立即评价控制器
- (void)jumpPleaseAppraise:(NSInteger)teamId
{
    XFJPleaseAppraiseViewController *pleaseAppraiseViewController = [[XFJPleaseAppraiseViewController alloc] init];
    pleaseAppraiseViewController.teamId = teamId;
    [self.navigationController pushViewController:pleaseAppraiseViewController animated:YES];
}

- (void)setInitWithNav
{
    self.navigationItem.titleView = self.title_label;
}

- (UILabel *)title_label
{
    if (_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.XFJ_centerX, 6, 100, 44)];
        _title_label.text = @"待完善";
        _title_label.textColor = kColor6565;
        _title_label.textAlignment = NSTextAlignmentCenter;
    }
    return _title_label;
}

- (UITableView *)attrList_tableView
{
    if (_attrList_tableView == nil) {
        _attrList_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) style:UITableViewStylePlain];
        [self.attrList_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _attrList_tableView.tableHeaderView = self.otherMessagePerfectView;
        _attrList_tableView.scrollEnabled = NO;
        _attrList_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _attrList_tableView.delegate = self;
        _attrList_tableView.dataSource = self;
        _attrList_tableView.bounces = NO;
    }
    return _attrList_tableView;
}

- (NSMutableArray <XFJFindTeamTasksItem *> *)findTeamTasksItemArray
{
    if (_findTeamTasksItemArray == nil) {
        _findTeamTasksItemArray = [NSMutableArray array];
    }
    return _findTeamTasksItemArray;
}

- (NSMutableArray <XFJTaskRowsItem *> *)taskRowsArray
{
    if (_taskRowsArray == nil) {
        _taskRowsArray = [NSMutableArray array];
    }
    return _taskRowsArray;
}

- (void)requestTeamMessage
{
    NSDictionary *dictParams = @{
                                 @"id":[NSString stringWithFormat:@"%zd",self.findTeamInfoByState_Id]
                                 };
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:FINDTEAMINFOTASKSURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSMutableArray *findArray = [responseObject objectForKey:@"rows"];
            wself.generalMessageView.findTeamTasksItem = [XFJFindTeamTasksItem mj_objectArrayWithKeyValuesArray:findArray];
            if ([XFJFindTeamTasksItem mj_objectArrayWithKeyValuesArray:findArray].count == 0) {
                return ;
            }else {
                [wself.image_array addObject:wself.generalMessageView.findTeamTasksItem[0].certificateImg];
            }
            wself.upPhotosOpenTeamMessageView.imageView_array = wself.image_array;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"++++++++获取团队信息资料失败的是 :%@",error);
        }
    }];
}

#pragma mark - 凭证图片查询
- (void)requestCertificateImgWithTeamId
{
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:FINDTEAMVEHICLESURL params:@{@"teamId":[NSString stringWithFormat:@"%zd",self.findTeamInfoByState_Id]} success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            wself.generalMessageView.findTeamCarItem = [XFJFindTeamCarItem mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"rows"]];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            [MBProgressHUD showHudTipStr:@"网络君错误!" contentColor:HidWithColorContentBlack];
        }
    }];
}

#pragma mark - 车辆图片查询
- (void)requestCarImageViewWithTeamId
{
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:TEAMVEHICLEIMAGESURL params:@{@"teamId":[NSString stringWithFormat:@"%zd",self.findTeamInfoByState_Id]} success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            wself.findTeamCarImageItem_array = [XFJFindTeamCarImageItem mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"rows"]];
            wself.carPhotosWithPerfectView.carImageView_array = wself.findTeamCarImageItem_array;
            wself.dataArr = wself.findTeamCarImageItem_array;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            [MBProgressHUD showHudTipStr:@"网络君错误!" contentColor:HidWithColorContentBlack];
        }
    }];
}

#pragma mark - 加载自定义字段数据
- (void)requestFindCustomAttrListMessage:(NSInteger)teamId
{
    NSDictionary *dictParams = @{
                                 @"teamId":[NSString stringWithFormat:@"%zd",self.findTeamInfoByState_Id],
                                 @"teamAttractionsType":@0
                                 };
    __weak __typeof(self)wself = self;
    [GRNetRequestClass GET:FINDCUSTOMATTRLISTURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSMutableArray *rowsArray = [responseObject objectForKey:@"rows"];
            wself.findCustomAttrListItemArray = [XFJFindCustomAttrListItem mj_objectArrayWithKeyValuesArray:rowsArray];
            for (NSInteger i = 0; i < wself.findCustomAttrListItemArray.count; i++) {
                int attrType = wself.findCustomAttrListItemArray[i].attrType;
                [wself.attrTypeArray addObject:[NSString stringWithFormat:@"%d",attrType]];
            }
            
            if (wself.findCustomAttrListItemArray.count == 0) {
                [wself.otherMessagePerfectView removeFromSuperview];
            }
            
            
            for (NSDictionary *dic in rowsArray) {
                FindTeamTaskModel *model = [[FindTeamTaskModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                model.Uid = dic[@"id"];
                [self.dataSource addObject:model];
                
                NSString *idStr = dic[@"userId"];
                [self.dataSet addObject:idStr];
                self.sectionArray = [self.dataSet allObjects];
            }
            
            for (NSString *keyId in self.sectionArray) {
                NSMutableArray *array = [NSMutableArray array];
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                for (FindTeamTaskModel *model in self.dataSource) {
                    if ([[NSString stringWithFormat:@"%@", keyId] isEqualToString:[NSString stringWithFormat:@"%@", model.userId]]) {
                        [array addObject:model];
                    }
                    [dic setValue:array forKey:keyId];
                }
                [self.teamTaskArray addObject:dic];
            }
            
            [self.backgroundTableView reloadData];
            [wself.attrList_tableView reloadData];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"___________返回错误的信息是 :%@",error);
        }
    }];
}

- (NSMutableArray *)attrTypeArray
{
    if (_attrTypeArray == nil) {
        _attrTypeArray = [NSMutableArray array];
    }
    return _attrTypeArray;
}

- (UIScrollView *)scroll_view
{
    if (_scroll_view == nil) {
        _scroll_view = [[UIScrollView alloc] init];
        _scroll_view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 1.2 * self.view.XFJ_Height);
        if (iphone6P) {
            _scroll_view.contentSize = CGSizeMake(0, self.view.XFJ_Height * 1.7);
        }else if (iphone5) {
            _scroll_view.contentSize = CGSizeMake(0, self.view.XFJ_Height * 2);
        }else {
            _scroll_view.contentSize = CGSizeMake(0, self.view.XFJ_Height * 2);
        }
        _scroll_view.backgroundColor = [UIColor whiteColor];
        _scroll_view.showsHorizontalScrollIndicator = NO;
    }
    return _scroll_view;
}

- (XFJPleasePerfectView *)pleasePerfectView
{
    if (_pleasePerfectView == nil) {
        _pleasePerfectView = [[XFJPleasePerfectView alloc] initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, 72.0)];
        _pleasePerfectView.backgroundColor = [UIColor whiteColor];
    }
    return _pleasePerfectView;
}

- (XFJGeneralMessageView *)generalMessageView
{
    if (_generalMessageView == nil) {
        _generalMessageView = [[XFJGeneralMessageView alloc] initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, 220)];
        _generalMessageView.backgroundColor = [UIColor whiteColor];
    }
    return _generalMessageView;
}

- (XFJOtherMessagePerfectView *)otherMessagePerfectView
{
    if (_otherMessagePerfectView == nil) {
        _otherMessagePerfectView = [[XFJOtherMessagePerfectView alloc] initWithFrame:CGRectMake(0, 221, SCREEN_WIDTH, 30)];
        _otherMessagePerfectView.backgroundColor = [UIColor whiteColor];
    }
    return _otherMessagePerfectView;
}

- (XFJCarPhotosWithPerfectView *)carPhotosWithPerfectView
{
    if (_carPhotosWithPerfectView == nil) {
        _carPhotosWithPerfectView = [[XFJCarPhotosWithPerfectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
        _carPhotosWithPerfectView.delegate = self;
    }
    return _carPhotosWithPerfectView;
}
- (XFJUpPhotosOpenTeamMessageView *)upPhotosOpenTeamMessageView
{
    if (_upPhotosOpenTeamMessageView == nil) {
        _upPhotosOpenTeamMessageView = [[XFJUpPhotosOpenTeamMessageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.carPhotosWithPerfectView.frame), SCREEN_WIDTH, 170)];
        _upPhotosOpenTeamMessageView.delegate = self;
    }
    return _upPhotosOpenTeamMessageView;
}


- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma makr - 访问照相机  XFJCarPhotosWithPerfectViewDelegate

- (void)chooseImage:(XFJCarPhotosWithPerfectView *)SerPhotoCell
{
    self.maxImageCount = 6;
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"请选择相机或者相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择",nil];
    [action showInView:self.view];
}

- (void)chooseVoucherPhotosImage:(XFJUpPhotosOpenTeamMessageView *)voucherPhotos
{
    self.maxImageCount = 1;
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"请选择相机或者相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择",nil];
    [action showInView:self.view];
}



- (void)jumpCell:(XFJCarPhotosWithPerfectView *)cell indexPath:(NSIndexPath *)indexPath array:(NSMutableArray *)array
{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    _dataArr = array;
    if(indexPath.row < _dataArr.count) {
        for (UIImage *image in _dataArr) {
            WSImageModel *model = [[WSImageModel alloc] init];
            model.image = image;
            [tmpArray addObject:model];
        }
        WSPhotosBroseVC *vc = [[WSPhotosBroseVC alloc] init];
        vc.imageArray = tmpArray;
        vc.showIndex = indexPath.row;
        __weak typeof (self)weakself = self;
        vc.completion = ^ (NSArray *array){
            dispatch_async(dispatch_get_main_queue(), ^{
                [_dataArr removeAllObjects];
                [_dataArr addObjectsFromArray:array];
                weakself.carPhotosWithPerfectView.dataArr = _dataArr;
                if (_dataArr.count <= 4) {
                    self.carPhotosWithPerfectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 170);
                    self.upPhotosOpenTeamMessageView.frame = CGRectMake(0, 170, SCREEN_WIDTH, 170);
                }
            });
        };
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)jumpToCell:(XFJUpPhotosOpenTeamMessageView *)cell indexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    if(indexPath.row < _dataArray.count) {
        for (UIImage *image in _dataArray) {
            WSImageModel *model = [[WSImageModel alloc] init];
            model.image = image;
            [tmpArray addObject:model];
        }
        WSPhotosBroseVC *vc = [[WSPhotosBroseVC alloc] init];;
        vc.imageArray = tmpArray;
        vc.showIndex = indexPath.row;
        __weak typeof (self)weakself = self;
        vc.completion = ^ (NSArray *array){
            dispatch_async(dispatch_get_main_queue(), ^{
                [_dataArray removeAllObjects];
                [_dataArray addObjectsFromArray:array];
                weakself.upPhotosOpenTeamMessageView.dataArr = _dataArray;
            });
        };
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self openCamera];
            break;
        case 1:
            [self openAlbum];
            break;
        default:
            break;
    }
}

- (void)openCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.delegate = self;
        [self presentViewController:ipc animated:YES completion:nil];
    } else {
        //        [MBProgressHUD showHUDMsg: @"请打开允许访问相机权限"];
        NSLog(@"请打开允许访问相机权限");
    }
}

- (void)openAlbum
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxImageCount - (self.maxImageCount == 6 ? self.dataArr.count : self.dataArray.count) delegate:self];
        
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }else{
        //        [MBProgressHUD showHUDMsg: @"请打开允许访问相册权限" ];
    }
}

//相机选的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    if (self.maxImageCount == 6) {
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.carPhotosWithPerfectView.dataArr addObject:image];
        [picker dismissViewControllerAnimated:YES completion:nil];
        self.carPhotosWithPerfectView.dataArr = self.carPhotosWithPerfectView.dataArr;
        self.carPhotosWithPerfectView.maxImageCount = 6;
    }else {
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.upPhotosOpenTeamMessageView.dataArr addObject:image];
        [picker dismissViewControllerAnimated:YES completion:nil];
        self.upPhotosOpenTeamMessageView.dataArr = self.upPhotosOpenTeamMessageView.dataArr;
        self.upPhotosOpenTeamMessageView.maxImageCount = 1;
    }
}

//取消按钮
- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picke{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 相册选的图片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    if (self.maxImageCount == 6) {
        [self.carPhotosWithPerfectView.dataArr addObjectsFromArray:photos];
        self.carPhotosWithPerfectView.dataArr = self.carPhotosWithPerfectView.dataArr;
        self.carPhotosWithPerfectView.maxImageCount = 6;
        if (self.dataArr.count < 4) {
        }else {
            self.carPhotosWithPerfectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 230);
            self.upPhotosOpenTeamMessageView.frame = CGRectMake(0, 230, SCREEN_WIDTH, 170);
        }
    }else {
        [self.upPhotosOpenTeamMessageView.dataArr addObjectsFromArray:photos];
        self.upPhotosOpenTeamMessageView.dataArr = self.upPhotosOpenTeamMessageView.dataArr;
        self.upPhotosOpenTeamMessageView.maxImageCount = 1;
    }
}

/******************************************************** UITableView **********************************************/

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.attrList_tableView) {
        NSString *key = self.sectionArray[indexPath.section];
        NSArray *array = [[self.teamTaskArray objectAtIndex:indexPath.section] objectForKey:key];
        size = [self.attrList_tableView contentSize];
        self.attrList_tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, size.height + 10);
        FindTeamTaskModel *model = [[FindTeamTaskModel alloc] init];
        model = array[indexPath.row];
        NSString *ty_pe = model.attrType;
        if ([ty_pe intValue] == 0) return 45.0;
        if ([ty_pe intValue] == 1) return 45.0;
        if ([ty_pe intValue] == 2) return 100.0;
        if ([ty_pe intValue] == 3) return 45.0;
        if ([ty_pe intValue] == 4) return 53.0;
        if ([ty_pe intValue] == 5) return 45.0;
        if ([ty_pe intValue] == 6) return 50.0;
        if ([ty_pe intValue] == 7) return 220.0;
        else return 0;
    } else if (tableView == self.visitMessage_tableView) {
        messageSize = [self.visitMessage_tableView contentSize];
        return 60;
    } else if (tableView == self.singleTableView) {
        return 44;
    } else if (tableView == self.mulit_SelectTableView) {
        return 44;
    } else if (tableView == self.dropTableView) {
        return 44;
    }
    return 0;
}

/// 区头视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.backgroundTableView && section == 0) {
        self.headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"header"];
        [self.headerView addSubview:self.attrList_tableView];
        return self.headerView;
    } else if (tableView == self.backgroundTableView && section == 1) {
        [sectionOneHeader addSubview:self.visitMessage_tableView];
        return self.visitMessage_tableView;
    } else if (tableView == self.visitMessage_tableView) {
        UITableViewHeaderFooterView *messageSignView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"signHeader"];
        UIView *signView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        signView.backgroundColor = [UIColor whiteColor];
        UIImageView *picImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 10, 12)];
        picImg.image = [UIImage imageNamed:@"information-"];
        [signView addSubview:picImg];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(picImg.frame) + 10, 5, 80, 20)];
        titleLabel.text = @"签到点";
        titleLabel.font = [UIFont systemFontOfSize:14];
        [signView addSubview:titleLabel];
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
        lineLabel.backgroundColor = kColoreeee;
        [signView addSubview:lineLabel];
        [messageSignView addSubview:signView];
        return messageSignView;
    } else if (tableView == self.attrList_tableView) {
        UITableViewHeaderFooterView *listHeaderView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"listHeader"];
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        backgroundView.backgroundColor = kColoreeee;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 150, 20)];
        titleLabel.font = [UIFont systemFontOfSize:13];
        [backgroundView addSubview:titleLabel];
        [listHeaderView addSubview:backgroundView];
        if (tableView == self.attrList_tableView) {
            NSString *key = [self.sectionArray objectAtIndex:section];
            for (NSDictionary *dic in self.teamTaskArray) {
                NSArray *arr = dic[key];
                for (FindTeamTaskModel *model in arr) {
                    titleLabel.text = model.userName;
                }
            }
        }
        return listHeaderView;
    }
    else return nil;
}

// 区尾视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (tableView == self.backgroundTableView && section == 0) {
        footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"footer"];
        [footerView addSubview:self.backGround_view];
        return footerView;
    }
    return nil;
}

// 区头返回高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.backgroundTableView) {
        if (section == 0) {
            [self.attrList_tableView reloadData];
            return size.height + 3;
        } else if (section == 1) {
            [self.visitMessage_tableView reloadData];
            return messageSize.height;
        }
    } else if (tableView == self.visitMessage_tableView) {
        return 40;
    } else if (tableView == self.attrList_tableView) {
        return 30;
    }
    return 0;
}

// 区尾返回高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView == self.backgroundTableView) {
        if (section == 0) {
            return 420;
        }
    }
    return 0;
}

// 点击cell方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.attrList_tableView) {
        
    } else if (tableView == self.visitMessage_tableView) {
        XFJSignMessageViewController *signMessageController = [[XFJSignMessageViewController alloc] init];
        signMessageController.findNewTeamInfo_Id = self.findTeamInfoByState_Id;
        [self.navigationController pushViewController:signMessageController animated:YES];
        XFJTaskRowsItem *item = self.TaskRowsItemArray[indexPath.row];
        signMessageController.taskRowsItem = item;
        
    } else if (tableView == self.singleTableView) {
        sureButton.userInteractionEnabled = YES;
        if (singIndex.row != indexPath.row) {
            SingleListTableViewCell *cell = [self.singleTableView cellForRowAtIndexPath:indexPath];
            [cell.singListButton setImage:[UIImage imageNamed:@"choice"] forState:UIControlStateNormal];
            
            SingleListTableViewCell *cell1 = [self.singleTableView cellForRowAtIndexPath:singIndex];
            [cell1.singListButton setImage:[UIImage imageNamed:@"cycle"] forState:UIControlStateNormal];
        } else {
            SingleListTableViewCell *cell = [self.singleTableView cellForRowAtIndexPath:indexPath];
            [cell.singListButton setImage:[UIImage imageNamed:@"choice"] forState:UIControlStateNormal];
        }
        singIndex = indexPath;
    } else if (tableView == self.mulit_SelectTableView) {
        if ([self.indexSet allObjects].count > 0) {
            for (NSIndexPath *index in [self.indexSet allObjects]) {
                if (indexPath == index) {
                    [self.indexSet removeObject:index];
                    SingleListTableViewCell *cell = [self.mulit_SelectTableView cellForRowAtIndexPath:index];
                    [cell.singListButton setImage:[UIImage imageNamed:@"cycle"] forState:UIControlStateNormal];
                    break;
                } else {
                    [self.indexSet addObject:indexPath];
                    for (NSIndexPath *index in [self.indexSet allObjects]) {
                        SingleListTableViewCell *cell = [self.mulit_SelectTableView cellForRowAtIndexPath:index];
                        [cell.singListButton setImage:[UIImage imageNamed:@"choice"] forState:UIControlStateNormal];
                    }
                }
            }
        } else {
            [self.indexSet addObject:indexPath];
            SingleListTableViewCell *cell = [self.mulit_SelectTableView cellForRowAtIndexPath:indexPath];
            [cell.singListButton setImage:[UIImage imageNamed:@"choice"] forState:UIControlStateNormal];

        }
    } else if (tableView == self.dropTableView) {
        dropDownButton.userInteractionEnabled = YES;
        if (dropIndex.row != indexPath.row) {
            DropDownTableViewCell *cell = [self.dropTableView cellForRowAtIndexPath:indexPath];
            [cell.singListButton setImage:[UIImage imageNamed:@"choice"] forState:UIControlStateNormal];
            
            DropDownTableViewCell *cell1 = [self.dropTableView cellForRowAtIndexPath:dropIndex];
            [cell1.singListButton setImage:[UIImage imageNamed:@"cycle"] forState:UIControlStateNormal];
        } else {
            DropDownTableViewCell *cell = [self.dropTableView cellForRowAtIndexPath:indexPath];
            [cell.singListButton setImage:[UIImage imageNamed:@"choice"] forState:UIControlStateNormal];
        }
        dropIndex = indexPath;
    }
}

#pragma mark - UITableViewDataSource 数据源的代理方法

// 分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.backgroundTableView) return 2;
    if (tableView == self.attrList_tableView) return self.sectionArray.count;
    if (tableView == self.visitMessage_tableView) return 1;
    if (tableView == self.singleTableView) return 1;
    if (tableView == self.mulit_SelectTableView) return 1;
    if (tableView == self.dropTableView) return 1;
    else return 0;
}

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.backgroundTableView) return 0;
    if (tableView == self.attrList_tableView) {
        NSString *key = self.sectionArray[section];
        NSInteger count = [[[self.teamTaskArray objectAtIndex:section] objectForKey:key] count];
        return count;
    }
    if (tableView == self.visitMessage_tableView) return self.TaskRowsItemArray.count;
    if (tableView == self.singleTableView) return self.singleDatasource.count;
    if (tableView == self.mulit_SelectTableView) return self.singleDatasource.count;
    if (tableView == self.dropTableView) return self.singleDatasource.count;
    else return 0;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.backgroundTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"backgroundCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"backgroundCell"];
        }
        return  cell;
    } else if (tableView == self.attrList_tableView) {
        NSString *key = self.sectionArray[indexPath.section];
        NSArray *dataArray = [[self.teamTaskArray objectAtIndex:indexPath.section] objectForKey:key];
        FindTeamTaskModel *model = dataArray[indexPath.row];
        NSString *ty_pe = model.attrType; //行
        if ([ty_pe intValue] == 0) {
            // 单行文本
            XFJFirestAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJFirestAttributeTableViewCell forIndexPath:indexPath];
            cell.teamAttr = model.teamAttr;
            cell.userId = model.userId;
            if (model.isRequire == 1) {
                // 添加到字典
                [self.isRequireDic setValue:model.attrName forKey:model.teamAttr];
            }
            cell.secondTextBlock = ^(NSString *textFieldText, NSString *teamAtt, NSString *userId){
                [self.jsonDataSourceDic setValue:textFieldText forKey:teamAtt];
                if (model.isRequire == 1) {
                    [self.keyArray addObject:teamAtt];
                }
            };
            return cell;
        }else if ([ty_pe intValue] == 1) {
            // 数字
            XFJSecondAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJSecondAttributeTableViewCell forIndexPath:indexPath];
            cell.teamAttr = model.teamAttr;
            if (model.isRequire == 1) {
                // 添加到字典
                [self.isRequireDic setValue:model.attrName forKey:model.teamAttr];
            }
            cell.numberTextBlock = ^(NSString *textFieldText, NSString *teamAtt) {
                 [self.jsonDataSourceDic setValue:textFieldText forKey:teamAtt];
                if (model.isRequire == 1) {
                    [self.keyArray addObject:teamAtt];
                }
            };
            return cell;
        }else if ([ty_pe intValue] == 2) {
            // 多行文本
            XFJThirdAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJThirdAttributeTableViewCell forIndexPath:indexPath];
            cell.teamAttr = model.teamAttr;
            if (model.isRequire == 1) {
                // 添加到字典
                [self.isRequireDic setValue:model.attrName forKey:model.teamAttr];
            }
            cell.mulitBlock = ^(NSString *textFieldText, NSString *teamAtt) {
                [self.jsonDataSourceDic setValue:textFieldText forKey:teamAtt];
                self.mulitStr = textFieldText;
                if (model.isRequire == 1) {
                    [self.keyArray addObject:teamAtt];
                }
            };
            return cell;
        }else if ([ty_pe intValue] == 3) {
            // 单选框
            attributeCell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJFourAttributeTableViewCell forIndexPath:indexPath];
            attributeCell.teamAttr = model.teamAttr;
            if (model.isRequire == 1) {
                // 添加到字典
                [self.isRequireDic setValue:model.attrName forKey:model.teamAttr];
            }
            __weak typeof(self)weakSelf = self;
            attributeCell.presentMaskViewBlock = ^(NSString *typesStr) {
                weakSelf.singleTableView.frame = CGRectMake(0, 0, CGRectGetWidth(weakSelf.singleChooseView.frame), CGRectGetHeight(weakSelf.singleChooseView.frame));
                [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.maskView1];
                [weakSelf.maskView1 addSubview:weakSelf.singleChooseView];
                [weakSelf requestGetfindParamDataWithStr:typesStr];
                
                if (model.isRequire == 1) {
                    [weakSelf.keyArray addObject:typesStr];
                }
            };
            return attributeCell;
        }else if ([ty_pe intValue] == 5) {
            // 下拉框
            fiveCell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJFiveAttributeTableViewCell forIndexPath:indexPath];
            fiveCell.teamAttr = model.teamAttr;
            if (model.isRequire == 1) {
                // 添加到字典
                [self.isRequireDic setValue:model.attrName forKey:model.teamAttr];
            }
            __weak typeof(self)weakSelf = self;
            fiveCell.myBlock = ^(NSString *typeStr) {
                weakSelf.dropTableView.frame = CGRectMake(0, 0, CGRectGetWidth(weakSelf.singleChooseView.frame), CGRectGetHeight(weakSelf.singleChooseView.frame));
                [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.maskView1];
                [weakSelf.maskView1 addSubview:weakSelf.dropView];
                [weakSelf requestGetfindParamDataWithStr:typeStr];
                
                if (model.isRequire == 1) {
                    [weakSelf.keyArray addObject:typeStr];
                }
            };
            return fiveCell;
        }else if ([ty_pe intValue] == 6) {
            // 日期选择
            XFJSixAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJSixAttributeTableViewCell forIndexPath:indexPath];
            cell.teamAtt = model.teamAttr;
            if (model.isRequire == 1) {
                // 添加到字典
                [self.isRequireDic setValue:model.attrName forKey:model.teamAttr];
            }
            cell.dateBlock = ^(NSString *teamAttr, NSString *dateStr) {
                [self.jsonDataSourceDic setValue:dateStr forKey:teamAttr];
                if (model.isRequire == 1) {
                    [self.keyArray addObject:teamAttr];
                }
            };
            return cell;
        }else if ([ty_pe intValue] == 7) {
            // 图片上传
            XFJSevenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJSevenTableViewCell forIndexPath:indexPath];
            cell.teamAttr = model.teamAttr;
            if (model.isRequire == 1) {
                // 添加到字典
                [self.isRequireDic setValue:model.attrName forKey:model.teamAttr];
            }
            __weak __typeof(self)wself = self;
            cell.presentPickPhotosBlock = ^(TZImagePickerController *pickerController) {
                [wself presentViewController:pickerController animated:YES completion:nil];
            };
            
            cell.pictureArrayBlock = ^(NSString *teamAttr, NSArray *picArray, BOOL isClick) {
                [self.cachePicArray addObject:teamAttr];
                NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
                NSString *teamAttPath = [cachePath stringByAppendingPathComponent:teamAttr];
                NSFileManager *fileManager = [NSFileManager defaultManager];
                [fileManager removeItemAtPath:teamAttPath error:nil];
                if (![fileManager fileExistsAtPath:teamAttPath]) {
                    [fileManager createDirectoryAtPath:teamAttPath withIntermediateDirectories:YES attributes:nil error:nil];
                }
                for (UIImage *picImg in picArray) {
                    NSString *imgPath = [teamAttPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", picImg]];
                    BOOL result = [UIImageJPEGRepresentation(picImg, 1) writeToFile:imgPath atomically:YES];
                    NSLog(@"%d", result);
                }
                
                if (model.isRequire == 1) {
                    if (isClick == YES) {
                        [self.keyArray addObject:teamAttr];
                    } else {
                        [self.keyArray removeObject:teamAttr];
                    }
                }
            };
            
            return cell;
        }else {
            // 多选框
            mulit_SelectCell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJEigthAttributeTableViewCell forIndexPath:indexPath];
            mulit_SelectCell.teamAttr = model.teamAttr;
            if (model.isRequire == 1) {
                // 添加到字典
                [self.isRequireDic setValue:model.attrName forKey:model.teamAttr];
            }
            __weak __typeof(self)wself = self;
            mulit_SelectCell.presentMaskViewBlock = ^(NSString *typesStr) {
                [wself.maskView1 addSubview:wself.multi_SelectView];
                [[UIApplication sharedApplication].keyWindow addSubview:wself.maskView1];
                [wself requestGetfindParamDataWithStr:typesStr];
                if (model.isRequire == 1) {
                    [wself.keyArray addObject:typesStr];
                }
            };
            return mulit_SelectCell;
        }
    } else if (tableView == self.visitMessage_tableView) {
        teamMessageCell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJTeamMessageTableViewCell forIndexPath:indexPath];
        teamMessageCell.taskRowsItem = self.TaskRowsItemArray[indexPath.row];
        if (teamMessageCell.taskRowsItem.isRequire == 1) {
            if (teamMessageCell.taskRowsItem.finishState == 0) {
                teamMessageCell.redCicle_view.hidden = NO;
            } else {
                teamMessageCell.redCicle_view.hidden = YES;
            }
        }else {
            if (teamMessageCell.taskRowsItem.finishState == 0) {
                teamMessageCell.redCicle_view.hidden = NO;
            } else {
                teamMessageCell.redCicle_view.hidden = YES;
            }
        }
        
        return teamMessageCell;
    } else if (tableView == self.singleTableView) {
        SingleListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"singleCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        SingleListModel *model = self.singleDatasource[indexPath.row];
        cell.nameLabel.text = model.name;
        return cell;
    } else if (tableView == self.mulit_SelectTableView) {
        MulitSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mulit_selectCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        SingleListModel *model = self.singleDatasource[indexPath.row];
        cell.nameLabel.text = model.name;
        return cell;
    } else if (tableView == self.dropTableView) {
        DropDownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dropCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        SingleListModel *model = self.singleDatasource[indexPath.row];
        cell.nameLabel.text = model.name;
        return cell;
        
    }
    else return nil;
}


#pragma mark - cell上按钮点击的方法

// 点击单选框的方法
- (void)sureAction:(UIButton *)sender {
    if (self.singleDatasource.count > 0) {
        SingleListModel *model = self.singleDatasource[singIndex.row];
        attributeCell.quality_field.text = model.name;
        [self.jsonDataSourceDic setValue:model.name forKey:model.types];
        [self.maskView1 removeFromSuperview];
        [self.singleChooseView removeFromSuperview];
        [self.attrList_tableView reloadData];
    }
}

// 点击多选框的方法
- (void)doneAction:(UIButton *)sender {
    NSArray *indexPathArray = [self.indexSet allObjects];
    SingleListModel *model = [[SingleListModel alloc] init];
    for (NSIndexPath *indexPath in indexPathArray) {
        model = self.singleDatasource[indexPath.row];
        [self.indexArray addObject:model.name];
    }
    mulit_SelectCell.qualityContent_label.text = [self.indexArray componentsJoinedByString:@","];
    [self.jsonDataSourceDic setValue:self.indexArray forKey:model.types];
    [self.maskView1 removeFromSuperview];
    [self.multi_SelectView removeFromSuperview];
    [self.mulit_SelectTableView reloadData];
}

- (void)dropAction:(UIButton *)sender {
    if (self.singleDatasource.count > 0) {
        // 下拉框的选择之后的
        SingleListModel *model = self.singleDatasource[dropIndex.row];
        fiveCell.teamPropertiesContent_label.text = model.name;
        [self.jsonDataSourceDic setValue:model.name forKey:model.types];
    }
    [self.maskView1 removeFromSuperview];
    [self.dropView removeFromSuperview];
    [self.dropTableView reloadData];
}


//提交数据的按钮
- (void)clickCommitButton:(UIButton *)sender {
    NSMutableSet *keySet = [NSMutableSet setWithArray:[self.isRequireDic allKeys]];
    [keySet minusSet:self.keyArray];
    if (keySet.count) {
        if (keySet.count > 0) {
            NSArray *array = [keySet allObjects];
            for (NSString *key in array) {
                NSString *name = [self.isRequireDic objectForKey:key];
                [MBProgressHUD showHudTipStr:[NSString stringWithFormat:@"%@不能为空", name] contentColor:HidWithColorContentBlack];
                return;
            }
        } else {
            for (XFJTaskRowsItem *model in self.TaskRowsItemArray) {
                if (model.isRequire == 1) {
                    if (model.finishState == 0) {
                        [MBProgressHUD showHudTipStr:@"请完善签到点信息!" contentColor:HidWithColorContentBlack];
                    }
                } else {
                    if (model.finishState == 0) {
                        [MBProgressHUD showHudTipStr:@"请完善签到点信息!" contentColor:HidWithColorContentBlack];
                    }
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD hidenHud];
                });
                
            }
 
        }
    } else {
        [self upLoadPic];
        // 上传凭证图片
        [self upLoadVoucherPic];
        [self uploadTeamPicture];
        
    }
}



#pragma mark - 图片上传车辆照片

- (void)upLoadPic {
    [self.carPhotoArray removeAllObjects];
    if (self.carPhotosWithPerfectView.dataArr.count == 0) {
        [MBProgressHUD showHudTipStr:@"请上传车辆照片!" contentColor:HidWithColorContentBlack];
        return;
    }else {
        for (int i = 0; i < self.carPhotosWithPerfectView.dataArr.count; i++) {
            UIImage *image = self.carPhotosWithPerfectView.dataArr[i];
            NSData *imageData = [UIImage compressImage:image maxSize:300];
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            [manager POST:UPLOADIMAGE parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.jpg" mimeType:@"image/jpg"];
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"%f", uploadProgress.fractionCompleted);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self.carPhotoArray addObject:responseObject[@"object"]];
                if (self.carPhotoArray.count == self.carPhotosWithPerfectView.dataArr.count) {
                    // 存放到字典中
                    self.picStr = [self.carPhotoArray componentsJoinedByString:@","];
                    NSLog(@"%@", self.picStr);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"上传图片失败--------%@",error);
            }];
        }
    }
}

#pragma mark - 上传凭证
- (void)upLoadVoucherPic {
    if (self.upPhotosOpenTeamMessageView.dataArr.count == 0) {
        [MBProgressHUD showHudTipStr:@"请上传凭证照片!" contentColor:HidWithColorContentBlack];
        return;
    }else {
        [self.certificatePicArray removeAllObjects];
        [MBProgressHUD showLoadHUD];
        UIImage *image = self.upPhotosOpenTeamMessageView.dataArr[0];
        NSData *imageData = [UIImage compressImage:image maxSize:300];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager POST:UPLOADIMAGE parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.jpg" mimeType:@"image/jpg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD hidenHud];
            [self.certificatePicArray addObject:responseObject[@"object"]];
            if (self.certificatePicArray.count == self.upPhotosOpenTeamMessageView.dataArr.count) {
                self.certificateStr = [self.certificatePicArray componentsJoinedByString:@","];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hidenHud];
            NSLog(@"上传图片失败--------%@",error);
        }];
    }
}

// 上传团队图片

- (void)uploadTeamPicture {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    for (NSString *picPath in self.cachePicArray) {
        NSMutableArray *array = [NSMutableArray array];
        NSString *path = [cachePath stringByAppendingPathComponent:picPath];
        NSDirectoryEnumerator *dirEnum = [fileManager enumeratorAtPath:path];
        NSString *imgPath;
        while ((imgPath = [dirEnum nextObject]) != nil) {
            NSString *pathOfImg = [path stringByAppendingPathComponent:imgPath];
            [array addObject:pathOfImg];
        }
        [self.imgPathDic setValue:array forKey:picPath];
    }
    
    
    for (NSString *key in self.cachePicArray) {
        NSMutableArray *imgObjArray = [NSMutableArray array];
        for (NSString *picImgPath in self.imgPathDic[key]) {
            UIImage *image = [UIImage imageWithContentsOfFile:picImgPath];
            [manager POST:UPLOADIMAGE parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                NSData *imageData = [UIImage compressImage:image maxSize:300];
                [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.jpg" mimeType:@"image/jpg"];
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSString *objectImg = responseObject[@"object"];
                [imgObjArray addObject:objectImg];
                if (imgObjArray.count == [self.imgPathDic[key] count]) {
                    [self.jsonDataSourceDic setObject:imgObjArray forKey:key];
                    if (key == [self.cachePicArray lastObject]) {
                        // 上传数据
                        if (key == [self.cachePicArray lastObject] && self.carPhotoArray.count == self.carPhotosWithPerfectView.dataArr.count) {
                            [self sureCommitWithAttributeTeamId:self.teamId];
                        }
                    }
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@", error);
            }];
        }
    }
}


#pragma mark - 完善资料的确认提交
- (void)sureCommitWithAttributeTeamId:(NSInteger)teamId
{
    //转成json格式给服务器发送
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.jsonDataSourceDic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    for (XFJTaskRowsItem *item in self.TaskRowsItemArray) {
        if (item.finishState == 0) {
            // 已完成
        } else {
            // 未完成
        }
    }
    
    NSDictionary *dictParams = @{
                                 @"id":[NSString stringWithFormat:@"%zd",self.findTeamInfoByState_Id],
                                 @"teamBack":jsonString,
                                 @"teamVehicleImages":self.picStr,//图片集合
                                 @"certificateImg":self.certificateStr,
                                 @"finishState":@0
                                 };
    [GRNetRequestClass POST:MODIFYTEAMINFOURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSString *success = [responseObject objectForKey:@"success"];
            if ([success intValue] == 1) {
                [MBProgressHUD showHudTipStr:@"修改资料成功!" contentColor:HidWithColorContentBlack];
                //弹出确认提交和取消弹窗
                [self sureAndCommitShow:self.teamId];
            }
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            [MBProgressHUD showHudTipStr:@"修改信息失败" contentColor:HidWithColorContentBlack];
            NSLog(@"++++++++++++++修改信息失败的结果是 :%@",error);
        }
    }];
    
}




@end
