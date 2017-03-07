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


@interface XFJTeamMessageViewController () <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,XFJCarPhotosWithPerfectViewDelegate,XFJUpPhotosOpenTeamMessageViewDelegate,UITableViewDelegate,UITableViewDataSource>

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

@end

@implementation XFJTeamMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setInitWithNav];
    
    [self.view addSubview:self.scroll_view];
    [self.scroll_view addSubview:self.backGround_view];
    [self.scroll_view addSubview:self.pleasePerfectView];
    [self.scroll_view addSubview:self.generalMessageView];
    [self.scroll_view addSubview:self.otherMessagePerfectView];
    [self.backGround_view addSubview:self.carPhotosWithPerfectView];
    [self.backGround_view addSubview:self.upPhotosOpenTeamMessageView];
    [self.scroll_view addSubview:self.teamMessageBottomView];
    [self.scroll_view addSubview:self.attrList_tableView];
    
    self.view.backgroundColor = [UIColor redColor];
    
    NSLog(@"-------------self.findTeamInfoByState_Id的结果是 :%zd",self.findTeamInfoByState_Id);
    
    self.teamMessageBottomView.findTeamInfoByState_Id = self.findTeamInfoByState_Id;
    
    //请求到的自定页面数据
    [self requestTeamMessage];
    
    //请求自定义字段数据
    [self requestFindCustomAttrListMessage:self.findTeamInfoByState_Id];
    __weak __typeof(self)wself = self;
    self.teamMessageBottomView.sureCommitBlock = ^(NSInteger teamId) {
      //弹出确认提交和上传附件弹窗
        [wself sureAndCommitShow:teamId];
    };
    [self.backGround_view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(340.0);
        make.top.mas_equalTo(self.attrList_tableView.mas_bottom);
    }];
    [self.teamMessageBottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(300.0);
        make.top.mas_equalTo(self.upPhotosOpenTeamMessageView.mas_bottom);
    }];
    [self.attrList_tableView registerClass:[XFJFirestAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJFirestAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJSecondAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJSecondAttributeTableViewCell];
}

- (NSMutableArray <XFJFindCustomAttrListItem *> *)findCustomAttrListItemArray
{
    if (_findCustomAttrListItemArray == nil) {
        _findCustomAttrListItemArray = [NSMutableArray array];
    }
    return _findCustomAttrListItemArray;
}

#pragma mark - 确认提交和上传附件
- (void)sureAndCommitShow:(NSInteger)teamId
{
    UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"提交完成!" preferredStyle:UIAlertControllerStyleAlert];
    __weak __typeof(self)wself = self;
    [alertVc addAction:[UIAlertAction actionWithTitle:@"上传附件" style: UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
        NSLog(@"主人~~您点击了上传附件按钮!");
        [wself jumpPleasePerfectMessage:teamId];
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"立即评价" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"主人~~您点击了立即评价按钮!");
        [wself jumpPleaseAppraise:teamId];
    }]];
    [self presentViewController:alertVc animated:NO completion:nil];
}

- (UIView *)backGround_view
{
    if (_backGround_view == nil) {
        _backGround_view = [[UIView alloc] init];
        _backGround_view.backgroundColor = [UIColor redColor];
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
        _attrList_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 323, SCREEN_WIDTH, 90) style:UITableViewStylePlain];
        _attrList_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _attrList_tableView.backgroundColor = [UIColor redColor];
        _attrList_tableView.delegate = self;
        _attrList_tableView.dataSource = self;
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
            wself.findTeamTasksItemArray = [XFJFindTeamTasksItem mj_objectArrayWithKeyValuesArray:findArray];
            wself.generalMessageView.findTeamTasksItem = wself.findTeamTasksItemArray;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"++++++++获取团队信息资料失败的是 :%@",error);
        }
    }];
}

#pragma mark - 加载自定义字段数据
- (void)requestFindCustomAttrListMessage:(NSInteger)teamId
{
    NSDictionary *dictParams = @{
                                 @"teamId":@7,
                                 @"teamAttractionsType":@0
                                 };
    __weak __typeof(self)wself = self;
    NSLog(@"-------------自定义字段参数是 :%@",dictParams);
    [GRNetRequestClass GET:FINDCUSTOMATTRLISTURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSMutableArray *rowsArray = [responseObject objectForKey:@"rows"];
            wself.findCustomAttrListItemArray = [XFJFindCustomAttrListItem mj_objectArrayWithKeyValuesArray:rowsArray];
            NSLog(@"+++++++++++返回的自定字段信息是 :%@",wself.findCustomAttrListItemArray);
            [wself.attrList_tableView reloadData];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"___________返回错误的信息是 :%@",error);
        }
    }];
}

- (UIScrollView *)scroll_view
{
    if (_scroll_view == nil) {
        _scroll_view = [[UIScrollView alloc] init];
        _scroll_view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 1.2 * self.view.XFJ_Height);
        _scroll_view.contentSize = CGSizeMake(0, self.view.XFJ_Height * 2.5);
        _scroll_view.backgroundColor = kColoreeee;
        _scroll_view.showsHorizontalScrollIndicator = NO;
        _scroll_view.scrollEnabled = YES;
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
        _generalMessageView = [[XFJGeneralMessageView alloc] initWithFrame:CGRectMake(0, 73, SCREEN_WIDTH, 220)];
        _generalMessageView.backgroundColor = [UIColor whiteColor];
    }
    return _generalMessageView;
}

- (XFJOtherMessagePerfectView *)otherMessagePerfectView
{
    if (_otherMessagePerfectView == nil) {
        _otherMessagePerfectView = [[XFJOtherMessagePerfectView alloc] initWithFrame:CGRectMake(0, 293, SCREEN_WIDTH, 100)];
        _otherMessagePerfectView.backgroundColor = [UIColor whiteColor];
    }
    return _otherMessagePerfectView;
}

- (XFJCarPhotosWithPerfectView *)carPhotosWithPerfectView
{
    if (_carPhotosWithPerfectView == nil) {
        _carPhotosWithPerfectView = [[XFJCarPhotosWithPerfectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
        _carPhotosWithPerfectView.backgroundColor = [UIColor whiteColor];
        _carPhotosWithPerfectView.delegate = self;
    }
    return _carPhotosWithPerfectView;
}
- (XFJUpPhotosOpenTeamMessageView *)upPhotosOpenTeamMessageView
{
    if (_upPhotosOpenTeamMessageView == nil) {
        _upPhotosOpenTeamMessageView = [[XFJUpPhotosOpenTeamMessageView alloc] initWithFrame:CGRectMake(0, 170, SCREEN_WIDTH, 170)];
        _upPhotosOpenTeamMessageView.backgroundColor = [UIColor whiteColor];
        _upPhotosOpenTeamMessageView.delegate = self;
    }
    return _upPhotosOpenTeamMessageView;
}

- (XFJTeamMessageBottomView *)teamMessageBottomView
{
    if (_teamMessageBottomView == nil) {
        _teamMessageBottomView = [[XFJTeamMessageBottomView alloc] init];
        _teamMessageBottomView.backgroundColor = [UIColor whiteColor];
    }
    return _teamMessageBottomView;
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

#pragma makr - 访问照相机
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

- (void)jumpCell:(XFJCarPhotosWithPerfectView *)cell indexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    if(indexPath.row < _dataArr.count) {
        for (UIImage *image in _dataArr) {
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
                //                if (_dataArr.count <= 4) {
                //                    self.uploadPhotos_view.frame = CGRectMake(0, 728, SCREEN_WIDTH, 200);
                //                }
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
        [self.dataArr addObject:image];
        [picker dismissViewControllerAnimated:YES completion:nil];
        self.carPhotosWithPerfectView.dataArr = self.dataArr;
        self.carPhotosWithPerfectView.maxImageCount = 6;
    }else {
        NSLog(@"self.maxImageCount == 1");
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.dataArray addObject:image];
        [picker dismissViewControllerAnimated:YES completion:nil];
        self.upPhotosOpenTeamMessageView.dataArr = self.dataArray;
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
        [self.dataArr addObjectsFromArray:photos];
        self.carPhotosWithPerfectView.dataArr = self.dataArr;
        self.carPhotosWithPerfectView.maxImageCount = 6;
        if (self.dataArr.count < 4) {
        }else {
            self.carPhotosWithPerfectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 230);
            self.upPhotosOpenTeamMessageView.frame = CGRectMake(0, 230, SCREEN_WIDTH, 170);
        }
    }else {
        NSLog(@"self.maxImageCount == 1----------");
        [self.dataArray addObjectsFromArray:photos];
        self.upPhotosOpenTeamMessageView.dataArr = self.dataArray;
        self.upPhotosOpenTeamMessageView.maxImageCount = 1;
    }
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
//    if (indexPath.row == 0) {
//        XFJFirestAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJFirestAttributeTableViewCell forIndexPath:indexPath];
//        return cell;
//    }else if (indexPath.row == 1) {
//        XFJSecondAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJSecondAttributeTableViewCell forIndexPath:indexPath];
//        return cell;
//    }
//    id obj = self.findCustomAttrListItemArray[indexPath.row];
//    if ([obj is]) {
//        <#statements#>
//    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.attrList_tableView.frame = CGRectMake(0, 323, SCREEN_WIDTH, 45 * self.findCustomAttrListItemArray.count);
    NSInteger cellHeight;
    if (indexPath.row == 0) {
        return 45.0;
    }else if (indexPath.row == 1) {
        return 45.0;
    }else if (indexPath.row == 2) {
        
    }
    return 45.0;
}





@end
