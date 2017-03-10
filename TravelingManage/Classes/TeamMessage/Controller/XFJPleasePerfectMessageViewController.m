//
//  XFJPleasePerfectMessageViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/6.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

//跳转到完善资料控制器
#import "XFJPleasePerfectMessageViewController.h"
#import "XFJPleasePerfectMessageTopView.h"
#import "XFJPleaseUpPerfectPhotosView.h"
#import "TZImagePickerController.h"
#import "WSImagePickerView.h"
#import "WSPhotosBroseVC.h"
#import "XFJSignPhotosMessageTableViewCell.h"
#import "XFJFindTeamTasksItem.h"

@interface XFJPleasePerfectMessageViewController () <UIActionSheetDelegate,XFJPleaseUpPerfectPhotosViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource,XFJSignPhotosMessageTableViewCellDelegate>

@property (nonatomic, strong) UILabel *title_label;
@property (nonatomic, strong) XFJPleasePerfectMessageTopView *pleasePerfectMessageTopView;
@property (nonatomic, strong) XFJPleaseUpPerfectPhotosView *pleaseUpPerfectPhotosView;
@property (nonatomic, assign) NSInteger maxImageCount;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *dataArray;
//@property (nonatomic, strong) UITableView *signPhotos_tableView;
@property (nonatomic, strong) XFJSignPhotosMessageTableViewCell *cell;
@property (nonatomic, strong) NSMutableArray <XFJFindTeamTasksItem *> *findTeamTasksItem;
@property (nonatomic, strong) UIView *headerView;
@end

@implementation XFJPleasePerfectMessageViewController
#pragma mark ---- lazy ----
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 265)];
        _headerView.backgroundColor = [UIColor yellowColor];
    }
    return _headerView;
}

- (NSMutableArray <XFJFindTeamTasksItem *> *)findTeamTasksItem
{
    if (_findTeamTasksItem == nil) {
        _findTeamTasksItem = [NSMutableArray array];
    }
    return _findTeamTasksItem;
}

//顶部信息
- (XFJPleasePerfectMessageTopView *)pleasePerfectMessageTopView
{
    if (_pleasePerfectMessageTopView == nil) {
        _pleasePerfectMessageTopView = [[XFJPleasePerfectMessageTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 86)];
        _pleasePerfectMessageTopView.backgroundColor = [UIColor  whiteColor];
    }
    return _pleasePerfectMessageTopView;
}
//可上传的6张图片
- (XFJPleaseUpPerfectPhotosView *)pleaseUpPerfectPhotosView
{
    if (_pleaseUpPerfectPhotosView == nil) {
        _pleaseUpPerfectPhotosView = [[XFJPleaseUpPerfectPhotosView alloc] initWithFrame:CGRectMake(0, 86, SCREEN_WIDTH, 180)];
        _pleaseUpPerfectPhotosView.backgroundColor = [UIColor whiteColor];
        _pleaseUpPerfectPhotosView.delegate = self;
    }
    return _pleaseUpPerfectPhotosView;
}
//导航栏标题
- (UILabel *)title_label
{
    if (_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.XFJ_centerX, 6, 100, 44)];
        _title_label.text = @"完善资料";
        _title_label.textColor = kColor6565;
        _title_label.textAlignment = NSTextAlignmentCenter;
    }
    return _title_label;
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

#pragma mark ---- viewDidLoad ----
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = self.headerView;
    [self setInitWithNav];
    NSLog(@"-----++++++++++++传过来的TeamId是:%zd",self.teamId);
    //请求顶部的数据信息
    [self requestTopPerfectMessage];
}

#pragma mark ---- setInitWithNav ----
- (void)setInitWithNav
{
    self.navigationItem.titleView = self.title_label;
    [self.headerView addSubview:self.pleasePerfectMessageTopView];
    [self.headerView addSubview:self.pleaseUpPerfectPhotosView];
//    [self.headerView addSubview:self.signPhotos_tableView];
}

#pragma mark ---- 网络请求 ----
- (void)requestTopPerfectMessage
{
    NSDictionary *dictParams = @{
                                 @"id":[NSString stringWithFormat:@"%zd",self.teamId]
                                 };
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:FINDTEAMINFOTASKSURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSLog(@"------------++++++++++++获取到的值是 :%@",responseObject);
            wself.findTeamTasksItem = [XFJFindTeamTasksItem mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"rows"]];
            wself.pleasePerfectMessageTopView.findTeamTasksItem = wself.findTeamTasksItem;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"---------+++++++++没得到后台返回的值,打印错误信息是 :%@",error);
        }
    }];
}



#pragma mark ---- 访问相机 ----
- (void)chooseImage:(XFJPleaseUpPerfectPhotosView *)SerPhotoCell
{
    self.maxImageCount = 6;
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"请选择相机或者相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择",nil];
    [action showInView:self.view];
}

- (void)chooseVoucherPhotosImage:(XFJSignPhotosMessageTableViewCell *)voucherPhotos
{
    self.maxImageCount = 1;
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"请选择相机或者相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择",nil];
    [action showInView:self.view];
}

- (void)jumpCell:(XFJPleaseUpPerfectPhotosView *)cell indexPath:(NSIndexPath *)indexPath
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
                weakself.pleaseUpPerfectPhotosView.dataArr = _dataArr;
                if (_dataArr.count < 4) {
                    self.pleaseUpPerfectPhotosView.frame = CGRectMake(0, 86, SCREEN_WIDTH, 180);
                    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 265);
                    [self.tableView reloadData];
                }
            });
        };
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)jumpToCell:(XFJSignPhotosMessageTableViewCell *)cell indexPath:(NSIndexPath *)indexPath
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
                weakself.cell.dataArr = _dataArray;
//                                if (_dataArr.count <= 4) {
//                                    self.uploadPhotos_view.frame = CGRectMake(0, 728, SCREEN_WIDTH, 200);
//                                }
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
        self.pleaseUpPerfectPhotosView.dataArr = self.dataArr;
        self.pleaseUpPerfectPhotosView.maxImageCount = 6;
    }else {
        NSLog(@"self.maxImageCount == 1");
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.dataArray addObject:image];
        [picker dismissViewControllerAnimated:YES completion:nil];
        self.pleaseUpPerfectPhotosView.dataArr = self.dataArray;
        self.pleaseUpPerfectPhotosView.maxImageCount = 1;
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
        self.pleaseUpPerfectPhotosView.dataArr = self.dataArr;
        self.pleaseUpPerfectPhotosView.maxImageCount = 6;
        if (self.dataArr.count >= 4) {
            self.pleaseUpPerfectPhotosView.frame = CGRectMake(0, 86, SCREEN_WIDTH, 260);
            self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 345);
            [self.tableView reloadData];
        }
    }else {
        NSLog(@"self.maxImageCount == 1----------");
        [self.dataArray addObjectsFromArray:photos];
        self.cell.dataArr = self.dataArray;
        self.cell.maxImageCount = 1;
//        [self.signPhotos_tableView reloadData];
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
    NSString *const cellId = @"cellId";
    XFJSignPhotosMessageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.cell = cell;
    cell.dataArr = self.dataArray;
    NSLog(@"++++++++++++++++选取到的照片数量是 :%@",self.dataArray);
    if (cell == nil) {
        cell = [[XFJSignPhotosMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

@end
