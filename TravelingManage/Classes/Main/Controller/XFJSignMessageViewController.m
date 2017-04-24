//
//  XFJSignMessageViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/2.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJSignMessageViewController.h"
#import "XFJSignMessageTopVeiw.h"
#import "XFJSignMessageTimeView.h"
#import "XFJSignTeamPhotosView.h"
#import "XFJLaterTeamControlItem.h"
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
#import "XFJFindCustomAttrListItem.h"
#import "TZImagePickerController.h"
#import "WSImagePickerView.h"
#import "WSPhotosBroseVC.h"
#import "XFJSureUpPhotosView.h"
#import "HomeViewController.h"
#import "JTNavigationController.h"


#import "FindTeamTaskModel.h"
#import "MulitSelectTableViewCell.h"
#import "DropDownTableViewCell.h"
#import "SingleListTableViewCell.h"
#import "SingleListModel.h"
#import <UIButton+WebCache.h>
#import "XFJCarPhotosWithPerfectView.h"
#import "XFJUpPhotosOpenTeamMessageView.h"


#define const_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define const_ScreenHeight [UIScreen mainScreen].bounds.size.height
#define const_ScreenChinge(A) (A) * [UIScreen mainScreen].bounds.size.width/375

@interface XFJSignMessageViewController () <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource,XFJSignTeamPhotosViewDelegate> {
    XFJFourAttributeTableViewCell *attributeCell;
    XFJFiveAttributeTableViewCell *fiveCell;
    XFJEigthAttributeTableViewCell *mulit_SelectCell;
    UIButton *sureButton;
    UIButton *sureAction;
    UIButton *dropDownButton;
    UIButton *addPicButton;
    NSIndexPath *singIndex;
    NSIndexPath *mulitIndex;
    NSIndexPath *dropIndex;
    BOOL isSelect;
}

@property (nonatomic, strong) UIView *signMessageTopVeiw;
@property (nonatomic, strong) XFJSignMessageTimeView *signMessageTimeView;
@property (nonatomic, strong) XFJSignTeamPhotosView *signTeamPhotosView;
@property (nonatomic, strong) UIScrollView *scroll_view;
@property (nonatomic, strong) NSMutableArray *attrTypeArray;
@property (nonatomic, strong) NSMutableArray <XFJFindCustomAttrListItem *> *findCustomAttrListItemArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger maxImageCount;
@property (nonatomic, strong) XFJSureUpPhotosView *sureUpPhotosView;
@property (nonatomic, strong) NSString *root;
@property (nonatomic, strong) NSString *voucherPicRoot;
@property (nonatomic, strong) XFJLaterTeamControlItem *laterTeamControlItem;
@property (nonatomic, assign) BOOL isUpHpotos;


@property (nonatomic, strong) UITableView *attrList_tableView;//主界面
@property (nonatomic, strong) UILabel *title_label;// 标题
@property (nonatomic, strong) UIView *backgroundView;//景点签到时间View
@property (nonatomic, strong) NSArray *sectionArray;// 分区个数数组
@property (nonatomic, strong) NSMutableArray *dataSource;// 数据原数组

@property (nonatomic, strong) NSMutableArray *singleDatasource;// 单选,下拉,多选的数据源数组
@property (nonatomic, strong) UIView *singleChooseView;// 单选框
@property (nonatomic, strong) UITableView *singleTableView;// 单选框TableView

@property (nonatomic, strong) UIView *dropView;//下拉框
@property (nonatomic, strong) UITableView *dropTableView;//下拉框TableView

@property (nonatomic, strong) UIView *multi_SelectView;// 多选
@property (nonatomic, strong) UITableView *mulit_SelectTableView;// 多选的tableview

@property (nonatomic, strong) XFJMaskView *maskView1;
@property (nonatomic, strong) NSMutableSet *indexSet;
@property (nonatomic, strong) NSMutableArray *indexArray;

@property (nonatomic, strong) NSMutableDictionary *jsonDataSourceDic;
@property (nonatomic, strong) NSMutableDictionary *userIdDic;
@property (nonatomic, strong) NSMutableSet *keyArray;
@property (nonatomic, strong) NSMutableSet *userSet;
@property (nonatomic, strong) NSArray *pictureArr;
@property (nonatomic, strong) NSMutableDictionary *isRequireDic;
@property (nonatomic, copy) NSString *finalStr;

@property (nonatomic, strong) XFJCarPhotosWithPerfectView *carPhotosWithPerfectView;
@property (nonatomic, strong) XFJUpPhotosOpenTeamMessageView *upPhotosOpenTeamMessageView;
@property (nonatomic, strong) NSMutableArray *carPhotoArray;// 存放车辆图片上传之后的数据(图片URL)
@property (nonatomic, copy) NSString *picStr;
@property (nonatomic, strong) NSMutableArray *certificatePicArray;// 存放车辆图片上传之后的数据(图片URL)
@property (nonatomic, strong) NSMutableArray *certifierArray;
@property (nonatomic, strong) NSMutableArray *cachePicArray;

@property (nonatomic, strong) NSMutableArray *imgPathArray;
@property (nonatomic, strong) NSMutableDictionary *imgPathDic;
@property (nonatomic, copy) NSString *taskImg;// 凭证图片返回的数据

@end

@implementation XFJSignMessageViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.navigationItem.titleView = self.title_label;
//    self.view.backgroundColor = kColoreeee;
//    [self.view addSubview:self.scroll_view];
//    [self.scroll_view addSubview:self.signMessageTopVeiw];
//    [self.scroll_view addSubview:self.signMessageTimeView];
//    [self.scroll_view addSubview:self.signTeamPhotosView];
//    [self.scroll_view addSubview:self.attrList_tableView];
//    [self.scroll_view addSubview:self.sureUpPhotosView];
//    [self.attrList_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.signTeamPhotosView.mas_bottom);
//        make.height.mas_equalTo(30.0);
//        make.left.mas_equalTo(self.view.mas_left);
//        make.right.mas_equalTo(self.view.mas_right);
//    }];
//    [self.sureUpPhotosView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.attrList_tableView.mas_bottom);
//        make.left.mas_equalTo(self.view.mas_left);
//        make.right.mas_equalTo(self.view.mas_right);
//        make.height.mas_equalTo(100.0);
//    }];
//
//    [self.attrList_tableView registerClass:[XFJFirestAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJFirestAttributeTableViewCell];
//    [self.attrList_tableView registerClass:[XFJSecondAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJSecondAttributeTableViewCell];
//    [self.attrList_tableView registerClass:[XFJThirdAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJThirdAttributeTableViewCell];
//    [self.attrList_tableView registerClass:[XFJFourAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJFourAttributeTableViewCell];
//    [self.attrList_tableView registerClass:[XFJFiveAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJFiveAttributeTableViewCell];
//    [self.attrList_tableView registerClass:[XFJSixAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJSixAttributeTableViewCell];
//    [self.attrList_tableView registerClass:[XFJSevenTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJSevenTableViewCell];
//    [self.attrList_tableView registerClass:[XFJEigthAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJEigthAttributeTableViewCell];
//
//    [self requestLatelyControl];
//    __weak __typeof(self)wself = self;
//    self.sureUpPhotosView.sureUpDataButtonClickBlock = ^() {
//      //上传接口
//        [wself requestUpPhotos];
//    };
//}
//
//#pragma mark - 上传图片
//- (void)requestUpPhotos
//{
//    if (self.dataArray.count == 0) {
////        [MBProgressHUD showHudTipStr:@"请上传凭证照片" contentColor:HidWithColorContentBlack];
//        self.isUpHpotos = YES;
//        [self sureRequestUp];
//    }else {
//        [MBProgressHUD showLoadHUD];
//        UIImage *image = self.dataArray[0];
//        NSData *imageData = [UIImage compressImage:image maxSize:300];
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        __weak __typeof(self)wself = self;
//        [manager POST:UPLOADIMAGE parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//            [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.jpg" mimeType:@"image/jpg"];
//        } progress:^(NSProgress * _Nonnull uploadProgress) {
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            [MBProgressHUD hidenHud];
//            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            NSString *root = dict[@"object"];
//            wself.voucherPicRoot = root;
//            NSLog(@"上传图片成功后的信息-------%@",root);
////            dispatch_async(dispatch_get_main_queue(), ^{
////                if (wself.root.length == 0) {
////                    [MBProgressHUD showHudTipStr:@"图片上传失败~~" contentColor:HidWithColorContentBlack];
////                    return ;
////                }
//                //确认提交
//                [wself sureRequestUp];
////            });
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            [MBProgressHUD hidenHud];
//            NSLog(@"上传图片失败--------%@",error);
//        }];
//    }
//}
//
//- (void)setLaterTeamControlItem:(XFJLaterTeamControlItem *)laterTeamControlItem
//{
//    _laterTeamControlItem = laterTeamControlItem;
//}
//
//- (void)setTaskRowsItem:(XFJTaskRowsItem *)taskRowsItem
//{
//    _taskRowsItem = taskRowsItem;
//    self.signMessageTopVeiw.taskRowsItem = taskRowsItem;
//    self.signMessageTimeView.taskRowsItem = taskRowsItem;
//}
//
//#pragma makr - 任务信息提交
//- (void)sureRequestUp
//{
//    NSLog(@"--------------获取到的模型是 :%@",self.laterTeamControlItem);
//    NSDictionary *dictParams = @{
//                                 @"id":[NSString stringWithFormat:@"%zd",self.taskRowsItem.taskId],//任务id
//                                 @"teamId":[NSString stringWithFormat:@"%zd",self.findNewTeamInfo_Id],//团队id
//                                 @"attractionsId":[NSString stringWithFormat:@"%zd",self.taskRowsItem.attractionsId],//景区id
//                                 @"attracImagePath":self.isUpHpotos == YES ? @"" : self.voucherPicRoot,//非必传参数
//                                 @"taskBack":@""//非必传参数
//                                 };
//    NSLog(@"+++++=====----------打印的参数是:%@",dictParams);
//    __weak __typeof(self)wself = self;
//    [GRNetRequestClass POST:TASKPERFECTURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
//        if (responseObject) {
//            NSLog(@"responseObject:%@",responseObject);
//            [MBProgressHUD hidenHud];
//            if ([[responseObject objectForKey:@"msg"] isEqualToString:@"success"]) {
//                [MBProgressHUD showHudTipStr:@"信息提交成功" contentColor:HidWithColorContentBlack];
//                [wself.navigationController popViewControllerAnimated:YES];
//            }
//        }
//    } fail:^(NSURLSessionDataTask *task, NSError *error) {
//        if (error) {
//            NSLog(@"error:%@",error);
//            [MBProgressHUD showHudTipStr:@"信息提交失败,可能是网络原因" contentColor:HidWithColorContentBlack];
//        }
//    }];
//}
//- (NSMutableArray *)dataArray
//{
//    if (_dataArray == nil) {
//        _dataArray = [NSMutableArray array];
//    }
//    return _dataArray;
//}
//
//
//- (XFJSignMessageTopVeiw *)signMessageTopVeiw
//{
//    if (_signMessageTopVeiw == nil) {
//        _signMessageTopVeiw = [[XFJSignMessageTopVeiw alloc] initWithFrame:CGRectMake(const_ScreenChinge(8), const_ScreenChinge(8)  , const_ScreenWidth - const_ScreenChinge(16) , const_ScreenChinge(38))];
//    }
//    return _signMessageTopVeiw;
//}
//
//- (XFJSignMessageTimeView *)signMessageTimeView
//{
//    if (_signMessageTimeView == nil) {
//        _signMessageTimeView = [[XFJSignMessageTimeView alloc] initWithFrame:CGRectMake(0, 38, SCREEN_WIDTH, 97.0)];
//    }
//    return _signMessageTimeView;
//}
//
//- (XFJSureUpPhotosView *)sureUpPhotosView
//{
//    if (_sureUpPhotosView == nil) {
//        _sureUpPhotosView = [[XFJSureUpPhotosView alloc] init];
//        _sureUpPhotosView.backgroundColor = [UIColor whiteColor];
//    }
//    return _sureUpPhotosView;
//}
//
//- (XFJSignTeamPhotosView *)signTeamPhotosView
//{
//    if (_signTeamPhotosView == nil) {
//        _signTeamPhotosView = [[XFJSignTeamPhotosView alloc] initWithFrame:CGRectMake(0, 135, SCREEN_WIDTH, 150)];
//        _signTeamPhotosView.delegate = self;
//    }
//    return _signTeamPhotosView;
//}
//
//- (void)chooseVoucherPhotosImage:(XFJSignTeamPhotosView *)voucherPhotos
//{
//    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"请选择相机或者相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择",nil];
//    [action showInView:self.view];
//}
//
//
//#pragma mark - 最近操作的团队
//- (void)requestLatelyControl
//{
//    NSDictionary *dictParams = @{
//                                 @"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"]
//                                 };
//    __weak __typeof(self)wself = self;
//    [GRNetRequestClass POST:FINDNEWTEAMINFOURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
//        if (responseObject) {
//            NSLog(@"+++++++++++获取到的最近的操作的团队是:%@",responseObject);
//            NSDictionary *dict = [responseObject objectForKey:@"object"];
//            XFJLaterTeamControlItem *laterTeamControlItem = [XFJLaterTeamControlItem mj_objectWithKeyValues:dict];
//            wself.signMessageTopVeiw.laterTeamControlItem = laterTeamControlItem;
//            wself.signMessageTimeView.laterTeamControlItem = laterTeamControlItem;
//            wself.laterTeamControlItem = laterTeamControlItem;
//            //如果状态值显示的是0就显示签到按钮
//            //如果状态值显示的是1就是签退按钮
//            NSLog(@"========打印出来的最近团队的参数模型是:%@",laterTeamControlItem);
//            [wself requestTeamMessage:self.taskRowsItem.teamId attractionsId:laterTeamControlItem.attractionsId];
//        }
//    } fail:^(NSURLSessionDataTask *task, NSError *error) {
//        if (error) {
//            NSLog(@"+++++++++++++获取不到的最近的操作的团队打印的错误信息是:%@",error);
//        }
//    }];
//}
//
//- (NSMutableArray *)attrTypeArray
//{
//    if (_attrTypeArray == nil) {
//        _attrTypeArray = [NSMutableArray array];
//    }
//    return _attrTypeArray;
//}
//
//- (UITableView *)attrList_tableView
//{
//    if (_attrList_tableView == nil) {
//        _attrList_tableView = [[UITableView alloc] init];
//        _attrList_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
////        _attrList_tableView.delegate = self;
////        _attrList_tableView.dataSource = self;
//        _attrList_tableView.bounces = NO;
//    }
//    return _attrList_tableView;
//}
//
//- (UIScrollView *)scroll_view
//{
//    if (_scroll_view == nil) {
//        _scroll_view = [[UIScrollView alloc] init];
//        _scroll_view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 1.2 * self.view.XFJ_Height);
//        _scroll_view.contentSize = CGSizeMake(0, self.view.XFJ_Height * 1.3);
//        _scroll_view.backgroundColor = kColoreeee;
//        _scroll_view.showsHorizontalScrollIndicator = NO;
//        _scroll_view.scrollEnabled = YES;
//    }
//    return _scroll_view;
//}
//- (void)requestTeamMessage:(NSInteger)findNewTeamInfo_Id attractionsId:(NSInteger)attractionsId
//{
//    [self requestFindCustomAttrListMessage:findNewTeamInfo_Id attractionsId:attractionsId];
//}
//
//#pragma mark - 加载自定义字段数据
//- (void)requestFindCustomAttrListMessage:(NSInteger)teamId attractionsId:(NSInteger)attractionsId
//{
//    NSDictionary *dictParams = @{
//                                 @"teamId":@426,
//                                 @"attractionsId":[NSString stringWithFormat:@"%ld", attractionsId],
//                                 @"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"],
//                                 @"teamAttractionsType":@1
//                                 };
//    __weak __typeof(self)wself = self;
//    NSLog(@"-------------自定义字段参数是 :%@",dictParams);
//    [GRNetRequestClass GET:FINDCUSTOMESURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"++++++++++++++%@", responseObject);
//        if (responseObject) {
//            NSMutableArray *rowsArray = [responseObject objectForKey:@"rows"];
//            wself.findCustomAttrListItemArray = [XFJFindCustomAttrListItem mj_objectArrayWithKeyValuesArray:rowsArray];
//            for (NSInteger i = 0; i < wself.findCustomAttrListItemArray.count; i++) {
//                int attrType = wself.findCustomAttrListItemArray[i].attrType;
//                //                [wself.attrTypeArray addObject:attrType];
//                [wself.attrTypeArray addObject:[NSString stringWithFormat:@"%d",attrType]];
//                NSLog(@"+++++++++++返回的自定字段信息是 :%d",attrType);
//            }
//            [wself.attrList_tableView reloadData];
//        }
//    } fail:^(NSURLSessionDataTask *task, NSError *error) {
//        if (error) {
//            NSLog(@"___________返回错误的信息是 :%@",error);
//        }
//    }];
//}
//
//- (NSMutableArray <XFJFindCustomAttrListItem *> *)findCustomAttrListItemArray
//{
//    if (_findCustomAttrListItemArray == nil) {
//        _findCustomAttrListItemArray = [NSMutableArray array];
//    }
//    return _findCustomAttrListItemArray;
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [self.findCustomAttrListItemArray count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    NSInteger i = indexPath.row;
////    NSString *ty_pe = self.attrTypeArray[i];
////    if ([ty_pe intValue] == 0) {
////        XFJFirestAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJFirestAttributeTableViewCell forIndexPath:indexPath];
////        NSLog(@"---------获取的back值是0 :%@",self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr);
////        return cell;
////    }else if ([ty_pe intValue] == 1) {
////        XFJSecondAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJSecondAttributeTableViewCell forIndexPath:indexPath];
////        NSLog(@"---------获取的back值是1 :%@",self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr);
////        return cell;
////    }else if ([ty_pe intValue] == 2) {
////        XFJThirdAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJThirdAttributeTableViewCell forIndexPath:indexPath];
////        NSLog(@"---------获取的back值是2 :%@",self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr);
////        return cell;
////    }else if ([ty_pe intValue] == 3) {
////        XFJFourAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJFourAttributeTableViewCell forIndexPath:indexPath];
////        NSLog(@"---------获取的back值是3 :%@",self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr);
////        cell.teamAttr = self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr;
////        __weak __typeof(self)wself = self;
////        cell.presentMaskViewBlock = ^(NSString *typesStr) {
//////            [[UIApplication sharedApplication].keyWindow addSubview:wself.maskView1];
////            NSLog(@"-------------这里打印的back值是 :%@",typesStr);
////        };
////        return cell;
////    }else if ([ty_pe intValue] == 4) {
////        XFJFiveAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJFiveAttributeTableViewCell forIndexPath:indexPath];
////        NSLog(@"---------获取的back值是4 :%@",self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr);
////        return cell;
////    }else if ([ty_pe intValue] == 5) {
////        XFJSixAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJSixAttributeTableViewCell forIndexPath:indexPath];
////        NSLog(@"---------获取的back值是5 :%@",self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr);
////        return cell;
////    }else if ([ty_pe intValue] == 6) {
////        XFJSevenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJSevenTableViewCell forIndexPath:indexPath];
////        NSLog(@"---------获取的back值是6 :%@",self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr);
////        __weak __typeof(self)wself = self;
//////        cell.presentPickPhotosBlock = ^(TZImagePickerController *pickerController) {
//////            [wself presentViewController:pickerController animated:YES completion:nil];
//////        };
////        return cell;
////    }else {
////        XFJEigthAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJEigthAttributeTableViewCell forIndexPath:indexPath];
////        cell.teamAttr = self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr;
////        NSLog(@"---------获取的back值是7 :%@",self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr);
////        __weak __typeof(self)wself = self;
//////        cell.presentMaskViewBlock = ^(NSString *typesStr) {
//////            [[UIApplication sharedApplication].keyWindow addSubview:wself.maskView1];
//////            self.checkBoxView.backStr = typesStr;
//////            [wself.maskView1 addSubview:self.checkBoxView];
//////            NSLog(@"-------------这里打印的back值是 :%@",typesStr);
//////        };
//////        if (self.AttributeStr != nil) {
//////            NSDictionary *dict = @{
//////                                   @"name":self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr,//这是显示的是back几
//////                                   @"value":self.AttributeStr//这里添加的是和back对应的值
//////                                   };
//////            [self.allAttribute_array addObject:dict];
//////            NSLog(@"这是显示的是back%@--------这里添加的是和back对应的值%@",self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr,self.AttributeStr);
//////        }
////        return cell;
////    }
//
//    return nil;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    self.attrList_tableView.frame = CGRectMake(0, 323, SCREEN_WIDTH, 80 * self.findCustomAttrListItemArray.count);
//    NSInteger i = indexPath.row;
//    NSString *ty_pe = self.attrTypeArray[i];
//    if ([ty_pe intValue] == 0) {
//        return 45.0;
//    }else if ([ty_pe intValue] == 1) {
//        return 45.0;
//    }else if ([ty_pe intValue] == 2) {
//        return 100.0;
//    }else if ([ty_pe intValue] == 3) {
//        return 45.0;
//    }else if ([ty_pe intValue] == 4) {
//        return 53.0;
//    }else if ([ty_pe intValue] == 5) {
//        return 45.0;
//    }else if ([ty_pe intValue] == 6) {
//        return 240.0;
//    }else {
//        return 45.0;
//    }
//}
//
//- (void)jumpToCell:(XFJSignTeamPhotosView *)cell indexPath:(NSIndexPath *)indexPath
//{
//    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
//    if(indexPath.row < _dataArray.count) {
//        for (UIImage *image in _dataArray) {
//            WSImageModel *model = [[WSImageModel alloc] init];
//            model.image = image;
//            [tmpArray addObject:model];
//        }
//        WSPhotosBroseVC *vc = [[WSPhotosBroseVC alloc] init];;
//        vc.imageArray = tmpArray;
//        vc.showIndex = indexPath.row;
//        __weak typeof (self)weakself = self;
//        vc.completion = ^ (NSArray *array){
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [_dataArray removeAllObjects];
//                [_dataArray addObjectsFromArray:array];
//                weakself.signTeamPhotosView.dataArr = _dataArray;
//            });
//        };
//
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//}
//
//
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    switch (buttonIndex) {
//        case 0:
//            [self openCamera];
//            break;
//        case 1:
//            [self openAlbum];
//            break;
//        default:
//            break;
//    }
//}
//
//- (void)openCamera
//{
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
//        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
//        ipc.delegate = self;
//        [self presentViewController:ipc animated:YES completion:nil];
//    } else {
//        //        [MBProgressHUD showHUDMsg: @"请打开允许访问相机权限"];
//        NSLog(@"请打开允许访问相机权限");
//    }
//}
//
//- (void)openAlbum
//{
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxImageCount - self.dataArray.count delegate:self];
//        [self presentViewController:imagePickerVc animated:YES completion:nil];
//    }else{
//        //        [MBProgressHUD showHUDMsg: @"请打开允许访问相册权限" ];
//    }
//}
//
////相机选的图片
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
//{
//    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    [self.dataArray addObject:image];
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    self.signTeamPhotosView.dataArr = self.dataArray;
//    self.signTeamPhotosView.maxImageCount = 1;
//}
//
////取消按钮
//- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picke{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//// 相册选的图片
//- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
//    [self.dataArray addObjectsFromArray:photos];
//    self.signTeamPhotosView.dataArr = self.dataArray;
//    self.signTeamPhotosView.maxImageCount = 1;
//}

- (UILabel *)title_label {
    if (_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.XFJ_centerX, 6, 100, 44)];
        _title_label.text = @"签到点信息";
        _title_label.textColor = kColor6565;
        _title_label.textAlignment = NSTextAlignmentCenter;
    }
    return _title_label;
}

- (XFJMaskView *)maskView1 {
    if (_maskView1 == nil) {
        _maskView1 = [[XFJMaskView alloc] initWithFrame:CGRectZero];
    }
    return _maskView1;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    isSelect = NO;
    self.navigationItem.titleView = self.title_label;
    self.view.backgroundColor = kColoreeee;
    [self cgreatUI];
    [self requestFindCustomAttrListMessage];
    
}

- (void)cgreatUI {
    // 数组初始化
    self.dataSource = [NSMutableArray array];
    self.singleDatasource = [NSMutableArray array];
    self.indexSet = [NSMutableSet set];
    self.indexArray = [NSMutableArray array];
    self.jsonDataSourceDic = [NSMutableDictionary dictionary];
    self.userIdDic = [NSMutableDictionary dictionary];
    self.keyArray = [NSMutableSet set];
    self.userSet = [NSMutableSet set];
    self.isRequireDic = [NSMutableDictionary dictionary];
    self.carPhotosWithPerfectView = [[XFJCarPhotosWithPerfectView alloc] init];
    self.upPhotosOpenTeamMessageView = [[XFJUpPhotosOpenTeamMessageView alloc] init];
    self.carPhotoArray = [NSMutableArray array];
    self.certificatePicArray = [NSMutableArray array];
    self.certifierArray = [NSMutableArray array];
    self.cachePicArray = [NSMutableArray array];
    self.imgPathArray = [NSMutableArray array];
    self.imgPathDic = [NSMutableDictionary dictionary];
    
    __weak __typeof(self)wself = self;
    self.maskView1.maskBlock = ^() {
        [wself.maskView1 removeFromSuperview];
    };
    
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, const_ScreenWidth, const_ScreenChinge(310))];
    self.backgroundView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.backgroundView];
    
    UIView *groundView = [[UIView alloc] initWithFrame:CGRectMake(const_ScreenChinge(8), const_ScreenChinge(8), const_ScreenWidth - const_ScreenChinge(16), const_ScreenChinge(135))];
    groundView.backgroundColor = [UIColor whiteColor];
    groundView.layer.cornerRadius = const_ScreenChinge(3);
    [self.backgroundView addSubview:groundView];
    
    self.signMessageTopVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(groundView.frame), const_ScreenChinge(38))];
    self.signMessageTopVeiw.backgroundColor = [UIColor colorWithHexString:@"0x8F8F8F"];
    [self.backgroundView addSubview:self.signMessageTopVeiw];
    
    UILabel *scienceLable = [[UILabel alloc] initWithFrame:CGRectMake(const_ScreenChinge(12), const_ScreenChinge(11), const_ScreenChinge(120), const_ScreenChinge(17))];
    scienceLable.textColor = [UIColor colorWithHexString:@"0xFFFFFF"];
    scienceLable.font = [UIFont fontWithName:PingFang size:const_ScreenChinge(14)];
    scienceLable.text =  self.taskRowsItem.attractionsName;
    [self.signMessageTopVeiw addSubview:scienceLable];
    
    UIImageView *picImage = [[UIImageView alloc] initWithFrame:CGRectMake(const_ScreenWidth - const_ScreenChinge(85), const_ScreenChinge(11), const_ScreenChinge(14), const_ScreenChinge(14))];
    picImage.image = [UIImage imageNamed:@"team"];
    [self.signMessageTopVeiw addSubview:picImage];
    
    UILabel *personNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(picImage.frame) + const_ScreenChinge(12), CGRectGetMinY(scienceLable.frame), const_ScreenChinge(50), const_ScreenChinge(17))];
    personNumLabel.textColor = [UIColor colorWithHexString:@"0xFFFFFF"];
    personNumLabel.font = [UIFont fontWithName:PingFang size:const_ScreenChinge(14)];
    personNumLabel.text = [NSString stringWithFormat:@"%ld人", self.taskRowsItem.checkinNumber];
    [self.signMessageTopVeiw addSubview:personNumLabel];
    [groundView addSubview:self.signMessageTopVeiw];
    
    UILabel *pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(scienceLable.frame), CGRectGetMaxY(self.signMessageTopVeiw.frame) + const_ScreenChinge(20), const_ScreenChinge(6), const_ScreenChinge(6))];
    pointLabel.backgroundColor = [UIColor colorWithHexString:@"0x5AD8CA"];
    pointLabel.layer.masksToBounds = YES;
    pointLabel.layer.cornerRadius = const_ScreenChinge(3);
    [groundView addSubview:pointLabel];
    
    UILabel *signInLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pointLabel.frame) + const_ScreenChinge(8), CGRectGetMaxY(self.signMessageTopVeiw.frame) + const_ScreenChinge(17), const_ScreenChinge(60), const_ScreenChinge(15))];
    signInLabel.textColor = [UIColor colorWithHexString:@"0x838383"];
    signInLabel.font = [UIFont fontWithName:PingFang size:const_ScreenChinge(13)];
    signInLabel.text = @"签到时间:";
    [groundView addSubview:signInLabel];
    
    UILabel *signInTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(signInLabel.frame) + const_ScreenChinge(10), CGRectGetMinY(signInLabel.frame), CGRectGetWidth(groundView.frame) - CGRectGetMaxX(signInLabel.frame) - const_ScreenChinge(20), CGRectGetHeight(signInLabel.frame))];
    signInTimeLabel.textColor = [UIColor colorWithHexString:@"0x2b2b2b"];
    signInTimeLabel.font = [UIFont fontWithName:PingFang size:const_ScreenChinge(13)];
    if (self.taskRowsItem.createtime != nil) {
        signInTimeLabel.text = self.taskRowsItem.createtime;
    } else {
        signInTimeLabel.text = @"该团队还未签到";
    }
    [groundView addSubview:signInTimeLabel];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(pointLabel.frame), CGRectGetMaxY(pointLabel.frame) + const_ScreenChinge(20), CGRectGetWidth(groundView.frame) - const_ScreenChinge(24), const_ScreenChinge(1))];
    lineLabel.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    [groundView addSubview:lineLabel];
    
    UILabel *point1Label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(pointLabel.frame), CGRectGetMaxY(lineLabel.frame) + const_ScreenChinge(18), CGRectGetWidth(pointLabel.frame), CGRectGetHeight(pointLabel.frame))];
    point1Label.backgroundColor = [UIColor colorWithHexString:@"0xFF4745"];
    point1Label.layer.masksToBounds = YES;
    point1Label.layer.cornerRadius = const_ScreenChinge(3);
    [groundView addSubview:point1Label];
    
    UILabel *signOutLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(signInLabel.frame), CGRectGetMaxY(lineLabel.frame) + const_ScreenChinge(16), CGRectGetWidth(signInLabel.frame), CGRectGetHeight(signInLabel.frame))];
    signOutLabel.textColor = [UIColor colorWithHexString:@"0x838383"];
    signOutLabel.font = [UIFont fontWithName:PingFang size:const_ScreenChinge(13)];
    signOutLabel.text = @"签退时间:";
    [groundView addSubview:signOutLabel];
    
    UILabel *signOutTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(signInTimeLabel.frame), CGRectGetMinY(signOutLabel.frame), CGRectGetWidth(signInTimeLabel.frame), CGRectGetHeight(signInTimeLabel.frame))];
    signOutTimeLabel.textColor = [UIColor colorWithHexString:@"0x2b2b2b"];
    signOutTimeLabel.font = [UIFont fontWithName:PingFang size:const_ScreenChinge(13)];
    if (self.taskRowsItem.createtime != nil) {
        signOutTimeLabel.text = self.taskRowsItem.createtime;
    } else {
        signOutTimeLabel.text = @"该团队还未签到";
    }
    [groundView addSubview:signOutTimeLabel];
    
    UIView *backGroundViews = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(groundView.frame) + const_ScreenChinge(8), const_ScreenWidth, CGRectGetHeight(self.backgroundView.frame) - CGRectGetHeight(groundView.frame) - const_ScreenChinge(16))];
    backGroundViews.backgroundColor = [UIColor whiteColor];
    [self.backgroundView addSubview:backGroundViews];
    
    UILabel *point2Label = [[UILabel alloc] initWithFrame:CGRectMake(const_ScreenChinge(18), const_ScreenChinge(16), CGRectGetWidth(point1Label.frame), CGRectGetHeight(point1Label.frame))];
    point2Label.backgroundColor = [UIColor colorWithHexString:@"0x16A7B8"];
    point2Label.layer.masksToBounds = YES;
    point2Label.layer.cornerRadius = const_ScreenChinge(3);
    [backGroundViews addSubview:point2Label];
    
    UILabel *certificateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(point2Label.frame) + const_ScreenChinge(8), const_ScreenChinge(13), const_ScreenChinge(100), const_ScreenChinge(14))];
    certificateLabel.text = @"凭证照片";
    certificateLabel.textColor = [UIColor colorWithHexString:@"0x2b2b2b"];
    certificateLabel.font = [UIFont fontWithName:PingFang size:const_ScreenChinge(14)];
    [backGroundViews addSubview:certificateLabel];
    
    addPicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addPicButton.frame = CGRectMake(CGRectGetMinX(point2Label.frame), CGRectGetMaxY(certificateLabel.frame) + const_ScreenChinge(12), const_ScreenChinge(101), const_ScreenChinge(102));
    [addPicButton addTarget:self action:@selector(selectPicture:) forControlEvents:UIControlEventTouchUpInside];
    if (self.taskRowsItem.taskImg == nil || [self.taskRowsItem.taskImg isEqualToString:@""]) {
        [addPicButton setImage:[UIImage imageNamed:@"add-img-"] forState:UIControlStateNormal];
    } else {
        [addPicButton sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMAGEVIEWBASEURL,self.taskRowsItem.taskImg]] forState:UIControlStateNormal];
    }
    [backGroundViews addSubview:addPicButton];
    
    UIImageView *starimageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(addPicButton.frame) + const_ScreenChinge(10), CGRectGetMaxY(addPicButton.frame) - const_ScreenChinge(10), const_ScreenChinge(6), const_ScreenChinge(6))];
    starimageView.image = [UIImage imageNamed:@"xinghao"];
    [backGroundViews addSubview:starimageView];
    
    UILabel *pictureLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxY(starimageView.frame) + const_ScreenChinge(3), CGRectGetMidY(starimageView.frame) - const_ScreenChinge(10), const_ScreenWidth - CGRectGetMaxX(starimageView.frame) - const_ScreenChinge(10), const_ScreenChinge(20))];
    pictureLabel.text = @"此照片为您在签到点填写的团队确认凭证";
    pictureLabel.textColor = kColorBCBC;
    pictureLabel.font = [UIFont systemFontOfSize:const_ScreenChinge(12)];
    [backGroundViews addSubview:pictureLabel];
    
    
    UIView *backHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, const_ScreenWidth, const_ScreenChinge(310))];
    backHeaderView.backgroundColor = kColoreeee;
    [backHeaderView addSubview:self.backgroundView];
    
    self.attrList_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, const_ScreenWidth, const_ScreenHeight) style:UITableViewStyleGrouped];
    self.attrList_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.attrList_tableView.backgroundColor = [UIColor whiteColor];
    self.attrList_tableView.delegate = self;
    self.attrList_tableView.dataSource = self;
    [self.view addSubview:self.attrList_tableView];
    self.attrList_tableView.tableHeaderView = backHeaderView;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, const_ScreenWidth, const_ScreenChinge(82))];
    UIButton *sureUploadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureUploadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureUploadButton.layer.masksToBounds = YES;
    sureUploadButton.layer.cornerRadius = const_ScreenChinge(5);
    [sureUploadButton setTitle:@"确认上传" forState:UIControlStateNormal];
    [sureUploadButton addTarget:self action:@selector(clickCommitButton:) forControlEvents:UIControlEventTouchUpInside];
    sureUploadButton.backgroundColor = [UIColor redColor];
    sureUploadButton.frame = CGRectMake(const_ScreenChinge(18), const_ScreenChinge(20), SCREEN_WIDTH - const_ScreenChinge(36), const_ScreenChinge(42));
    [footerView addSubview:sureUploadButton];
    self.attrList_tableView.tableFooterView = footerView;
    
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
    
    
    [self.attrList_tableView registerClass:[XFJFirestAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJFirestAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJSecondAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJSecondAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJThirdAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJThirdAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJFourAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJFourAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJFiveAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJFiveAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJSixAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJSixAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJSevenTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJSevenTableViewCell];
    [self.attrList_tableView registerClass:[XFJEigthAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJEigthAttributeTableViewCell];
    
}



#pragma mark - 数据请求

- (void)requestFindCustomAttrListMessage {
    NSDictionary *dictParams = @{
                                 @"teamId":[NSString stringWithFormat:@"%ld", self.taskRowsItem.teamId],
                                 @"attractionsId":[NSString stringWithFormat:@"%ld", self.taskRowsItem.attractionsId],
                                 @"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"],
                                 @"teamAttractionsType":@1
                                 };
    [GRNetRequestClass GET:FINDCUSTOMESURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *rowsDictionaryArray = [NSMutableArray array];
        NSMutableSet *dataSet = [NSMutableSet set];
        if (responseObject) {
            NSArray *rowsArray = responseObject[@"rows"];
            for (NSDictionary *dic in rowsArray) {
                FindTeamTaskModel *model = [[FindTeamTaskModel alloc] init];
                model.Uid = dic[@"id"];
                [model setValuesForKeysWithDictionary:dic];
                [rowsDictionaryArray addObject:model];
                
                NSString *userId = dic[@"userId"];
                [dataSet addObject:userId];
            }
            self.sectionArray = [dataSet allObjects];
            
            for (NSString *keyId in self.sectionArray) {
                NSMutableArray *array = [NSMutableArray array];
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                for (FindTeamTaskModel *model in rowsDictionaryArray) {
                    if ([[NSString stringWithFormat:@"%@", keyId] isEqualToString:[NSString stringWithFormat:@"%@", model.userId]]) {
                        [array addObject:model];
                    }
                    [dic setValue:array forKey:keyId];
                }
                [self.dataSource addObject:dic];
            }
            [self.attrList_tableView reloadData];
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"___________返回错误的信息是 :%@",error);
        }
    }];
}


- (void)requestGetfindParamDataWithStr:(NSString *)backStr userId:(NSString *)userId{
    [GRNetRequestClass POST:FINDPARAMSSYSTEMLISTURL params:@{@"types":backStr} success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.singleDatasource removeAllObjects];
        NSArray *rowsArray = responseObject[@"rows"];
        for (NSDictionary *dic in rowsArray) {
            SingleListModel *model = [[SingleListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            model.singleId = dic[@"id"];
            [self.singleDatasource addObject:model];
        }
        [self.singleTableView reloadData];
        [self.mulit_SelectTableView reloadData];
        [self.dropTableView reloadData];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

#pragma mark - UITableViewDelegate 代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.attrList_tableView) return 30;
    else return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.attrList_tableView) {
        UITableViewHeaderFooterView *listHeaderView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"listHeader"];
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        backgroundView.backgroundColor = kColoreeee;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 150, 20)];
        titleLabel.font = [UIFont systemFontOfSize:13];
        [backgroundView addSubview:titleLabel];
        [listHeaderView addSubview:backgroundView];
        if (tableView == self.attrList_tableView) {
            NSString *key = [self.sectionArray objectAtIndex:section];
            for (NSDictionary *dic in self.dataSource) {
                NSArray *arr = dic[key];
                for (FindTeamTaskModel *model in arr) {
                    titleLabel.text = model.userName;
                }
            }
        }
        return listHeaderView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.singleTableView) {
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.attrList_tableView) {
        NSString *key = self.sectionArray[indexPath.section];
        NSArray *array = [[self.dataSource objectAtIndex:indexPath.section] objectForKey:key];
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
    } else if (tableView == self.singleTableView || tableView == self.mulit_SelectTableView || tableView == self.dropTableView) return 44;
    return 0;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.attrList_tableView) return self.sectionArray.count;
    if (tableView == self.singleTableView || tableView == self.mulit_SelectTableView || tableView == self.dropTableView) return 1;
    else return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.attrList_tableView) {
        NSString *key = self.sectionArray[section];
        NSInteger count = [[[self.dataSource objectAtIndex:section] objectForKey:key] count];
        return count;
    } else if (tableView == self.singleTableView || tableView == self.mulit_SelectTableView || tableView == self.dropTableView) return self.singleDatasource.count;
    else return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.attrList_tableView) {
        NSString *key = self.sectionArray[indexPath.section];
        NSArray *dataArray = [[self.dataSource objectAtIndex:indexPath.section] objectForKey:key];
        FindTeamTaskModel *model = dataArray[indexPath.row];
        NSString *ty_pe = model.attrType; //行
        
        if ([ty_pe intValue] == 0) {
            // 单行文本
            XFJFirestAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJFirestAttributeTableViewCell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userId = model.userId;
            cell.teamAttr = model.teamAttr;
            if (model.isRequire == 1) {
                // 添加到字典
                [self.isRequireDic setValue:model.attrName forKey:model.teamAttr];
            }
            cell.secondTextBlock = ^(NSString *textFieldText, NSString *teamAtt, NSString *userId) {
                [self.jsonDataSourceDic setValue:textFieldText forKey:teamAtt];
                if (model.isRequire == 1) {
                    [self.keyArray addObject:teamAtt];
                }
            };
            return cell;
        }else if ([ty_pe intValue] == 1) {
            // 数字
            XFJSecondAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJSecondAttributeTableViewCell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.teamAttr = model.teamAttr;
            if (model.isRequire == 1) {
                // 添加到字典
                [self.isRequireDic setValue:model.attrName forKey:model.teamAttr];
            }
            cell.mulitBlock = ^(NSString *textFieldText, NSString *teamAtt) {
                [self.jsonDataSourceDic setValue:textFieldText forKey:teamAtt];
                if (model.isRequire == 1) {
                    [self.keyArray addObject:teamAtt];
                }
            };
            return cell;
        }else if ([ty_pe intValue] == 3) {
            // 单选框
            attributeCell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJFourAttributeTableViewCell forIndexPath:indexPath];
            attributeCell.selectionStyle = UITableViewCellSelectionStyleNone;
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
                [weakSelf requestGetfindParamDataWithStr:typesStr userId:model.userId];
                
                if (model.isRequire == 1) {
                    [weakSelf.keyArray addObject:typesStr];
                }
                
            };
            return attributeCell;
        }else if ([ty_pe intValue] == 5) {
            // 下拉框
            fiveCell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJFiveAttributeTableViewCell forIndexPath:indexPath];
            fiveCell.selectionStyle = UITableViewCellSelectionStyleNone;
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
                [weakSelf requestGetfindParamDataWithStr:typeStr userId:model.userId];
                
                if (model.isRequire == 1) {
                    [weakSelf.keyArray addObject:typeStr];
                }
            };
            return fiveCell;
        }else if ([ty_pe intValue] == 6) {
            // 日期选择
            XFJSixAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJSixAttributeTableViewCell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
                self.pictureArr = picArray;
                [self.jsonDataSourceDic setValue:model.attrName forKey:teamAttr];
                [self.cachePicArray addObject:teamAttr];
                
                NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
                NSString *teamAttPath = [cachePath stringByAppendingPathComponent:teamAttr];
                NSFileManager *fileManager = [NSFileManager defaultManager];
                [fileManager removeItemAtPath:teamAttPath error:nil];
                if (![fileManager fileExistsAtPath:teamAttPath]) {
                    [fileManager createDirectoryAtPath:teamAttPath withIntermediateDirectories:YES attributes:nil error:nil];
                }
                for (UIImage *picImg in self.pictureArr) {
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
            mulit_SelectCell.selectionStyle = UITableViewCellSelectionStyleNone;
            mulit_SelectCell.teamAttr = model.teamAttr;
            if (model.isRequire == 1) {
                // 添加到字典
                [self.isRequireDic setValue:model.attrName forKey:model.teamAttr];
            }
            __weak __typeof(self)wself = self;
            mulit_SelectCell.presentMaskViewBlock = ^(NSString *typesStr) {
                [wself.maskView1 addSubview:wself.multi_SelectView];
                [[UIApplication sharedApplication].keyWindow addSubview:wself.maskView1];
                [wself.indexArray removeAllObjects];
                [wself requestGetfindParamDataWithStr:typesStr userId:model.userId];
                
                if (model.isRequire == 1) {
                    [wself.keyArray addObject:typesStr];
                }
            };
            return mulit_SelectCell;
        }
    } else if (tableView == self.singleTableView) {
        // 单选框
        SingleListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"singleCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        SingleListModel *model = self.singleDatasource[indexPath.row];
        cell.nameLabel.text = model.name;
        return cell;
        
    } else if (tableView == self.mulit_SelectTableView) {
        // 多选框
        MulitSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mulit_selectCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        SingleListModel *model = self.singleDatasource[indexPath.row];
        cell.nameLabel.text = model.name;
        return cell;
        
    } else if (tableView == self.dropTableView) {
        // 下拉框
        DropDownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dropCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        SingleListModel *model = self.singleDatasource[indexPath.row];
        cell.nameLabel.text = model.name;
        return cell;
        
    }
    return nil;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [addPicButton setImage:image forState:UIControlStateNormal];
    [self.certifierArray addObject:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 按钮点击事件
// 选择图片的按钮
- (void)selectPicture:(UIButton *)sender {
    [self.certifierArray removeAllObjects];
    UIImagePickerController *imagePickerViewController = [[UIImagePickerController alloc] init];
    imagePickerViewController.delegate = self;
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择类型" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePickerViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerViewController animated:YES completion:nil];
    }];
    UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePickerViewController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerViewController animated:YES completion:nil];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertControl addAction:cameraAction];
    [alertControl addAction:libraryAction];
    [alertControl addAction:cancleAction];
    [self.navigationController presentViewController:alertControl animated:YES completion:nil];
}

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
    if ([self.indexSet allObjects].count > 0) {
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
}

- (void)dropAction:(UIButton *)sender {
    if (self.singleDatasource.count > 0) {
        // 下拉的选择之后的
        SingleListModel *model = self.singleDatasource[dropIndex.row];
        fiveCell.teamPropertiesContent_label.text = model.name;
        [self.jsonDataSourceDic setValue:model.name forKey:model.types];
    }
    [self.maskView1 removeFromSuperview];
    [self.dropView removeFromSuperview];
    [self.dropTableView reloadData];
}

- (void)clickCommitButton:(UIButton *)sender {
    NSMutableSet *keySet = [NSMutableSet setWithArray:[self.isRequireDic allKeys]];
    [keySet minusSet:self.keyArray];
    
    if (keySet.count > 0) {
        NSArray *array = [keySet allObjects];
        for (NSString *key in array) {
            NSString *name = [self.isRequireDic objectForKey:key];
            [MBProgressHUD showHudTipStr:[NSString stringWithFormat:@"%@不能为空", name] contentColor:HidWithColorContentBlack];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hidenHud];
        });
    } else {
        [MBProgressHUD showLoadHUD];
        [self upLoadPic];
        [self upLoadVoucherPic];
        
    }
    
}


#pragma mark - 图片上传车辆照片
- (void)upLoadPic {
    if (self.certifierArray.count > 0) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager POST:UPLOADIMAGE parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            UIImage *cerfierPic = [self.certifierArray firstObject];
            NSData *imageData = [UIImage compressImage:cerfierPic maxSize:300];
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.jpg" mimeType:@"image/jpg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"%f", uploadProgress.fractionCompleted);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            // 获取的凭证图片参数
            self.taskImg = responseObject[@"object"];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"上传图片失败--------%@",error);
        }];
    }
}

#pragma mark - 上传图片
- (void)upLoadVoucherPic {
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
                        [self sureCommitWithAttributeTeamId:self.taskRowsItem.teamId];
                    }
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@", error);
            }];
        }
    }
}


#pragma mark - 完善资料的确认提交
- (void)sureCommitWithAttributeTeamId:(NSInteger)teamId {
    
    NSMutableSet *dataArray = [NSMutableSet set];
    for (NSString *key in self.sectionArray) {
        NSMutableSet *set = [NSMutableSet set];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        for (NSDictionary *dic in self.dataSource ) {
            for (FindTeamTaskModel *model in dic[key]) {
                for (NSString *teamAtt in [self.jsonDataSourceDic allKeys]) {
                    if (model.teamAttr == teamAtt) {
                        [dictionary setValue:[self.jsonDataSourceDic objectForKey:teamAtt] forKey:teamAtt];
                    }
                }
            }
            [set addObject:dictionary];
            [dict setValue:[[set allObjects] firstObject] forKey:[NSString stringWithFormat:@"%@", key]];
            [dataArray addObject:dict];
        }
    }
    NSMutableArray *dataSourceArray = [NSMutableArray array];
    for (NSDictionary *dic in [dataArray allObjects]) {
        for (NSString *key in [dic allKeys]) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:dic[key] options:NSJSONWritingPrettyPrinted error:nil];
            NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@"\"" withString:@"'"];
            string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            [dataSourceArray addObject:string];
        }
    }
    
    NSString *str = [dataSourceArray componentsJoinedByString:@"#"];
    self.finalStr = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    if (self.taskImg == nil) {
        self.taskImg = @"";
    }
    
    NSDictionary *paramDic = @{@"id": [NSString stringWithFormat:@"%ld", self.taskRowsItem.taskId],
                               @"teamId": [NSString stringWithFormat:@"%ld", self.taskRowsItem.teamId],
                               @"attractionsId": [NSString stringWithFormat:@"%ld",self.taskRowsItem.attractionsId],
                               @"taskImg": [NSString stringWithFormat:@"%@", self.taskImg],
                               @"taskBack": [NSString stringWithFormat:@"%@", self.finalStr]};
    
    if (self.sectionArray.count == 1) {
        // 单个管理员的数据上传
        [manager POST:TASKPERFECTURL parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD hidenHud];
            if ([responseObject[@"success"] integerValue] == 1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    } else if(self.sectionArray.count > 1){
        // 多个管理员的数据上传
        [manager POST:TASKSPERFECTURL parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD hidenHud];
            if ([responseObject[@"success"] integerValue] == 1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    }
    
}


@end
//TASKSPERFECTURL
